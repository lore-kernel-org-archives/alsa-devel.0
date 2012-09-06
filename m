From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: snd-usb: "delay: estimated 0, actual 352"
Date: Thu, 6 Sep 2012 09:17:57 +0200
Message-ID: <20120906071757.GB257@x4>
References: <s5hmx1526mg.wl%tiwai@suse.de>
 <20120906060220.GA252@x4>
 <504843BA.2040808@gmail.com>
 <s5hehmfir46.wl%tiwai@suse.de>
 <20120906065340.GA257@x4>
 <50484BEB.4020103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <50484BEB.4020103@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 2012.09.06 at 09:08 +0200, Daniel Mack wrote:
> On 06.09.2012 08:53, Markus Trippelsdorf wrote:
> > On 2012.09.06 at 08:48 +0200, Takashi Iwai wrote:
> >> At Thu, 06 Sep 2012 08:33:30 +0200,
> >> Daniel Mack wrote:
> >>>
> >>> On 06.09.2012 08:02, Markus Trippelsdorf wrote:
> >>>> On 2012.09.04 at 16:40 +0200, Takashi Iwai wrote:
> >>>>> ---------------------------------------------------------------=
-
> >>>>> Sound fixes for 3.6-rc5
> >>>>>
> >>>>> There are nothing scaring, contains only small fixes for HD-aud=
io and
> >>>>> USB-audio:
> >>>>> - EPSS regression fix and GPIO fix for HD-audio IDT codecs
> >>>>> - A series of USB-audio regression fixes that are found since 3=
=2E5 kernel
> >>>>>
> >>>>> ---------------------------------------------------------------=
-
> >>>>> Daniel Mack (4):
> >>>>>       ALSA: snd-usb: Fix URB cancellation at stream start
> >>>>>       ALSA: snd-usb: restore delay information
> >>>>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=20
> >>>> The commit fbcfbf5f above causes the following lines to be print=
ed
> >>>> whenever I start a new song:
> >>>
> >>> Copied Pierre-Louis Bossart - he wrote the code in 294c4fb8 which=
 this
> >>> patch (fbcfbf5f) brings back now.
> >>>
> >>>> delay: estimated 0, actual 352
> >>>> delay: estimated 353, actual 705
> >>>>
> >>>> (44.1 * 8 =3D 352.8)
> >>>>
> >>>> This happens with an USB-DAC that identifies itself as "C-Media =
USB
> >>>> Headphone Set".
> >>>
> >>> And you didn't you see these lines with 3.4?
> >>
> >> Maybe the difference of start condition?
> >>
> >> Markus, does the patch below fix anything?
> >=20
> > Unfortunately no.
> > However reverting the following fixes the problem:
> >=20
> > commit 245baf983cc39524cce39c24d01b276e6e653c9e
> > Author: Daniel Mack <zonque@gmail.com>
> > Date:   Thu Aug 30 18:52:30 2012 +0200
> >=20
> >     ALSA: snd-usb: fix calls to next_packet_size
> >=20
>=20
> No, this one certainly fixes a problem and does the right thing by
> restoring the original code.
>=20
> If you wouldn't state that you didn't see the same effect with 3.4(!)=
,
> before the refactoring done in 3.5, I would believe the device is sim=
ply
> slightly off in its feedback rate and the tighter delay code complain=
s
> about it while compensating, just as it did before.
>=20
> Are there any more than these two lines? And is audio working at all?=
 Is
> it distorted in any way?

There are only these two lines (printed whenever sound starts). Audio i=
s
working just fine with no distortions.

I did see similar lines before when the system load was very high
(happend during "make check" when building glibc).

Here is what Pierre-Louis wrote in November 2011:

=C2=BBThis was supposed to be an informational message, I thought it wa=
s only
enabled for debug. Regular users don't really need to know.=C2=AB

--=20
Markus
