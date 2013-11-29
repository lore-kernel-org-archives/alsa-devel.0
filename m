From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - allow a codec to define its own
	depop delay time
Date: Fri, 29 Nov 2013 01:48:45 -0500
Message-ID: <3d67b671dcf410f23dd7147ba61a15c796292ca1.1385707582.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 43756261987
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 14:45:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This patch adds 'depop_delay' to struct hda_codec, to indicate a depop delay
time in ms when power-down, in function set_power_state() to D3.

Default value is -1, for a default delay time.
Machine fixup can set a suitable value according to the codec chip and HW audio
design.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 1e04a20..75ec91e 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1444,6 +1444,7 @@ int snd_hda_codec_new(struct hda_bus *bus,
 	INIT_LIST_HEAD(&codec->conn_list);
 
 	INIT_DELAYED_WORK(&codec->jackpoll_work, hda_jackpoll_work);
+	codec->depop_delay = -1;
 
 #ifdef CONFIG_PM
 	spin_lock_init(&codec->power_lock);
@@ -3901,8 +3902,10 @@ static unsigned int hda_set_power_state(struct hda_codec *codec,
 
 	/* this delay seems necessary to avoid click noise at power-down */
 	if (power_state == AC_PWRST_D3) {
-		/* transition time less than 10ms for power down */
-		msleep(codec->epss ? 10 : 100);
+		if (codec->depop_delay < 0)
+			msleep(codec->epss ? 10 : 100);
+		else if (codec->depop_delay > 0)
+			msleep(codec->depop_delay);
 		flags = HDA_RW_NO_RESPONSE_FALLBACK;
 	}
 
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index bedb436..efd0edc 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -943,6 +943,8 @@ struct hda_codec {
 	struct snd_array jacks;
 #endif
 
+	int depop_delay; /* depop delay in ms, -1 for default delay time */
+
 	/* fix-up list */
 	int fixup_id;
 	const struct hda_fixup *fixup_list;
-- 
1.8.1.2
