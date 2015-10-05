From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/4] ALSA: hdac: Add codec read/write and check
	power state for widgets
Date: Mon,  5 Oct 2015 15:09:51 +0100
Message-ID: <1444054191-17030-5-git-send-email-vinod.koul@intel.com>
References: <1444054191-17030-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7237826066D
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 16:10:55 +0200 (CEST)
In-Reply-To: <1444054191-17030-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>

This adds helpers to read/write the codec. Also adds a helper to check the
power state of widgets.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio.h |  6 ++++++
 sound/hda/hdac_device.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 49bc836fcd84..26e956f4b7c6 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -147,6 +147,12 @@ int snd_hdac_query_supported_pcm(struct hdac_device *codec, hda_nid_t nid,
 bool snd_hdac_is_supported_format(struct hdac_device *codec, hda_nid_t nid,
 				  unsigned int format);
 
+int snd_hdac_codec_read(struct hdac_device *hdac, hda_nid_t nid,
+			int flags, unsigned int verb, unsigned int parm);
+int snd_hdac_codec_write(struct hdac_device *hdac, hda_nid_t nid,
+			int flags, unsigned int verb, unsigned int parm);
+bool snd_hdac_check_power_state(struct hdac_device *hdac,
+		hda_nid_t nid, unsigned int target_state);
 /**
  * snd_hdac_read_parm - read a codec parameter
  * @codec: the codec object
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index db96042a497f..24c7a5f6f0f3 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -952,3 +952,50 @@ bool snd_hdac_is_supported_format(struct hdac_device *codec, hda_nid_t nid,
 	return true;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_is_supported_format);
+
+static unsigned int codec_read(struct hdac_device *hdac, hda_nid_t nid,
+			int flags, unsigned int verb, unsigned int parm)
+{
+	unsigned int cmd = snd_hdac_make_cmd(hdac, nid, verb, parm);
+	unsigned int res;
+
+	if (snd_hdac_exec_verb(hdac, cmd, flags, &res))
+		return -1;
+
+	return res;
+}
+
+static int codec_write(struct hdac_device *hdac, hda_nid_t nid,
+			int flags, unsigned int verb, unsigned int parm)
+{
+	unsigned int cmd = snd_hdac_make_cmd(hdac, nid, verb, parm);
+
+	return snd_hdac_exec_verb(hdac, cmd, flags, NULL);
+}
+
+int snd_hdac_codec_read(struct hdac_device *hdac, hda_nid_t nid,
+			int flags, unsigned int verb, unsigned int parm)
+{
+	return codec_read(hdac, nid, flags, verb, parm);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_codec_read);
+
+int snd_hdac_codec_write(struct hdac_device *hdac, hda_nid_t nid,
+			int flags, unsigned int verb, unsigned int parm)
+{
+	return codec_write(hdac, nid, flags, verb, parm);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_codec_write);
+
+bool snd_hdac_check_power_state(struct hdac_device *hdac,
+		hda_nid_t nid, unsigned int target_state)
+{
+	unsigned int state = codec_read(hdac, nid, 0,
+				AC_VERB_GET_POWER_STATE, 0);
+
+	if (state & AC_PWRST_ERROR)
+		return true;
+	state = (state >> 4) & 0x0f;
+	return (state == target_state);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_check_power_state);
-- 
2.4.3
