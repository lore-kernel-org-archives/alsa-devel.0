From: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add EXT_MUTE gpio to reduce
 pop-noise effect
Date: Thu, 25 Jun 2009 13:05:26 -0500
Message-ID: <2256F256009DAA4CBE661E9F41EAC84B4A95D2BA@dlee01.ent.ti.com>
References: <1245896733-3973-1-git-send-email-x0107209@ti.com>
	<200906251103.38818.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id E32292438D
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 20:05:34 +0200 (CEST)
In-Reply-To: <200906251103.38818.peter.ujfalusi@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

> On Thursday 25 June 2009 05:25:33 ext Jorge Eduardo Candelaria wrote:
> > According to TRM, an external FET controlled by a 1.8V output signal
> > can be used to reduce the pop-noise heard when the audio 
> amplifier is
> > switched on.
> 
> As a note: the TRM suggests to use GPIO6 of TWL for the 
> external FET control 
> (which is than can be controlled by the HS_POP_SET:EXTMUTE bit).

TRM does suggest the use of TWL GPIO6, however, there may be cases
(actually, there ARE cases) in which the FET control is assigned to
another gpio.

> I think the HS ext mute should be handled in a different way:
> There should be a way to use also the HS_POP_SET:EXTMUTE (TWL 
> GPIO6) or 
> external gpio for the extmute.
> In order to use the TWL GPIO6 for extmute, the 
> PMBR1:GPIO6_PWM0_MUTE should be 
> set to 0x2 initially in TWL, but this is not the job of the 
> codec driver (it 
> is platform specific how this pin is used).

I agree. I was originally thinking of using the gpio library for
either TWL GPIO6 or an external line. However, it should be better to
follow the TRM approach, along with support for the special cases in
which an external gpio is used for the extmute.

> Anyways, I think the correct approach should be something like this:
> 
> In twl4030.h:
> 
> struct twl4030_setup_data {
> 	unsigned int ramp_delay_value;
> 	unsigned int sysclk;
> +	unsigned int hs_extmute:1;
> +	void (*set_hs_extmute)(int mute);
> };
> 
> Than in the machine driver:
> a) No extmute possible
> Just don't set any of these new hs_extmute things.
> 
> b) extmute is used through TWL GPIO6
> Set the hs_extmute to 1
> Set the set_hs_extmute to NULL
> 
> c) extmute is used through some other ways
> Set the hs_extmute to 1
> 
> Request the gpio (or whatever you need to control the 
> extmute), also take care 
> of the cleanup.
> Implement the something like this:
> 
> void zoom2_hs_extmute(int mute) {
> 	gpio_set_value(GPIO_NUMBER, mute)
> }
> 
> Set the set_hs_extmute to zoom2_hs_extmute
> 
> than in the codec driver:
> If the hs_extmute is 0, than do nothing about the extmute,
> If only the hs_extmute is set, than set/clear the 
> HS_POP_SET:EXTMUTE bit
> if both hs_extmute and set_hs_extmute are set, than call the 
> set_hs_extmute 
> function.
> 
> What do you think?

This is a much better approach. I was having problems finding
a way to keep the gpio calls away from the codec driver, but
this helps a lot, thanks. I will try it out and test both cases:

- GPIO6 of TWL
- external gpio line.
