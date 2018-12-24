From: Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 2/2] ASoC: Intel: bytcr_rt5640: Add quirks
 for ASUS MeMO Pad 7 (ME176C)
Date: Mon, 24 Dec 2018 10:53:55 +0100
Message-ID: <20181224095234.GA821@gerhold.net>
References: <20181222144708.121732-1-stephan@gerhold.net>
 <20181222144708.121732-2-stephan@gerhold.net>
 <20181222145907.GA121290@gerhold.net>
 <34b58790-c6eb-a6c7-a6af-3e12fe1c6cfb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 096022678D5
 for <alsa-devel@alsa-project.org>; Mon, 24 Dec 2018 10:54:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <34b58790-c6eb-a6c7-a6af-3e12fe1c6cfb@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 24, 2018 at 10:01:53AM +0100, Hans de Goede wrote:
> H,
> 
> On 22-12-18 15:59, Stephan Gerhold wrote:
> > On Sat, Dec 22, 2018 at 03:47:12PM +0100, Stephan Gerhold wrote:
> > > Add quirks to select the correct input map, jack-detect options
> > > and channel map to make sound work on the ASUS MeMO Pad 7 (ME176C).
> > 
> > Everything seems to work fine with the quirks below, although I have to
> > say that the internal microphone quality is really bad. There are
> > always high-pitched sounds in the background. Not sure if the hardware
> > is just really bad or if there is any way to improve it.
> > (I never use it so I have not investigated much further..)
> 
> One possible way of improving it which is worthwhile testing
> is adding the BYT_RT5640_DIFF_MIC quirk.
> 
> Note almost all quirk table entries not using a DMIC mapping have this
> set (it is also set in INPUT_DEFAULTS) because it does not really hurt
> to enable it, while likely only a few models really have a diff mic.
> 

I thought that the DIFF_MIC quirk might help, so I tested it shortly 
before sending this patch: I was not able to hear any difference in the 
recorded sample, which is why I didn't add it to the quirks.

Would you prefer to have it enabled even if it (seemingly) makes no 
difference?

> > > Note: Although sound works out of the box, jack detection currently
> > > requires overriding the ACPI DSDT table. This is necessary because
> > > the rt5640 ACPI device (10EC5640) has the wrong GPIO listed as
> > > interrupt (one of the Bluetooth GPIOs).
> > > The correct GPIO is GPO2 0x0004 (listed as the first GPIO in the
> > > Intel(R) Audio Machine Driver - AMCR0F28 device).
> > 
> > At some point it might be possible to add a workaround for this using
> > that AMCR0F28 device which has the correct GPIO. However, at the moment
> > I still need the DSDT override for Bluetooth to work (with no simple
> > workaround), so it's probably easiest if we just document it here for
> > now. Eventually I will investigate this later..
> 
> +1 for just documenting, as long as this device needs a DSDT override
> anyways I don't think it is a good idea to add code to the bytcr_rt5640.c
> machine driver just to avoid that. If the machine driver is the only
> one needing the DSDT override and some code can avoid it then the
> balance changes, but for now I believe that just documenting it is
> best.

Agreed. :)

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> > 
> > > 
> > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > > ---
> > >   sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> > > index a22366ce33c4..ca8b4d5ff70f 100644
> > > --- a/sound/soc/intel/boards/bytcr_rt5640.c
> > > +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> > > @@ -428,6 +428,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
> > >   					BYT_RT5640_SSP0_AIF1 |
> > >   					BYT_RT5640_MCLK_EN),
> > >   	},
> > > +	{
> > > +		.matches = {
> > > +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> > > +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ME176C"),
> > > +		},
> > > +		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
> > > +					BYT_RT5640_JD_SRC_JD2_IN4N |
> > > +					BYT_RT5640_OVCD_TH_2000UA |
> > > +					BYT_RT5640_OVCD_SF_0P75 |
> > > +					BYT_RT5640_SSP0_AIF1 |
> > > +					BYT_RT5640_MCLK_EN),
> > > +	},
> > >   	{
> > >   		.matches = {
> > >   			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> > > -- 
> > > 2.20.1
> > > 
