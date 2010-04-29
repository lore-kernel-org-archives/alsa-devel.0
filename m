From: Timur Tabi <timur@freescale.com>
Subject: Re: asoc: problem with snd_soc_dai_set_fmt()
Date: Thu, 29 Apr 2010 18:30:19 -0500
Message-ID: <s2oed82fe3e1004291630k697318f9od19ceca1011540fa@mail.gmail.com>
References: <4BD9F889.4010106@freescale.com>
	<20100429221808.GB23958@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f189.google.com (mail-iw0-f189.google.com
	[209.85.223.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C62C24397
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Apr 2010 01:30:50 +0200 (CEST)
Received: by iwn27 with SMTP id 27so9537905iwn.5
	for <alsa-devel@alsa-project.org>; Thu, 29 Apr 2010 16:30:49 -0700 (PDT)
In-Reply-To: <20100429221808.GB23958@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 29, 2010 at 5:18 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Apr 29, 2010 at 04:22:17PM -0500, Timur Tabi wrote:
>
>> Let's say the DAI driver has not defined a .set_fmt() function. =A0This =
means
>> that if the fabric driver does this:
>
> *machine*

Grr... I've been calling it the fabric driver for a long time, and I
know I didn't make up that term.

> Right, but really this is the case - the driver has completely ignored
> what the machine driver was trying to do.

But there are several functions like that, such as the _pll function.
What if the CPU driver really doesn't care what the frequency is or
the PLL or whatever?  Do I need to define stub functions for all of
these?

> =A0It may be that the default
> behaviour is what was asked for, but it may also be that you've asked
> for I2S format and got DSP format or something similiarly incompatible.

But if the CPU driver does not define a function to check for that,
isn't that the same thing as saying, "I really don't care -- I'll
support whatever you want"?

> Due to the above issue I don't think this is a good idea - we really
> ought to let the machine driver know if the request it made was ignored
> in case it is trying to set up something that can't be supported.

IMHO, ignored !=3D not supported.

For instance, it's possible for a CPU driver initially to support only
some configurations, so the set_fmt function would be necessary.
Later, the CPU driver could be updated to support all possible
configurations, and it could know that via some other mechanism (like
the device tree), and so it would be redundant if it let the machine
driver know what that configuration is.

This is what I'm doing to my SSI driver.  Now that it probes the SSI
nodes directly, it doesn't need the machine driver to tell it what the
capabilities are.

> Another short term option would be to change the error code to be
> something a bit more distinctive than -EINVAL.

That would help.

> The current expectation is that the machine driver knows what the
> hardware is capable of

But not necessarily at compile time!  I was hoping to use this as a
mechanism for determining the capabilities at run time.

-- =

Timur Tabi
Linux kernel developer at Freescale
