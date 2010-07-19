From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/3] ASoC: twl4030/tpa6130a2:?DB_RANGE
	mapping fixes
Date: Mon, 19 Jul 2010 08:57:05 +0300
Message-ID: <201007190857.05339.peter.ujfalusi@nokia.com>
References: <1279275431-26922-1-git-send-email-peter.ujfalusi@nokia.com>
	<201007161405.40985.peter.ujfalusi@nokia.com>
	<20100716123325.GA18152@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id B1FBD1037F1
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 07:57:19 +0200 (CEST)
In-Reply-To: <20100716123325.GA18152@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Friday 16 July 2010 15:33:25 ext Mark Brown wrote:
> Sure, and the forward mapping in particular seems to make it very clear
> what should be happening here.  The way I'd parse this the ability to
> specify ranges is just a way of saving on typing and we should always
> end up with single mapping entries between raw values and dB values.
> The API is inherently getting a list of specific point values, it's just
> using a compact encoding for some of them.

If all ranges are are covered (even with overlaps, but with consistent mapp=
ing), =

than alsa-lib needs less fixing.
The whole thing boiled down on how the _DB_RANGE is handled in alsa-lib.
It goes through the sub _DB_* ranges, and tries to find the correct mapping.
If we have 'holes' in the array, than it will fail to find the item. In cas=
e of =

non overlapping array, we can have several 'holes' (in between two DB_SCALE=
), so =

alsa-lib seemingly will fail to find the requested dB 'randomly'.

> Isn't this going to get messy when the increments don't line up so that
> it's easy to overlap the start of one range with the beginning of the
> next?

Well, I assume however writes the driver knows how to build up a lookup tab=
le =

which is consistent, so I don't really see a problem.

> > Probably alsa-lib can be fixed somehow to look in between the ranges,
> > when it is looking for certain dB value, but at first look it is not
> > that straight forward.
> =

> Well, I'd expect it to do something like go through all the ranges
> available and look for the closest match which doesn't seem terribly
> complex.  I haven't looked at the code at all, though.

I don't share your concern regarding to overlapping array for TLV, but I ca=
n fix =

alsa-lib instead of the drivers to behave correctly.
I'll post patches against alsa-lib to fix the _DB_RANGE handling. It will t=
ake =

some time to understand, and fix the code + testing it.

Thanks,
P=E9ter
