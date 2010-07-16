From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] ASoC: twl4030/tpa6130a2:?DB_RANGE
 mapping fixes
Date: Fri, 16 Jul 2010 13:33:25 +0100
Message-ID: <20100716123325.GA18152@rakim.wolfsonmicro.main>
References: <1279275431-26922-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100716102404.GE18376@sirena.org.uk>
	<201007161405.40985.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 98616103806
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 14:33:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201007161405.40985.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 16, 2010 at 02:05:40PM +0300, Peter Ujfalusi wrote:
> On Friday 16 July 2010 13:24:05 ext Mark Brown wrote:

> > - it doesn't seem right to specify two values for the indexes at the edge of
> > each range,

> Sort of.
> The tlv struct is a lookup table for the dB mapping.
> Query the raw value, and it will return the associated dB.
> If you ask for dB value, it will go through the table, and try to find the best 
> matching raw value (with up or down rounding).

Sure, and the forward mapping in particular seems to make it very clear
what should be happening here.  The way I'd parse this the ability to
specify ranges is just a way of saving on typing and we should always
end up with single mapping entries between raw values and dB values.
The API is inherently getting a list of specific point values, it's just
using a compact encoding for some of them.

> In both cases, if you query based on raw value, you get the same dB.
> In both cases, if you ask for -10, -5, 0, 2, or 4 dB, you get the same raw.
> In both case, if you ask for less than -10dB, than you get 0 as raw
> In both case, if you ask for bigger than 4dB, than it is not changing the volume 
> (I think this is really a bug, it should pick 4).

Isn't this going to get messy when the increments don't line up so that
it's easy to overlap the start of one range with the beginning of the
next?

> Probably alsa-lib can be fixed somehow to look in between the ranges, when it is 
> looking for certain dB value, but at first look it is not that straight forward.

Well, I'd expect it to do something like go through all the ranges
available and look for the closest match which doesn't seem terribly
complex.  I haven't looked at the code at all, though.
