From: Inha Song <ideal.song@samsung.com>
Subject: Re: [alsa-devel] [PATCH v2 1/2] extcon: arizona: Add support for
 select accessory detect mode when headphone detection
Date: Tue, 21 Apr 2015 18:38:10 +0900
Message-ID: <20150421183810.32826087@songinha-Samsung-DeskTop-System>
References: <1429589505-11954-1-git-send-email-ideal.song@samsung.com>
 <1429589505-11954-2-git-send-email-ideal.song@samsung.com>
 <20150421092826.GH3480@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150421092826.GH3480@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, cw00.choi@samsung.com, broonie@kernel.org, rf@opensource.wolfsonmicro.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for your review :)

On Tue, 21 Apr 2015 10:28:26 +0100
Charles Keepax <ckeepax@opensource.wolfsonmicro.com> wrote:

> On Tue, Apr 21, 2015 at 01:11:44PM +0900, Inha Song wrote:
> > This patch add support for select accessory detect mode to HPDETL or HPDETR.
> > Arizona provides a headphone detection circuit on the HPDETL and HPDETR pins
> > to measure the impedance of an external load connected to the headphone.
> > 
> > Depending on board design, headphone detect pins can change to HPDETR or HPDETL.
> > 
> > Signed-off-by: Inha Song <ideal.song@samsung.com>
> > ---
> >  drivers/extcon/extcon-arizona.c   | 28 ++++++++++++++++++++--------
> >  include/dt-bindings/mfd/arizona.h |  8 ++++++++
> >  include/linux/mfd/arizona/pdata.h |  3 +++
> >  3 files changed, 31 insertions(+), 8 deletions(-)
> >  create mode 100644 include/dt-bindings/mfd/arizona.h
> > 
> > diff --git a/drivers/extcon/extcon-arizona.c b/drivers/extcon/extcon-arizona.c
> > index 63f01c4..c827342 100644
> > --- a/drivers/extcon/extcon-arizona.c
> > +++ b/drivers/extcon/extcon-arizona.c
> > @@ -32,13 +32,10 @@
> >  #include <linux/mfd/arizona/core.h>
> >  #include <linux/mfd/arizona/pdata.h>
> >  #include <linux/mfd/arizona/registers.h>
> > +#include <dt-bindings/mfd/arizona.h>
> >  
> >  #define ARIZONA_MAX_MICD_RANGE 8
> >  
> > -#define ARIZONA_ACCDET_MODE_MIC 0
> > -#define ARIZONA_ACCDET_MODE_HPL 1
> > -#define ARIZONA_ACCDET_MODE_HPR 2
> > -
> >  #define ARIZONA_MICD_CLAMP_MODE_JDL      0x4
> >  #define ARIZONA_MICD_CLAMP_MODE_JDH      0x5
> >  #define ARIZONA_MICD_CLAMP_MODE_JDL_GP5H 0x9
> > @@ -653,9 +650,9 @@ static void arizona_identify_headphone(struct arizona_extcon_info *info)
> >  	ret = regmap_update_bits(arizona->regmap,
> >  				 ARIZONA_ACCESSORY_DETECT_MODE_1,
> >  				 ARIZONA_ACCDET_MODE_MASK,
> > -				 ARIZONA_ACCDET_MODE_HPL);
> > +				 arizona->pdata.hpdet_channel);
> >  	if (ret != 0) {
> > -		dev_err(arizona->dev, "Failed to set HPDETL mode: %d\n", ret);
> > +		dev_err(arizona->dev, "Failed to set HPDET mode: %d\n", ret);
> >  		goto err;
> >  	}
> >  
> > @@ -705,9 +702,9 @@ static void arizona_start_hpdet_acc_id(struct arizona_extcon_info *info)
> >  				 ARIZONA_ACCESSORY_DETECT_MODE_1,
> >  				 ARIZONA_ACCDET_SRC | ARIZONA_ACCDET_MODE_MASK,
> >  				 info->micd_modes[0].src |
> > -				 ARIZONA_ACCDET_MODE_HPL);
> > +				 arizona->pdata.hpdet_channel);
> >  	if (ret != 0) {
> > -		dev_err(arizona->dev, "Failed to set HPDETL mode: %d\n", ret);
> > +		dev_err(arizona->dev, "Failed to set HPDET mode: %d\n", ret);
> >  		goto err;
> >  	}
> >  
> > @@ -1103,6 +1100,16 @@ static void arizona_micd_set_level(struct arizona *arizona, int index,
> >  	regmap_update_bits(arizona->regmap, reg, mask, level);
> >  }
> >  
> > +static int arizona_extcon_of_get_pdata(struct arizona *arizona)
> > +{
> > +	struct arizona_pdata *pdata = &arizona->pdata;
> > +
> > +	of_property_read_u32(arizona->dev->of_node, "wlf,hpdet-channel",
> > +			     &pdata->hpdet_channel);
> 
> I think we need to verify this is either HPL or HPR and default
> it to HPL if isn't one of those. Otherwise this looks fine.
> 

Ok, We can check hpdet_channel value to use switch-case in arizona_extcon_of_get_pdata() function.
I will fix.

Best Regards,
Inha Song.

> Thanks,
> Charles
