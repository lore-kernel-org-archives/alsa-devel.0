From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/10] sound/soc/blackfin: Fix continuation
	line formats
Date: Tue, 2 Feb 2010 11:08:24 +0000
Message-ID: <20100202110824.GF6566@rakim.wolfsonmicro.main>
References: <cover.1264967493.git.joe@perches.com>
	<aee58f4fc07709fe8a34021899e701824a0a6b53.1264967500.git.joe@perches.com>
	<20100201144745.GC26011@rakim.wolfsonmicro.main>
	<1265044080.25140.266.camel@Joe-Laptop.home>
	<8bd0f97a1002012013t5c4a3951ra559a8965d67a672@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EBD24103822
	for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2010 12:08:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <8bd0f97a1002012013t5c4a3951ra559a8965d67a672@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 01, 2010 at 11:13:04PM -0500, Mike Frysinger wrote:
> On Mon, Feb 1, 2010 at 12:08, Joe Perches wrote:

> > There are a few false positives and probably a few missing using

> > =A0 =A0 =A0 =A0grep -rP --include=3D*.[ch] '".*\\$' * | \
> > =A0 =A0 =A0 =A0awk '{ if ((gsub("\"", "\"") % 2) =3D=3D 1) print $0; }'

> > Most of the uses are __asm__ __volatile__ which could be
> > considered unsightly but don't impact logging messages.

> > The rest could/should be fixed.

My point was that it'd be good to also check for just regular use of
continuations in code other than macro definitions.  These are just a
style nit but if there's a script that filters out false positives from
the macros that'd be handy...

> the Blackfin alsa fixes all look good to me, thanks

Running "grep ' \\$' sound/soc/blackfin/*.[ch]" suggests that there's
still some of the continuations I mentioned above in there (plus a lot
of false positives from macros).
