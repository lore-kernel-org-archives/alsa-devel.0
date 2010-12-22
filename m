From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add initial WM8995 driver
Date: Wed, 22 Dec 2010 10:54:39 +0000
Message-ID: <1293015279.3329.11.camel@odin>
References: <1292951800-16694-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1292963892.3296.56.camel@odin>
	<1293013616.29185.55.camel@dplaptop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 713F5103BEB
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 11:54:44 +0100 (CET)
Received: by wyi11 with SMTP id 11so4725904wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 02:54:43 -0800 (PST)
In-Reply-To: <1293013616.29185.55.camel@dplaptop.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-12-22 at 10:26 +0000, Dimitris Papastamos wrote:
> On Tue, 2010-12-21 at 20:38 +0000, Liam Girdwood wrote:
> > On Tue, 2010-12-21 at 17:16 +0000, Dimitris Papastamos wrote:
> > > The WM8995 is a digital audio hub CODEC designed for smartphones.
> > > The current driver supports most of the basic functionality of the
> > > WM8995.
> > > 
> > > Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> > > ---
> > 
> > > +
> > > +static int wm8995_volatile(unsigned int reg)
> > > +{
> > > +	if (reg >= WM8995_MAX_REGISTER + 1)
> > > +		return 1;
> > > +
> > 
> > return -EINVAL here.
> 
> The logic behind this is that out of bounds registers are considered
> volatile. 

It does look a little odd since out of bounds generally means invalid. 

>  If I change it to -EINVAL, the behaviour will essentially be
> the same because in the soc-cache code we use
> snd_soc_codec_volatile_register() and we only test it for being
> non-zero.  We either need clearer semantics for this function or
> otherwise it should be fine.
> 

Clearer comments are probably better in this case since it does look
wrong, however if you have time please feel free to update the function
semantics. 

> > > +	switch (reg) {
> > > +	case WM8995_SOFTWARE_RESET:
> > > +	case WM8995_DC_SERVO_READBACK_0:
> > > +	case WM8995_INTERRUPT_STATUS_1:
> > > +	case WM8995_INTERRUPT_STATUS_2:
> > > +	case WM8995_INTERRUPT_STATUS_1_MASK:
> > > +	case WM8995_INTERRUPT_STATUS_2_MASK:
> > > +	case WM8995_INTERRUPT_CONTROL:
> > > +	case WM8995_ACCESSORY_DETECT_MODE1:
> > > +	case WM8995_ACCESSORY_DETECT_MODE2:
> > > +	case WM8995_HEADPHONE_DETECT1:
> > > +	case WM8995_HEADPHONE_DETECT2:
> > > +		return 1;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > 
> > > +
> > > +/*
> > > + * R1 (0x01) - Power Management (1)
> > > + */
> > > +#define WM8995_MICB2_ENA                        0x0200	/* MICB2_ENA */
> > > +#define WM8995_MICB2_ENA_MASK                   0x0200	/* MICB2_ENA */
> > > +#define WM8995_MICB2_ENA_SHIFT                       9	/* MICB2_ENA */
> > > +#define WM8995_MICB2_ENA_WIDTH                       1	/* MICB2_ENA */
> > > +#define WM8995_MICB1_ENA                        0x0100	/* MICB1_ENA */
> > > +#define WM8995_MICB1_ENA_MASK                   0x0100	/* MICB1_ENA */
> > > +#define WM8995_MICB1_ENA_SHIFT                       8	/* MICB1_ENA */
> > > +#define WM8995_MICB1_ENA_WIDTH                       1	/* MICB1_ENA */
> > > +#define WM8995_HPOUT2L_ENA                      0x0080	/* HPOUT2L_ENA */
> > > +#define WM8995_HPOUT2L_ENA_MASK                 0x0080	/* HPOUT2L_ENA */
> > > +#define WM8995_HPOUT2L_ENA_SHIFT                     7	/* HPOUT2L_ENA */
> > > +#define WM8995_HPOUT2L_ENA_WIDTH                     1	/* HPOUT2L_ENA */
> > > +#define WM8995_HPOUT2R_ENA                      0x0040	/* HPOUT2R_ENA */
> > > +#define WM8995_HPOUT2R_ENA_MASK                 0x0040	/* HPOUT2R_ENA */
> > > +#define WM8995_HPOUT2R_ENA_SHIFT                     6	/* HPOUT2R_ENA */
> > > +#define WM8995_HPOUT2R_ENA_WIDTH                     1	/* HPOUT2R_ENA */
> > > +#define WM8995_HPOUT1L_ENA                      0x0020	/* HPOUT1L_ENA */
> > > +#define WM8995_HPOUT1L_ENA_MASK                 0x0020	/* HPOUT1L_ENA */
> > > +#define WM8995_HPOUT1L_ENA_SHIFT                     5	/* HPOUT1L_ENA */
> > > +#define WM8995_HPOUT1L_ENA_WIDTH                     1	/* HPOUT1L_ENA */
> > > +#define WM8995_HPOUT1R_ENA                      0x0010	/* HPOUT1R_ENA */
> > > +#define WM8995_HPOUT1R_ENA_MASK                 0x0010	/* HPOUT1R_ENA */
> > > +#define WM8995_HPOUT1R_ENA_SHIFT                     4	/* HPOUT1R_ENA */
> > > +#define WM8995_HPOUT1R_ENA_WIDTH                     1	/* HPOUT1R_ENA */
> > > +#define WM8995_BG_ENA                           0x0001	/* BG_ENA */
> > > +#define WM8995_BG_ENA_MASK                      0x0001	/* BG_ENA */
> > > +#define WM8995_BG_ENA_SHIFT                          0	/* BG_ENA */
> > > +#define WM8995_BG_ENA_WIDTH                          1	/* BG_ENA */
> > > +
> > 
> > It looks like all the register bits have macros but some driver
> > functions are still using magic numbers for bits instead of the macros.
> 
> I've found one call to dc_servo_cmd() using a magic number.  The dapm
> widgets and the kcontrols don't generally use the macros since the lines
> become very long.
> 

There are also some magic numbers in configure_aif_clock,
wm8995_set_dai_fmt, wm8995_hw_params. It's possible there are no macros
defined for these numbers though...

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
