From: Sergey Kiselev <sergey.kiselev@intel.com>
Subject: wm8731 - redundant register initialization,
 stream name vs DAPM widgets, snd_soc_io to regmap_io conversion
Date: Fri, 5 Jun 2015 12:27:48 -0700
Message-ID: <20150605122748.b7534fc4900573ed497928ce@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9593D266911
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 21:27:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I have a few questions regarding wm8731. Some might be applicable to other
codecs as well.

1. According to the datasheet bit #8 of all the registers below is set to
'0' by the hardware reset. Is there a good reason to set them anyway?
(Perhaps an errata in previous chip version?)
	/* Latch the update bits */
	snd_soc_update_bits(codec, WM8731_LOUT1V, 0x100, 0);
	snd_soc_update_bits(codec, WM8731_ROUT1V, 0x100, 0);
	snd_soc_update_bits(codec, WM8731_LINVOL, 0x100, 0);
	snd_soc_update_bits(codec, WM8731_RINVOL, 0x100, 0);

2. In wm8731's snd_soc_dai_driver structure the steam names are 'Playback'
and 'Capture', while DAPM widgets have 'HiFi' prepended to the names:
SND_SOC_DAPM_DAC("DAC", "HiFi Playback", WM8731_PWR, 3, 1),
SND_SOC_DAPM_ADC("ADC", "HiFi Capture", WM8731_PWR, 2, 1),
Should the name match? DAPM.txt says so, but the DAPM code actually looks
for a substring match (DAI name as a substring in widget name).

3. Do I understand correctly the direction is to move from snd_soc_${io}
to more generic regmap_${io}? If so, I'll submit a patch.

Thanks
-- 
Sergey
