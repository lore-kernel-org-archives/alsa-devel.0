From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH V2] ALSA: hda - reduce msleep time if EPSS
	power states supported
Date: Thu,  7 Jun 2012 16:51:33 +0800
Message-ID: <1339059093-4097-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 23F242455F
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 10:56:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, david.henningsson@canonical.com
Cc: wangxingchao2011@gmail.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

if EPSS supported, transition from D3 state to D0 state in less
than 10ms

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/pci/hda/hda_codec.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index b89c8ec..2737fe7 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3532,8 +3532,11 @@ static void hda_set_power_state(struct hda_codec *codec, hda_nid_t fg,
 	}
 
 	/* this delay seems necessary to avoid click noise at power-down */
-	if (power_state == AC_PWRST_D3)
-		msleep(100);
+	if (power_state == AC_PWRST_D3) {
+		/* transition time less than 10ms for power down */
+		bool epss = snd_hda_codec_get_supported_ps(codec, fg, AC_PWRST_EPSS);
+		msleep(epss ? 10 : 100);
+	}
 	snd_hda_codec_read(codec, fg, 0, AC_VERB_SET_POWER_STATE,
 			    power_state);
 	snd_hda_codec_set_power_to_all(codec, fg, power_state, true);
-- 
1.7.9.5
