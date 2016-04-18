From: Xing Zheng <zhengxing@rock-chips.com>
Subject: Re: [PATCH 1/3] ASoC: jack: Add a jack detect callback via codec
Date: Mon, 18 Apr 2016 17:43:51 +0800
Message-ID: <5714AC57.2070901@rock-chips.com>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com> <1460967452-24574-2-git-send-email-zhengxing@rock-chips.com> <20160418092218.GL3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160418092218.GL3217@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de, Adam.Thomson@diasemi.com, sugar.zhang@rock-chips.com, jay.xu@rock-chips.com, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 2016=E5=B9=B404=E6=9C=8818=E6=97=A5 17:22, Mark Brown wrote:
> On Mon, Apr 18, 2016 at 04:17:30PM +0800, Xing Zheng wrote:
>> This patch add a callback when a codec have the jack detect feature.
>> +void snd_soc_jack_codec_detect(struct snd_soc_codec *codec,
>> +				struct snd_soc_jack *jack)
>> +{
>> +	if (codec&&  codec->driver&&  codec->driver->detect_jack)
>> +		codec->driver->detect_jack(codec, jack);
>> +}
>> +EXPORT_SYMBOL_GPL(snd_soc_jack_codec_detect);
> I've no idea what this is supposed to do sorry, you need a much bette=
r
> changelog and probably also a restructuring of the code.  This says i=
t
> is adding a callback but it doesn't do that, it adds an export of a
> function that calls an operation in a driver with no explanation.
Yes, sorry to forgot to add description for this API.

The patch_1/3 add an export of a function that calls the _detect_jack_=20
function
when a codec supports jack detection and fill the _detect_jack_ functio=
n=20
in the
struct snd_soc_codec_driver.

I will clean up the commit message.

Thanks.

--=20
- Xing Zheng
