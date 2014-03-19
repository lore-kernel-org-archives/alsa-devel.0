From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [alsa-devel] [PATCH v3 4/4] ASoC: simple-card: Add DT documentation
 for multi-DAI links
Date: Wed, 19 Mar 2014 21:15:14 +0200
Message-ID: <5329ECC2.7040803@ti.com>
References: <cover.1394883134.git.moinejf@free.fr>	<d054780a0edf4b2338a52e48bff9144e19aa614f.1394883134.git.moinejf@free.fr>	<20140317164339.GR11706@sirena.org.uk> <20140318091728.1d2240ca@armhf> <53296CB7.1000909@ti.com> <5329E749.6070900@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5329E749.6070900@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On 03/19/2014 08:51 PM, Lars-Peter Clausen wrote:
> On 03/19/2014 11:08 AM, Jyri Sarha wrote:
> [...]
>> It may sometimes be helpful to allow overwriting link level settings
>> in dai
>> level. In order to do that it should be possible to write all daifmt
>> settings explicitly like this:
>>
>> bitclock-inversion = <0>; /* <0> = no bitclock-inversion */
>
> When does this make sense? Either the bitclock is inverted for all of
> them or for none.
>

Definition of clock signal and it's inversion varies between chip 
manufacturers and sometimes it may not be possible to get all the dai 
drivers to work identically in this respect. Because of this in some 
cases there may be a need to set the inversion bit only at one end of 
the link.

I think there was an example of this in some mail regarding the 
simple-card DT-bidings, but I can't find it ATM.

Best regards,
Jyri
