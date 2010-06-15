From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Update on TLV320AIC3204 Driver
Date: Tue, 15 Jun 2010 08:21:30 +0100
Message-ID: <B4119F19-C56C-4606-9677-489AF5872423@opensource.wolfsonmicro.com>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<20100611101803.GB12436@sirena.org.uk>
	<20100615002734.GB7759@www.longlandclan.yi.org>
	(sfid-20100615_012756_605627_D0E729CC)
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2F932103886
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 09:21:33 +0200 (CEST)
In-Reply-To: <20100615002734.GB7759@www.longlandclan.yi.org>
	(sfid-20100615_012756_605627_D0E729CC)
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

On 15 Jun 2010, at 01:27, Stuart Longland wrote:

> I've started documenting some of this stuff on the ALSA Wiki at
> <http://www.alsa-project.org/main/index.php/DAPM>.  I'm hoping this
> might be a useful resource for others.  Was about to do it on an
> intranet wiki here, but figured it'd be of benefit to others too.

If you're doing this it would be a bit nicer if you could contribute the
documentation to the kernel. The APIs do change over time and the
in tree documentation has a much better chance of being in sync with
what people are actually working with than online documentation
(which may be for a later kernel version with features they can't use),
though it's not been so great recently.

>> SND_SOC_DAPM_SUPPLY can help you here - you can have a conditional
>> supply.

> Is there an example of the supply doing something like this?  I'm
> thinking a mux might be the way to represent it, but it's then a matter
> of getting DAPM to switch the MUX over to the other source when the
> current source gets shut down.

WM8994 does this for the AIF clocks. You can't use a mux since you're not
routing an audio path.

>> Provide a display_register() callback which filters out the undefined
>> registers or otherwise improve the standard functionality.

> I shall look into this... but a thought, is there any merrit in the
> two-file (register select" and "register data") interface to the CODEC
> registers?  The current interface looks great if you want to quickly get
> a register dump, but the solution I have is easily used in scripts.

It's fairly easy to use the existing solution in scripts with a little bit of
filtering (even grep can do a good job) and I have to say I'm concerned
about the idea of production use of this stuff. It's supposed to give the
impression that you're not meant to be using it in production for anything
except pulling diagnostics out.

>> 
>> If the registers are mostly clustered at the starts of pages then an
>> array of pointers to per-page arrays might do the trick.
> 
> As in this?
> 
> 	static u8 aic3204_reg_page0[128];

Yes.

> I wasn't sure how compatible that would be with the rest of ALSA, but I
> might give that a try shortly.

The rest of ALSA shouldn't be able to tell what you're doing, all the
operations which interact with the register cache are provided by your
driver. If it can see what's going on we've got a problem anyway.

>> Please post to the mailing list if you want review - the standard
>> workflow is to provide comments by replying to the patch.

> No problems, I'll post the code to the list in a moment.  Last time I
> tried this it got held for moderation because the email was too big.
> Hence my posting it to a website and linking to it.  I'll post the files
> up in my next email.  When things are a little more mature, I'll post
> the patch for the driver.

This is one of the things that the requirement to CC the maintainers
and other relevant people helps with - it means that they get a copy 
as soon as their mail server takes the message rather than having
to wait for the list.
