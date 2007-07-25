From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: How do I tell ALSA that my driver
	supports	every	possible sample rate?
Date: Wed, 25 Jul 2007 16:24:11 +0100
Message-ID: <1185377051.3301.34.camel@localhost.localdomain>
References: <46A4CF38.3050107@freescale.com>
	<1185210867.7590.1201603759@webmail.messagingengine.com>
	<46A4E503.50207@freescale.com>
	<1185261264.6647.1201715813@webmail.messagingengine.com>
	<46A612A0.6000807@freescale.com> <s5hd4yhyh5n.wl%tiwai@suse.de>
	<46A65355.4040101@freescale.com> <s5hsl7cwzv0.wl%tiwai@suse.de>
	<46A7602E.6090809@freescale.com> <s5h4pjswmfa.wl%tiwai@suse.de>
	<s5h3azcwm84.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 392E410386D
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jul 2007 17:24:13 +0200 (CEST)
In-Reply-To: <s5h3azcwm84.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-07-25 at 17:12 +0200, Takashi Iwai wrote:
> At Wed, 25 Jul 2007 17:08:41 +0200,
> I wrote:
> > 
> > At Wed, 25 Jul 2007 09:37:34 -0500,
> > Timur Tabi wrote:
> > > 
> > > Takashi Iwai wrote:
> > > 
> > > >> So can I do this?
> > > >>
> > > >> static const struct snd_pcm_hardware mpc86xx_pcm_hardware = {
> > > >>
> > > >> 	.rates			= SNDRV_PCM_RATE_CONTINUOUS,
> > > >> 	.rate_min		= 1,
> > > >> 	.rate_max		= (unsigned int) -1,
> > > > 
> > > > In theory, yes, but these rate_min and rate_max are nothing but
> > > > confusing in practice.  Your hardware won't support definitely such
> > > > rates, but the application can't know.  Set some reasonable values
> > > > there.
> > > 
> > > This is an ASOC driver.  My understanding is that ASOC will take all
> > > the values from the machine, PCM, I2S, and codec drivers and create
> > > the subset that matches all drivers.  That's the point I was trying
> > > to make: my PCM driver does *not* decide what the capabilities of
> > > the system are, because my DMA controller can handle all speeds.  So
> > > I don't want to put some arbitrary limits in the PCM driver, and
> > > then perhaps one day it gets attached to a codec driver that can
> > > handle 4000Hz, but ASOC won't allow it because I used
> > > SNDRV_PCM_RATE_8000_192000 | SNDRV_PCM_RATES_5512 in my PCM driver.
> > > ASOC would incorrectly believe that the PCM driver can't handle
> > > 4000Hz. 
> > 
> > Then,
> > 	rates = -1U,
> > 	rate_min = 0,
> > 	rate_max = -1U,
> > are the correct values.
> 
> ... of course, this assumes that codec and platform have the sane rate
> setting.  ASoC should do some sanity checks...
> 

Ok, I've marked this on my todo list ;)

Liam
