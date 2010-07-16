From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re:
 =?iso-8859-1?q?=5BPATCH_0/3=5D_ASoC=3A_twl4030/tpa61?=
 =?iso-8859-1?q?30a2=3A=09DB=5FRANGE_mapping_fixes?=
Date: Fri, 16 Jul 2010 14:05:40 +0300
Message-ID: <201007161405.40985.peter.ujfalusi@nokia.com>
References: <1279275431-26922-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100716102404.GE18376@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id E1DC024486
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Jul 2010 13:05:45 +0200 (CEST)
In-Reply-To: <20100716102404.GE18376@sirena.org.uk>
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

Hi,

On Friday 16 July 2010 13:24:05 ext Mark Brown wrote:
> On Fri, Jul 16, 2010 at 01:17:08PM +0300, Peter Ujfalusi wrote:
> > There were 'holes' in the DB_RANGE and SCALE_ITEM mapping, which results
> > failure, when user space requests dB value in these holes, since alsa-l=
ib
> > will fail to find a range, and can not round the requested dB to raw
> > value.
> > =

> > Fixing the drivers I'm maintaining to correctly fill the tlv struct.
> =

> This seems like a bug in alsa-lib to be honest

I did considered to improve alsa-lib as well, but fixing the =

snd_tlv_convert_from_dB is a bit harder IMHO.

> - it doesn't seem right to specify two values for the indexes at the edge=
 of
> each range,

Sort of.
The tlv struct is a lookup table for the dB mapping.
Query the raw value, and it will return the associated dB.
If you ask for dB value, it will go through the table, and try to find the =
best =

matching raw value (with up or down rounding).

There are drivers, which using overlapping table:
pci/es1938.c
soc/codecs/wm8753.c
and now the twl, and tpa driver,

The rest is using non overlapping mapping for dB ranges.

> especially when one of those values is going to be inaccurate.

The dB values are matching at the important points (raw values).

Let's see...
We have the following gain control:
0: -10dB
1: -5dB
2: 0dB
3: 2dB
4: 4dB

in non overlapping (A):
static const unsigned int nonoverlapping_tlv[] =3D {
	TLV_DB_RANGE_HEAD(2),
	0, 2, TLV_DB_SCALE_ITEM(-1000, 500, 0),
	3, 4, TLV_DB_SCALE_ITEM(200, 200, 0),
};

in overlapping (B):
static const unsigned int overlapping_tlv[] =3D {
	TLV_DB_RANGE_HEAD(2),
	0, 2, TLV_DB_SCALE_ITEM(-1000, 500, 0),
	2, 4, TLV_DB_SCALE_ITEM(0, 200, 0),
};

In both cases, if you query based on raw value, you get the same dB.
In both cases, if you ask for -10, -5, 0, 2, or 4 dB, you get the same raw.
In both case, if you ask for less than -10dB, than you get 0 as raw
In both case, if you ask for bigger than 4dB, than it is not changing the v=
olume =

(I think this is really a bug, it should pick 4).

But right now if you ask for dB in the range 0 .. 2 dB:
A: will not find it, since none of the two SCALE range covers it.
B: will find it and rounds it either up or down. the 0 - 2 dB range is in t=
he
   second SCALE.

I do think that these patches are carrying correct fix...

Probably alsa-lib can be fixed somehow to look in between the ranges, when =
it is =

looking for certain dB value, but at first look it is not that straight for=
ward.

Thanks,
P=E9ter
