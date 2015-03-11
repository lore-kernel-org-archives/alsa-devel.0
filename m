From: kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH asoc] ASoC: max98925_spk_tlv can be static
Date: Thu, 12 Mar 2015 03:05:44 +0800
Message-ID: <20150311190544.GA22459@lkp-sb04>
References: <201503120256.08LBzgQA%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201503120256.08LBzgQA%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anish Kumar <yesanishhere@gmail.com>
Cc: kbuild-all@01.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 max98925.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index 74f4f0b..34fc4d0 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -186,7 +186,7 @@ static bool max98925_readable_register(struct device *dev, unsigned int reg)
 	}
 }
 
-DECLARE_TLV_DB_SCALE(max98925_spk_tlv, -600, 100, 0);
+static DECLARE_TLV_DB_SCALE(max98925_spk_tlv, -600, 100, 0);
 
 static const struct snd_kcontrol_new max98925_snd_controls[] = {
 	SOC_SINGLE_TLV("Speaker Volume", MAX98925_GAIN,
