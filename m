From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 07/21] ASoC: io: Prevent use of regmap if request fails
Date: Thu, 26 Jul 2012 17:05:51 +0100
Message-ID: <50116ADF.4050700@linaro.org>
References: <1343298534-13611-1-git-send-email-lee.jones@linaro.org> <1343298534-13611-8-git-send-email-lee.jones@linaro.org> <20120726113204.GY3099@opensource.wolfsonmicro.com> <50112C29.6020606@linaro.org> <20120726114215.GB3099@opensource.wolfsonmicro.com> <50115961.6060509@linaro.org> <20120726151217.GO3099@opensource.wolfsonmicro.com> <501160F5.5050807@linaro.org> <20120726152533.GS3099@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120726152533.GS3099@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com, arnd@arndb.de, sameo@linux.intel.com, olalilja@yahoo.se, ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 26/07/12 16:25, Mark Brown wrote:
> On Thu, Jul 26, 2012 at 04:23:33PM +0100, Lee Jones wrote:
>
>> What's my 'control data'? It's not used in the original codec patch.
>
>> The old way wants to go:
>
>> snd_soc_update_bits() -> snd_soc_read() -> ab8500_codec_read_reg()
>
>> When then calls back into the abx500.
>
>> So what 'control data' should I be storing in the codec struct?
>
> You're supposed to use it for the data you use to call back into the
> underlying I/O code.

I don't understand. What 'data'?

Surely if .read and .write are populated in 'struct=20
snd_soc_codec_driver', then it should just call back into those?

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
