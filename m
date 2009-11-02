From: Neil Jones <neiljay@gmail.com>
Subject: Re: [PATCH] sound/soc/codecs: Add support for the
	wm8727 DAC.
Date: Mon, 2 Nov 2009 13:21:01 +0000
Message-ID: <91f916b90911020521p2cd1d001y5bdd44a4cdfe0642@mail.gmail.com>
References: <91f916b90911020354s7f22d0a8pba2ac82525663d8e@mail.gmail.com>
	<20091102120942.GI29351@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f224.google.com (mail-ew0-f224.google.com
	[209.85.219.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C08E103898
	for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2009 14:21:02 +0100 (CET)
Received: by ewy24 with SMTP id 24so4510608ewy.46
	for <alsa-devel@alsa-project.org>; Mon, 02 Nov 2009 05:21:01 -0800 (PST)
In-Reply-To: <20091102120942.GI29351@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 2, 2009 at 12:09 PM, Mark Brown <
broonie@opensource.wolfsonmicro.com> wrote:

> On Mon, Nov 02, 2009 at 11:54:15AM +0000, Neil Jones wrote:
>
> Thanks for this - there's a few relatively minor issues below.
>
> Please remember to CC maintainers on patches, this helps avoid them
> getting missed on busy mailing lists.
>

  Ok no probs, are you the maintainer ?


> Your MUA has word wrapped your post - this is going to upset patch.
> There are some hints on MUA configuration in
> Documentation/email-clients.txt
> which might help.  If all else fails an attachment (without a copy of
> the patch in the body of the mail) usually works.
>

   Again ok, I've tried my gmail acount this time, as i have similar problem
with
   patches sent via exchange.

 You might want to run your patch through scripts/checkpatch.pl - I think
> there's some indentation issues (I'm not 100% sure that this isn't your
> MUA mangling things, though).
>
> I did its clean just email client no doubt.
>
> This should be converted to register a platform driver for the device
> and do the DAI registration.  Some older drivers don't do this but it
> will be required going forward for newer framework features so it's
> mandatory for new drivers.
>
> See wm8350 for an example of registering off a platform driver probe,
> it's just a case of calling the register/unregister functions from the
> platform driver probe/remove functions and assigning dai->dev to be the
> struct device for the platform driver before you register the DAI.
>

   No probs, cheers for the feedback.
