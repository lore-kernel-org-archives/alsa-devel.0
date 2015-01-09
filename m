From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH v9 0/4] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Fri, 9 Jan 2015 12:15:05 +0200
Message-ID: <54AFAA29.9040803@ti.com>
References: <cover.1420628786.git.moinejf@free.fr> <54AE99D0.1050205@ti.com> <20150108200526.GD2634@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150108200526.GD2634@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jean-Francois Moine <moinejf@free.fr>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Dave Airlie <airlied@gmail.com>, Andrew Jackson <Andrew.Jackson@arm.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 01/08/2015 10:05 PM, Mark Brown wrote:
> On Thu, Jan 08, 2015 at 04:53:04PM +0200, Jyri Sarha wrote:
>
>> BTW, the HDMI codec is now completely unused, since my OMAP4+ HDMI audio
>> patches were merged (it uses dummy codec) and my BBB HDMI audio patches were
>> never merged.
>
> Might those BBB ones turn up sometime?
>

My intention is to take Jean-Francoises patches into use (I am currently 
working on it). I abandon my generic hdmi codec for now.
In any case I should not need the dummy HDMI codec for anything.

Best regards,
Jyri
