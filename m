From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix possible race on regmap bypass
	flip
Date: Thu, 21 Apr 2016 18:00:08 +0200
Message-ID: <1461254408-23836-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A2DF32612CC
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 18:00:10 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 46516ABBF
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 16:00:08 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

HD-audio driver uses regmap cache bypass feature for reading a raw
value without the cache.  But this is racy since both the cached and
the uncached reads may occur concurrently.  The former is done via the
normal control API access while the latter comes from the proc file
read.

Even though the regmap itself has the protection against the
concurrent accesses, the flag set/reset is done without the
protection, so it may lead to inconsistent state of bypass flag that
doesn't match with the current read and occasionally result in a
kernel WARNING like:
  WARNING: CPU: 3 PID: 2731 at drivers/base/regmap/regcache.c:499 regcache_cache_only+0x78/0x93

One way to work around such a problem is to wrap with a mutex.  But in
this case, the solution is simpler: for the uncached read, we just
skip the regmap and directly calls its accessor.  The verb execution
there is protected by itself, so basically it's safe to call
individually.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=116171
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hda_regmap.h |  2 ++
 sound/hda/hdac_device.c    | 10 ++++------
 sound/hda/hdac_regmap.c    | 40 ++++++++++++++++++++++++++++------------
 3 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/include/sound/hda_regmap.h b/include/sound/hda_regmap.h
index 2767c55a641e..ca64f0f50b45 100644
--- a/include/sound/hda_regmap.h
+++ b/include/sound/hda_regmap.h
@@ -17,6 +17,8 @@ int snd_hdac_regmap_add_vendor_verb(struct hdac_device *codec,
 				    unsigned int verb);
 int snd_hdac_regmap_read_raw(struct hdac_device *codec, unsigned int reg,
 			     unsigned int *val);
+int snd_hdac_regmap_read_raw_uncached(struct hdac_device *codec,
+				      unsigned int reg, unsigned int *val);
 int snd_hdac_regmap_write_raw(struct hdac_device *codec, unsigned int reg,
 			      unsigned int val);
 int snd_hdac_regmap_update_raw(struct hdac_device *codec, unsigned int reg,
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index d1a4d6973330..03c9872c31cf 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -299,13 +299,11 @@ EXPORT_SYMBOL_GPL(_snd_hdac_read_parm);
 int snd_hdac_read_parm_uncached(struct hdac_device *codec, hda_nid_t nid,
 				int parm)
 {
-	int val;
+	unsigned int cmd, val;
 
-	if (codec->regmap)
-		regcache_cache_bypass(codec->regmap, true);
-	val = snd_hdac_read_parm(codec, nid, parm);
-	if (codec->regmap)
-		regcache_cache_bypass(codec->regmap, false);
+	cmd = snd_hdac_regmap_encode_verb(nid, AC_VERB_PARAMETERS) | parm;
+	if (snd_hdac_regmap_read_raw_uncached(codec, cmd, &val) < 0)
+		return -1;
 	return val;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_read_parm_uncached);
diff --git a/sound/hda/hdac_regmap.c b/sound/hda/hdac_regmap.c
index bdbcd6b75ff6..87041ddd29cb 100644
--- a/sound/hda/hdac_regmap.c
+++ b/sound/hda/hdac_regmap.c
@@ -453,14 +453,30 @@ int snd_hdac_regmap_write_raw(struct hdac_device *codec, unsigned int reg,
 EXPORT_SYMBOL_GPL(snd_hdac_regmap_write_raw);
 
 static int reg_raw_read(struct hdac_device *codec, unsigned int reg,
-			unsigned int *val)
+			unsigned int *val, bool uncached)
 {
-	if (!codec->regmap)
+	if (uncached || !codec->regmap)
 		return hda_reg_read(codec, reg, val);
 	else
 		return regmap_read(codec->regmap, reg, val);
 }
 
+static int __snd_hdac_regmap_read_raw(struct hdac_device *codec,
+				      unsigned int reg, unsigned int *val,
+				      bool uncached)
+{
+	int err;
+
+	err = reg_raw_read(codec, reg, val, uncached);
+	if (err == -EAGAIN) {
+		err = snd_hdac_power_up_pm(codec);
+		if (!err)
+			err = reg_raw_read(codec, reg, val, uncached);
+		snd_hdac_power_down_pm(codec);
+	}
+	return err;
+}
+
 /**
  * snd_hdac_regmap_read_raw - read a pseudo register with power mgmt
  * @codec: the codec object
@@ -472,19 +488,19 @@ static int reg_raw_read(struct hdac_device *codec, unsigned int reg,
 int snd_hdac_regmap_read_raw(struct hdac_device *codec, unsigned int reg,
 			     unsigned int *val)
 {
-	int err;
-
-	err = reg_raw_read(codec, reg, val);
-	if (err == -EAGAIN) {
-		err = snd_hdac_power_up_pm(codec);
-		if (!err)
-			err = reg_raw_read(codec, reg, val);
-		snd_hdac_power_down_pm(codec);
-	}
-	return err;
+	return __snd_hdac_regmap_read_raw(codec, reg, val, false);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_regmap_read_raw);
 
+/* Works like snd_hdac_regmap_read_raw(), but this doesn't read from the
+ * cache but always via hda verbs.
+ */
+int snd_hdac_regmap_read_raw_uncached(struct hdac_device *codec,
+				      unsigned int reg, unsigned int *val)
+{
+	return __snd_hdac_regmap_read_raw(codec, reg, val, true);
+}
+
 /**
  * snd_hdac_regmap_update_raw - update a pseudo register with power mgmt
  * @codec: the codec object
-- 
2.8.1
