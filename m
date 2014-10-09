From: Harsha Priya <harshapriya.n@intel.com>
Subject: [PATCH 1/1] ALSA: ALC283 codec - Avoid pop noise on
	headphones during suspend/resume
Date: Thu,  9 Oct 2014 11:32:37 +0000
Message-ID: <1412854357-32476-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch sets the headphones mode to default before suspending
which helps avoid the pop noise on headphones

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 69d1236..e839e7a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2884,6 +2884,9 @@ static void alc283_shutup(struct hda_codec *codec)
 
 	alc_write_coef_idx(codec, 0x43, 0x9004);
 
+	/*depop hp during suspend*/
+	alc_write_coef_idx(codec, 0x06, 0x2100);
+
 	snd_hda_codec_write(codec, hp_pin, 0,
 			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 
-- 
1.9.1
