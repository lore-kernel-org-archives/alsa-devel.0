From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH] ASoC: codecs-ac97: make selectable in config
Date: Wed, 13 May 2015 22:57:24 +0200
Message-ID: <5553BAB4.3040209@maciej.szmigiero.name>
References: <554E8634.2010008@maciej.szmigiero.name> <20150512175807.GL3066@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150512175807.GL3066@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Lars-Peter Clausen <lars@metafoo.de>, Brian Austin <brian.austin@cirrus.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Thanks for looking into the patch.

W dniu 12.05.2015 19:58, Mark Brown pisze:
> On Sun, May 10, 2015 at 12:12:04AM +0200, Maciej S. Szmigiero wrote:
> 
>> @@ -16,7 +16,7 @@ config SND_SOC_ALL_CODECS
>>  	select SND_SOC_88PM860X if MFD_88PM860X
>>  	select SND_SOC_L3
>>  	select SND_SOC_AB8500_CODEC if ABX500_CORE
>> -	select SND_SOC_AC97_CODEC if SND_SOC_AC97_BUS
>> +	select SND_SOC_AC97_CODEC
>>  	select SND_SOC_AD1836 if SPI_MASTER
>>  	select SND_SOC_AD193X_SPI if SPI_MASTER
>>  	select SND_SOC_AD193X_I2C if I2C
> 
> No, you're missing the point of what _ALL_CODECS does - it builds
> everything possible.  This will break the build for systems without
> AC'97 support.

How?
In the second hunk of the patch I've made SND_SOC_AC97_CODEC select
SND_SOC_AC97_BUS.

ASoC AC'97 CODEC uses only AC'97 symbols defined in
pci/ac97/ac97_codec.c, pci/ac97/ac97_pcm.c and sound/soc/soc-ac97.c.

pci/ac97/ac97_codec.c, pci/ac97/ac97_pcm.c will be built via
SND_SOC_ALL_CODECS -> SND_SOC_AC97_CODEC -> SND_AC97_CODEC dependency.

sound/soc/soc-ac97.c will be build via SND_SOC_ALL_CODECS ->
SND_SOC_AC97_CODEC -> SND_SOC_AC97_BUS dependency.

Best regards,
Maciej Szmigiero
