From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH] ALSA: HDA - Check return value to reduce
	useless delay
Date: Wed, 24 Oct 2012 14:53:23 +0800
Message-ID: <1351061603-2433-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 85B982651BF
 for <alsa-devel@alsa-project.org>; Wed, 24 Oct 2012 09:19:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

For verb 705h, it's useless to read response, so use *write api would be
better. If there's error after sending cmd, just try again without continue
after wrong operation.Otherwise there's long time delay.

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/pci/hda/hda_codec.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 960800b..0946eca 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3569,6 +3569,7 @@ static unsigned int hda_set_power_state(struct hda_codec *codec,
 	hda_nid_t fg = codec->afg ? codec->afg : codec->mfg;
 	int count;
 	unsigned int state;
+	int err;
 
 	/* this delay seems necessary to avoid click noise at power-down */
 	if (power_state == AC_PWRST_D3) {
@@ -3582,9 +3583,11 @@ static unsigned int hda_set_power_state(struct hda_codec *codec,
 			codec->patch_ops.set_power_state(codec, fg,
 							 power_state);
 		else {
-			snd_hda_codec_read(codec, fg, 0,
+			err = snd_hda_codec_write(codec, fg, 0,
 					   AC_VERB_SET_POWER_STATE,
 					   power_state);
+			if (err < 0)
+				continue;
 			snd_hda_codec_set_power_to_all(codec, fg, power_state,
 						       true);
 		}
-- 
1.7.9.5
