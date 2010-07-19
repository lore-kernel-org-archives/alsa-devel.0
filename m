From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/3] ASoC: twl4030/tpa6130a2:?DB_RANGE
	mapping fixes
Date: Mon, 19 Jul 2010 12:14:49 +0300
Message-ID: <201007191214.50115.peter.ujfalusi@nokia.com>
References: <1279275431-26922-1-git-send-email-peter.ujfalusi@nokia.com>
	<201007190857.05339.peter.ujfalusi@nokia.com>
	<20100719085140.GA15693@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id A9AF6243EC
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 11:15:11 +0200 (CEST)
In-Reply-To: <20100719085140.GA15693@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

I'm waiting for comments for the series against alsa-lib regarding this iss=
ue...

On Monday 19 July 2010 11:51:41 ext Mark Brown wrote:
> On Mon, Jul 19, 2010 at 08:57:05AM +0300, Peter Ujfalusi wrote:
> > On Friday 16 July 2010 15:33:25 ext Mark Brown wrote:
> > > Isn't this going to get messy when the increments don't line up so th=
at
> > > it's easy to overlap the start of one range with the beginning of the
> > > next?
> > =

> > Well, I assume however writes the driver knows how to build up a lookup
> > table which is consistent, so I don't really see a problem.
> =

> The problem I see is if the hardware step sizes result in discontinuties
> in the scale so you can't easily join the top end of one set of values
> with the bottom end of another you're pretty stuck - joining the ranges
> up will only work if they can be made to overlap which isn't always
> going to be the case.

Yeah, and the tpa6130a2 is even worst than most of the things that I have e=
ver =

seen:
http://focus.ti.com/lit/ds/symlink/tpa6130a2.pdf, page 20
Basically there are no continuous ranges at all (sometimes it feels, that t=
he =

steps are chosen via lottery).

> For example, something like:
> =

> 1: 0
> 2: 2
> 3: 4
> 4: 5
> 5: 7
> 6: 9
> =

> (a bit artificial but you get the idea) is going to be a bit tricky.

I see, but I still don't see problem with this:
non-overlapping (A):
static const unsigned int nonoverlapping_tlv[] =3D {
        TLV_DB_RANGE_HEAD(2),
        1, 3, TLV_DB_SCALE_ITEM(0, 200, 0),
        4, 6, TLV_DB_SCALE_ITEM(500, 200, 0),
};

overlapping (B):
static const unsigned int overlapping_tlv[] =3D {
        TLV_DB_RANGE_HEAD(3),
        1, 3, TLV_DB_SCALE_ITEM(0, 200, 0), /* at raw 3 the dB is 4 */
        3, 4, TLV_DB_SCALE_ITEM(400, 100, 0), /* at raw 4 the dB is 5 */
        4, 6, TLV_DB_SCALE_ITEM(500, 200, 0),
};

B covers all ranges, with 3 sub-range.
A covers the ranges, which has 2dB steps, and leaves a hole for the 1dB ste=
p =

between raw 3, and 4.

> > I'll post patches against alsa-lib to fix the _DB_RANGE handling. It wi=
ll
> > take some time to understand, and fix the code + testing it.
> =

> Thanks.

No problem.

With the patches I have sent for alsa-lib both A and B style of array going=
 to =

be handled correctly.

If you have time, can you take a look at them?

Thanks,
P=E9ter
