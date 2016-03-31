From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH 2/3 v2] ASoC: dwc: Add I2S HDMI audio support
Date: Thu, 31 Mar 2016 10:37:20 +0100
Message-ID: <56FCEFD0.8090509@synopsys.com>
References: <cover.1459174494.git.joabreu@synopsys.com>
 <538be366488bf0d7633d702f2d0bab16707b7a47.1459174494.git.joabreu@synopsys.com>
 <20160329173158.GB2350@sirena.org.uk> <56FAC355.1040705@synopsys.com>
 <20160329182222.GC2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160329182222.GC2350@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Jose Abreu <Jose.Abreu@synopsys.com>
Cc: tixy@linaro.org, mark.rutland@arm.com, alsa-devel@alsa-project.org, Alexey.Brodkin@synopsys.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, yitian.bu@tangramtek.com, wsa+renesas@sang-engineering.com, laurent.pinchart+renesas@ideasonboard.com, tiwai@suse.com, nariman@opensource.wolfsonmicro.com, linux-snps-arc@lists.infradead.org, devicetree@vger.kernel.org, Maruthi.Bayyavarapu@amd.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Vineet.Gupta1@synopsys.com, buyitian@gmail.com, robh+dt@kernel.org, perex@perex.cz, lgirdwood@gmail.com, CARLOS.PALMINHA@synopsys.com, galak@codeaurora.org, alexander.deucher@amd.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 29-03-2016 19:22, Mark Brown wrote:
> On Tue, Mar 29, 2016 at 07:03:01PM +0100, Jose Abreu wrote:
>
>> The major part of this patch is the adding of an ALSA platform driver so that
>> audio comes out of the box in AXS boards but we also added functionalities to
>> the i2s driver and performed one bug fix related with the mask/unmask of
>> interrupts. I will split the patches but they will depend on each other.
> If you want to add a new platform driver you need to add a new platform
> driver, not shove the code into an existing driver for a seperate IP.
>

I can separate the platform driver into a new file but they will have to be
compiled into the same module as the new additions to the i2s driver depend on
functions of the platform driver (see i2s_irq_handler()). Or should I divide
this into two modules and add a Kconfig option to the platform driver? Besides
this I first wanted the driver to be compiled into the same module so that it is
compatible with kernel 3.18 where simple audio card requires that platform
driver == cpu driver.

Best regards,
Jose Miguel Abreu
