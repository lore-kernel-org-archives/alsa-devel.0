From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Update on TLV320AIC3204 Driver
Date: Fri, 11 Jun 2010 11:18:04 +0100
Message-ID: <20100611101803.GB12436@sirena.org.uk>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 07B75103997
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jun 2010 12:18:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100611055512.GG23431@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Eric B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 11, 2010 at 03:55:12PM +1000, Stuart Longland wrote:

> (1)	When using the SOC_DOUBLE_R_SX_TLV controls, I notice there's an
> 	odd interaction between the mute switch associated with the
> 	control, and its corresponding gain setting.

> 	Nothing changes in the actual registers (except the mute bit of
> 	course) but the displayed gain shoots up to infinity if the mute
> 	is toggled when the gain associated with that mute control is
> 	set below 0dB.  When the gain is at 0dB or above, toggling the
> 	mute has no effect on the displayed gain setting.

This is almost always due to having an overlap between the bitfield for
the volume and the mute bit.

> (2)	On the TLV320AIC3204, the clocks used on the audio bus can either
> 	be sourced from the ADC clocks, or the DAC clocks.  Naturally,
> 	before you see any clocks on the bus, you must first power up
> 	either the DAC or ADC (or both), and choose the appropriate
> 	source.  I do this currently in the hw_params callback (right
> 	where I *used* to power up the DACs/ADCs, DAPM does this now).

SND_SOC_DAPM_SUPPLY can help you here - you can have a conditional
supply.

> (3)	The sysfs interface of my driver still remains.  I had a look at
> 	using the ASoC debugfs interface, however there are a *lot* of
> 	registers on the 'AIC3204 in a sparse memory map.  When I try to
> 	inspect the registers via
> 	/sys/kernel/debug/asoc/tlv320aic3204.0-0018/codec_reg ... I
> 	notice there are more registers in the device than are
> 	accessible via this interface:

Provide a display_register() callback which filters out the undefined
registers or otherwise improve the standard functionality.

> 	Notice it stops at 0x01b0 (corresponding to page 3, register
> 	48), with an incomplete line.  There were more registers, than
> 	there was buffer space to write the file.  Is there a way to
> 	increase this buffer?

No, it's a sysfs limit.

> The driver is still using the registration model that was used in kernel
> 2.6.34.  I've managed to backport the ALSA tree to 2.6.28 for our
> project (since that's what's officially supported by Ka-Ro) and so far,
> it's working, although things are still quite crude.

If you could convince Ka-Ro to work with mainline that'd be nice :/

> I cache more of the registers now, I tried doing something "clever" and
> skipping the pages of registers that aren't used and trying to cache
> just the pages that were meaningful, but I noticed that the rest of ALSA
> more or less assumed the register address used with cache was the real
> address.  Digging around on the mailing list about how to handle a
> sparse register map lead me to the solution of just biting the bullet
> and caching all 80-odd pages.  Wasteful on memory, but I won't miss
> anything.

If the registers are mostly clustered at the starts of pages then an
array of pointers to per-page arrays might do the trick.

> The driver still has an initialisation script facility, whereby custom
> register settings can be made at init.  I'm still undecided as to
> whether to keep this or not... it's not the "done thing", but if I leave
> it there, it allows for custom adaptive filtering coefficients and other
> parameters to be set by the machine driver, which may be useful in some
> applications.  Is it worth cleaning this up, or should it be ditched
> before the driver is submitted for inclusion?

If the data is stuff that's calculated off-line then it's reasonable to
supply specific bits of data via platform data, several existing drivers
do this for filter coefficients.  Providing completely arbatrary
register writes is not suitable for mainline.

> The driver is accessible online at
> <http://www.longlandclan.yi.org/~stuartl/asoc/> along with some comments
> about how to add it to your kernel sources.  I'd appreciate any feedback
> or advice on how the driver can be improved.

Please post to the mailing list if you want review - the standard
workflow is to provide comments by replying to the patch.
