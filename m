From: Steven Newbury <steve@snewbury.org.uk>
Subject: Re: No speaker output with kernel 3.15 and later
Date: Sat, 12 Jul 2014 00:20:45 +0100
Message-ID: <1405120845.1570.1.camel@snewbury.org.uk>
References: <1404050996.31259.2.camel@snewbury.org.uk>
 <s5hr426sqbq.wl%tiwai@suse.de> <1404215372.2290.0.camel@snewbury.org.uk>
 <s5h61jh8fau.wl%tiwai@suse.de> <1404747250.1983.1.camel@snewbury.org.uk>
 <s5h38edqiqz.wl%tiwai@suse.de> <1404749138.20227.0.camel@snewbury.org.uk>
 <s5hr41wp2d4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1956143850662167371=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from know-smtprelay-omc-10.server.virginmedia.net
 (know-smtprelay-omc-10.server.virginmedia.net [80.0.253.74])
 by alsa0.perex.cz (Postfix) with ESMTP id C57102650D4
 for <alsa-devel@alsa-project.org>; Sat, 12 Jul 2014 01:21:05 +0200 (CEST)
In-Reply-To: <s5hr41wp2d4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Anssi Hannula <anssi.hannula@iki.fi>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1956143850662167371==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-d7uMQ2COqFFfEVD8FL/H"


