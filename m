From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ASoC: Clarify API for bias configuration
Date: Fri, 23 May 2008 11:01:07 +0300
Message-ID: <20080523110107.e1671a7c.jarkko.nikula@nokia.com>
References: <1211192441-28912-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1211192441-28912-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080519171558.c37b980b.jarkko.nikula@nokia.com>
	<20080519183654.GB30712@sirena.org.uk>
	<20080520125325.b17ba0b3.jarkko.nikula@nokia.com>
	<20080522233414.GB31117@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E185245C2
	for <alsa-devel@alsa-project.org>;
	Fri, 23 May 2008 10:01:23 +0200 (CEST)
In-Reply-To: <20080522233414.GB31117@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 23 May 2008 00:34:15 +0100
"ext Mark Brown" <broonie@opensource.wolfsonmicro.com> wrote:

> > It came to my mind only afterwards but probably usual set_power
> > convention fits here well, doesn't confuse with DAPM and doesn't
> > limit to thinking only mic bias :-)
> 
> Hrm, depends - I can see people viewing it as an alternative to DAPM.
> Which, of course, you can do but it's not the Right Way.
> 
> This API really is intended for configuring biases and things like
> them. Maintaining biases is both power and output quality sensitive
> so it's beneficial for the core to be able to control them
> specifically.  Other things are expected to be managed via either
> DAPM, feature-specific APIs (eg, the PLLs) or the regular power
> management interface.  From that point of view it would be good to
> keep the bias name in at least the constants. 
> 
Ok, now I see. That would also clarify what's expected from this
callback and what not.

Now snd_soc_dapm_device_event calling codec->dapm_event seems to be
stream centric only. How about the case if only bypass path is active?
Also then biases should be managed?

> > Also how on earth I was able to test my ASoC drivers for OMAP in
> > case of codec slave since driver is enabling PLL only for master
> > case. Hmm... what a hack I was using then.
> 
> Is the codec able to run entirely from the clocks on the audio bus,
> perhaps?
> 
Yes it can but it requires to reconfigure input clock pin. Actually I
found a hack below from my early development tree :-)

-		if (aic3x->master) {
+		if (1/*aic3x->master*/) {
 			/* enable pll */

This needs to be fixed and also move PLL control out of dapm_event
callback.


Jarkko
