From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [alsa-devel] [PATCH 2/9] ASoC: da7210: Add support for line
 input and mic
Date: Thu, 13 Oct 2011 14:25:38 +0530
Message-ID: <1318496138.12107.435.camel@matrix>
References: <1318431492.12107.403.camel@matrix>
	 <20111012145310.GO3647@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111012145310.GO3647@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: lrg@ti.com, alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, kuninori.morimoto.gx@renesas.com, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-10-12 at 15:53 +0100, Mark Brown wrote:
> On Wed, Oct 12, 2011 at 08:28:12PM +0530, Ashish Chavan wrote:
> 
> > +static const char *da7210_mic_bias_voltage_txt[] = {
> > +	"1.5", "1.6", "2.2", "2.3"
> > +};
> > +
> > +static const struct soc_enum da7210_mic_bias =
> > +	SOC_ENUM_SINGLE(DA7210_MIC_L, 4, 4, da7210_mic_bias_voltage_txt);
> > +
> 
> This shouldn't be application controllable, it's a board property and if
> it needs to be managed it's likely to be by in kernel things like
> accessory detection.  We do have some older drivers that do this but
> they're not good.  Use platform data.
> 

In that case I think, it's better to remove it from here.