--=-d7uMQ2COqFFfEVD8FL/H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2014-07-08 at 12:32 +0200, Takashi Iwai wrote:
> At Mon, 07 Jul 2014 17:05:43 +0100,
> Steven Newbury wrote:
> >  On Mon, 2014-07-07 at 17:41 +0200, Takashi Iwai wrote:
> >     > At Mon, 07 Jul 2014 16:34:10 +0100,
> >     > Steven Newbury wrote:
> >     > >  On Tue, 2014-07-01 at 13:54 +0200, Takashi Iwai wrote:
> >     > > >  At Tue, 01 Jul 2014 12:49:32 +0100,
> >     > > >  Steven Newbury wrote:
> >     > > > >   On Mon, 2014-06-30 at 11:24 +0200, Takashi Iwai=20
> > wrote:
> >     > > > > >   At Sun, 29 Jun 2014 15:09:56 +0100,
> >     > > > > >   Steven Newbury wrote:
> >     > > > > > >    I sent
> >     > > > > > >   Takashi an email mentioning this regression a=20
> > month ago,
> >     > > > > > > and
> >     > > > > > >    it's
> >     > > > > > >   taken me this long to send this email... :-$
> >     > > > > > >    Since updating to
> >     > > > > > >   kernel versions >=3D3.15 I've had no audio from my
> >     > > > > > >    laptop speakers.
> >     > > > > > >   Earlier versions worked fine.
> >     > > > > > >    It's a CLEVO W270EUQ laptop.  The
> >     > > > > > >   output mixer device is showing up,
> >     > > > > > >    but no sound comes out at any
> >     > > > > > >   volume level.
> >     > > > > > >    As requested I've attached compressed=20
> > alsa-info.sh
> >     > > > > > >   output for both the
> >     > > > > > >    working and non-working cases.
> >     > > > > > >    I'm perfectly
> >     > > > > > >   willing to test patches etc.
> >     > > > > >   Hm, I see no significant difference between 3.14=20
> > and 3.15
> >     > > > > >  alsa-info.sh
> >     > > > > >   outputs, and there's been very little change for=20
> > VIA codecs
> >     > > > > >  between
> >     > > > > >   these versions.  So, in short, I have no idea what=20
> > went
> >     > > > > > wrong.
> >     > > > > >   Could you double-check whether it's really a=20
> > kernel issue?
> >     > > > > >   That is, switch between 3.14 and 3.15 and confirm=20
> > the
> >     > > > > > problem
> >     > > > > >  happens
> >     > > > > >   only with 3.15.  Also, for testing the sound, try=20
> > like
> >     > > > > >           % aplay -Dplughw -vv foo.wav
> >     > > > >   Checked again.
> >     > > > >   3.16-rc2: silence
> >     > > > >   3.14.3: works fine
> >     > > >  Then I'd suggest to bisect between 3.14 and 3.15.
> >     > >  Somewhat surprisingly I ended up here:
> >     > >  dcb32ecd9a533f47ab652c5c5680bc50a7a822cd is the first bad=20
> > commit
> >     > >  commit dcb32ecd9a533f47ab652c5c5680bc50a7a822cd
> >     > >  Author: Anssi Hannula <anssi.hannula@iki.fi>
> >     > >  Date:   Tue Apr 8 12:36:42 2014 +0300
> >     > >      ALSA: hda - Do not assign streams in reverse order
> >     > >      Currently stream numbers are assigned in reverse=20
> > order.
> >     > >      Unfortunately commit 7546abfb8e1f9933b5 ("ALSA: hda -
> >     > > Increment
> >     > >      default stream numbers for AMD HDMI controllers")=20
> > assumed
> >     > > this was not
> >     > >      the case (specifically, it had the "old cards had=20
> > single
> >     > > device only"
> >     > >      =3D> "extra unused stream numbers do not matter"=20
> > assumption),
> >     > > causing
> >     > >      non-working audio regressions for AMD Radeon HDMI=20
> > users.
> >     > >      Change the stream numbers to be assigned in forward=20
> > order.
> >     > >      The benefit is that regular audio playback will still=20
> > work
> >     > > even if the
> >     > >      assumed stream count is too high, downside is that a=20
> > too high
> >     > > stream
> >     > >      count may remain hidden.
> >     > >      Bugzilla:=20
> > https://bugs.freedesktop.org/show_bug.cgi?id=3D77002
> >     > >      Reported-by: Christian G=C3=83=C2=BCdel <cg@dmesg.ch>
> >     > >      Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> >     > >      Tested-by: Christian G=C3=83=C2=BCdel <cg@dmesg.ch> # 3.14
> >     > >      Cc: Alex Deucher <alexander.deucher@amd.com>
> >     > >      Signed-off-by: Takashi Iwai <tiwai@suse.de>
> >     > >  :040000 040000 6ed3a982a9600333b07a42169db5173fa75b8618
> >     > > b7ff28d00007f988221ba58c9d3f501fdb3a7583 M        sound
> >     >
> >     > Interesting.  Does reverting this commit fix the issue?
> >     > Just run "git revert=20
> > dcb32ecd9a533f47ab652c5c5680bc50a7a822cd", and
> >     > test it.
> >     >
> >     I just did this on top of my rebased local git tree off=20
> > linus/master
> >     and indeed reverting does make the speakers work again.*
> =20
> OK, thanks for confirmation.
> So, by some reason, the controller (or codec) needs to use the last
> entry (in this case it's Panther Point).  I cannot understand why=20
> this
> fails, but it's so...
> =20
> The patch below does revert conditionally only for Intel controller
> chips.  This should work instead of git revert.  Let me know if it
> really works for you.
> =20
Indeed t works.

> But, we still want to understand why.  Maybe assigning the device
> manually to an explicit value and figuring out which dev# doesn't=20
> work
> would be helpful.
How do you want me to test this?

> =20
> =20
> thanks,
> =20
> Takashi
> =20
> ---
> diff --git a/sound/pci/hda/hda_controller.c=20
> b/sound/pci/hda/hda_controller.c
> index 06f39c126ba4..8337645aa7a5 100644
> --- a/sound/pci/hda/hda_controller.c
> +++ b/sound/pci/hda/hda_controller.c
> @@ -194,7 +194,8 @@ azx_assign_device(struct azx *chip, struct=20
> snd_pcm_substream *substream)
>                                  dsp_unlock(azx_dev);
>                                  return azx_dev;
>                          }
> -                        if (!res)
> +                        if (!res ||
> +                            (chip->driver_caps & AZX_DCAPS_REVERSE_ASSIG=
N))
>                                  res =3D azx_dev;
>                  }
>                  dsp_unlock(azx_dev);
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 75b52c4cd70d..dfc88831f1be 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -272,7 +272,7 @@ enum {
>  /* quirks for Intel PCH */
>  #define AZX_DCAPS_INTEL_PCH_NOPM \
>          (AZX_DCAPS_SCH_SNOOP | AZX_DCAPS_BUFSIZE | \
> -         AZX_DCAPS_COUNT_LPIB_DELAY)
> +         AZX_DCAPS_COUNT_LPIB_DELAY | AZX_DCAPS_REVERSE_ASSIGN)
>  #define AZX_DCAPS_INTEL_PCH \
>          (AZX_DCAPS_INTEL_PCH_NOPM | AZX_DCAPS_PM_RUNTIME)
> diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
> index 33eb5d027d38..949cd437eeb2 100644
> --- a/sound/pci/hda/hda_priv.h
> +++ b/sound/pci/hda/hda_priv.h
> @@ -166,6 +166,7 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2,=20
> SDO3 };
>  #define AZX_DCAPS_BUFSIZE        (1 << 21)        /* no buffer size alig=
nment */
>  #define AZX_DCAPS_ALIGN_BUFSIZE        (1 << 22)        /* buffer size a=
lignment=20
> */
>  #define AZX_DCAPS_4K_BDLE_BOUNDARY (1 << 23)        /* BDLE in 4k bounda=
ry=20
> */
> +#define AZX_DCAPS_REVERSE_ASSIGN (1 << 24)        /* Assign devices in=
=20
> reverse order */
>  #define AZX_DCAPS_COUNT_LPIB_DELAY  (1 << 25)        /* Take LPIB as del=
ay=20
> */
>  #define AZX_DCAPS_PM_RUNTIME        (1 << 26)        /* runtime PM suppo=
rt */
>  #define AZX_DCAPS_I915_POWERWELL (1 << 27)        /* HSW i915 powerwell=
=20
> support */

--=-d7uMQ2COqFFfEVD8FL/H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlPAcU8ACgkQGcb56gMuC60L7gCfY5Up8iw0ZfWaC9RXJWtHnoAF
N6QAniHkORJdfdXGDmLBUpeCh1O7T4e6
=RZSY
-----END PGP SIGNATURE-----

--=-d7uMQ2COqFFfEVD8FL/H--


--===============1956143850662167371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1956143850662167371==--
