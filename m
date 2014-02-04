From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH v3 2/5] ASoC: tda998x: add a codec driver
 for the TDA998x
Date: Tue, 04 Feb 2014 14:36:50 +0100
Message-ID: <52F0ECF2.9070102@metafoo.de>
References: <cover.1391274627.git.moinejf@free.fr> <ae68394f080f0ea5acaf3377cb1d18f29e42c646.1391274628.git.moinejf@free.fr> <20140204133014.GA22609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140204133014.GA22609@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 02/04/2014 02:30 PM, Mark Brown wrote:
[...]
>
> What does this actually do?  No information is being passed in to the
> core function here, not even any information on if it's starting or
> stopping.  Looking at the rest of the code I can't help thinking it
> might be clearer to inline this possibly with a lookup helper, the code
> is very small and the lack of parameters makes it hard to follow.
>
>> +static const struct snd_soc_dapm_route tda_routes[] = {
>> +	{ "hdmi-out", NULL, "HDMI I2S Playback" },
>> +	{ "hdmi-out", NULL, "HDMI SPDIF Playback" },
>> +};
>
> S/PDIF.

Won't this cause issues with the debugfs widget entries? It's fixable by 
escaping it (replace it by a dash or something) in the debugfs widget 
filename, but I don't think we do this right now.

- Lars
