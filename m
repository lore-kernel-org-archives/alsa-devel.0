From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: Allow mulitple usage of codec and cpu
 dai
Date: Thu, 25 Feb 2010 13:06:19 +0000
Message-ID: <20100225130619.GB11071@rakim.wolfsonmicro.main>
References: <1267072011-11744-1-git-send-email-jassi.brar@samsung.com>
	<20100225100326.GC10141@rakim.wolfsonmicro.main>
	<1b68c6791002250300u4c6ff89am5009dc56187be6b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1F266103995
	for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2010 14:06:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791002250300u4c6ff89am5009dc56187be6b1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 25, 2010 at 08:00:13PM +0900, jassi brar wrote:
> On Thu, Feb 25, 2010 at 7:03 PM, Mark Brown

> > I thought I'd been fairly clear last time that the drivers need to have
> > an option to do stuff on startup(). =A0As I said then a separate callba=
ck
> > which is called only on the transitions into and out of active would be
> > fine.

> This is simply the patch, that you asked me to dig out from samsung-git
> and post to the list, adapted to for-2.6.35

I asked you to pull out the bits that maintain active.

> I could drop startup,shutdown,mute-on/off as well, but no codec driver
> would work with that as such. If that's ok, i'll resend the patch.

Honestly I didn't read the rest of the patch after I saw the change to
remove the startup() callback.  Clearly fiddling around with the active
count isn't going to make every possible system work, and it may not be
any use at all, but so long as it doesn't interfere with other users
it's not really a problem.

As I said previously this should really be being done by showing the
mixer as a device within ASoC rather than this way.  Trying to pretend
the mixer isn't there is going to cause problems, the confusion about
when the stream is live being just one of them.
