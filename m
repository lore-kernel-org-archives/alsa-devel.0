From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 4/4] ALSA: ASoC: Davinci: Fixed missing
	McBSP pinmux for SFFSDR
Date: Tue, 10 Mar 2009 10:10:09 -0800
Message-ID: <200903101110.10447.david-b@pacbell.net>
References: <1236655929-31688-1-git-send-email-hugo@hugovil.com>
	<20090310130734.c877b1f6.hugo@hugovil.com>
	<87y6vds3ph.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com (smtp125.sbc.mail.sp1.yahoo.com
	[69.147.65.184]) by alsa0.perex.cz (Postfix) with SMTP id 3AA9C1037FB
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2009 19:10:12 +0100 (CET)
In-Reply-To: <87y6vds3ph.fsf@deeprootsystems.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Hugo Villeneuve <hugo@hugovil.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 10 March 2009, Kevin Hilman wrote:
> >
> > Ok, so the patch affecting sound/soc/davinci/davinci-evm.c SHOULD have
> > been submitted to ALSA first.
> =

> Yes, but it should've been a patch against an ASoC tree, not against
> DaVinci git which may contain things not (yet) in the ASoC tree.
> =

> > It is not easy following you guys. You say something and then do the
> > opposite.
> =

> Heh, sorry.
> =

> Do as I do, not as I say. =A0;)

I'd say "my bad" ... but in these cases there's seems to be no
better solution than having the DaVinci GIT tree diverge a bit
from mainline ASoC, in synchrony with arch/arm/mach-davinci
which is also diverging from mainline.

There's a general rule that patches should not break builds.
And that rule is why there are several ASoC patches I've not
yet sent to mainline.

The whole ASoC/DaVinci thing has been nothing but build
breakage however, since it depends on EDMA patches which
haven't yet gone to mainline.  (But, I believe, will soon
do so, at which point that breakage will stop.)

- Dave
