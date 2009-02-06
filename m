From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [2.6.29-rc3][PATCH 2/2] ASoC: WM8990: Fix kcontrol's
	private value use in put callback
Date: Fri,  6 Feb 2009 12:01:05 +0200
Message-ID: <1233914465-2767-2-git-send-email-jarkko.nikula@nokia.com>
References: <1233914465-2767-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 82E711037F6
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2009 11:01:16 +0100 (CET)
In-Reply-To: <1233914465-2767-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Function wm899x_outpga_put_volsw_vu misuses the kcontrol's private value
by still accessing it as bitfields even SOC_SINGLE_VALUE constructs it
as a pointer into struct soc_mixer_control after the commit
4eaa9819dc08d7bfd1065ce530e31b18a119dcaf.

This is very similar fix than fix to TLV320AIC3X codec made by
Eero Nurkkala <ext-eero.nurkkala@nokia.com>. This fix is compile tested
only.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/wm8990.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8990.c b/sound/soc/codecs/wm8990.c
index 1cbb7b9..a5731fa 100644
--- a/sound/soc/codecs/wm8990.c
+++ b/sound/soc/codecs/wm8990.c
@@ -176,7 +176,9 @@ static int wm899x_outpga_put_volsw_vu(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
-	int reg = kcontrol->private_value & 0xff;
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	int reg = mc->reg;
 	int ret;
 	u16 val;
 
-- 
1.5.6.5
