From: Inha Song <ideal.song@samsung.com>
Subject: Re: [alsa-devel] [PATCH v3 1/2] extcon: arizona: Add support for
 select accessory detect mode when headphone detection
Date: Mon, 27 Apr 2015 10:26:04 +0900
Message-ID: <20150427102604.2dfb0ca0@songinha-Samsung-DeskTop-System>
References: <1429701801-25287-1-git-send-email-ideal.song@samsung.com>
 <1429701801-25287-2-git-send-email-ideal.song@samsung.com>
 <20150425125025.GI3480@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150425125025.GI3480@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, cw00.choi@samsung.com, broonie@kernel.org, rf@opensource.wolfsonmicro.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for your comments :)


On Sat, 25 Apr 2015 13:50:25 +0100
Charles Keepax <ckeepax@opensource.wolfsonmicro.com> wrote:

> On Wed, Apr 22, 2015 at 08:23:20PM +0900, Inha Song wrote:
> > This patch add support for select accessory detect mode to HPDETL or HPDETR.
> > Arizona provides a headphone detection circuit on the HPDETL and HPDETR pins
> > to measure the impedance of an external load connected to the headphone.
> > 
> > Depending on board design, headphone detect pins can change to HPDETR or HPDETL.
> > 
> > Signed-off-by: Inha Song <ideal.song@samsung.com>
> > ---
> >  
> > +static int arizona_extcon_of_get_pdata(struct arizona *arizona)
> > +{
> > +	struct arizona_pdata *pdata = &arizona->pdata;
> > +	unsigned int val;
> 
> I would rather this is "unsigned int val =
> ARIZONA_ACCDET_MODE_HPL;".
> 
> > +
> > +	of_property_read_u32(arizona->dev->of_node, "wlf,hpdet-channel", &val);
> 
> Because this won't fill val if the DT entry isn't present.
> 
> > +	switch (val) {
> 
> Which means we hit this with val uninitialised.
> 
> > +	case ARIZONA_ACCDET_MODE_HPL:
> > +	case ARIZONA_ACCDET_MODE_HPR:
> 
> So we may select either channel at random.

Opps, Ok, I will set the default value to ARIZONA_ACCDET_MODE_HPL.

> 
> > +		pdata->hpdet_channel = val;
> > +		break;
> > +	default:
> > +		dev_err(arizona->dev,
> > +			"Wrong wlf,hpdet-channel DT value %d\n", val);
> 
> Or most likely just print an error but the DT being missing
> shouldn't really be an error it is an optional entry.

If the default value is set to ARIZONA_ACCDET_MODE_HPL,
Only the print will be shown, when an invalid value is set by DT.
So, This is a resonable error message.

Best Regards,
Inha Song.

> 
> > +		pdata->hpdet_channel = ARIZONA_ACCDET_MODE_HPL;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Thanks,
> Charles
