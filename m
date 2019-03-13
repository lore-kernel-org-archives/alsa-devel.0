From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/7] drm/edid: Allow to ignore the audio EDID data
Date: Wed, 13 Mar 2019 15:03:54 +0100
Message-ID: <20190313140354.kh64sleozmuqu5hg@flea>
References: <cover.39761cc6c9d070568123e328cd216367c4c660b4.1551711042.git-series.maxime.ripard@bootlin.com>
 <4914bea9fc3ef3deaffa39ab691dbd9a76461e97.1551711042.git-series.maxime.ripard@bootlin.com>
 <87wole76ws.fsf@anholt.net>
 <CADnq5_PZ99hD=SgDrsDL-5zKMEXHxve205r_6xJpv9a9TM1ZHw@mail.gmail.com>
 <20190305091240.sbkvdwosocaytx22@flea>
 <20190305152413.GD16917@intel.com>
 <20190305191554.GA3888@intel.com>
 <CADnq5_OhTFJtQ0HRDUqAxxQeL6AFauazYaO76J0FhPG8ooYhkw@mail.gmail.com>
 <20190305193638.GB3888@intel.com> <s5hmulzuk8u.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1397002818=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <s5hmulzuk8u.wl-tiwai@suse.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, eben@raspberrypi.org, David Airlie <airlied@linux.ie>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>, Sean Paul <seanpaul@chromium.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1397002818==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="liss4z67eskjdrts"
Content-Disposition: inline


--liss4z67eskjdrts
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 13, 2019 at 11:44:17AM +0100, Takashi Iwai wrote:
> On Tue, 05 Mar 2019 20:36:38 +0100,
> Ville Syrj=E4l=E4 wrote:
> >=20
> > On Tue, Mar 05, 2019 at 02:21:04PM -0500, Alex Deucher wrote:
> > > On Tue, Mar 5, 2019 at 2:15 PM Ville Syrj=E4l=E4
> > > <ville.syrjala@linux.intel.com> wrote:
> > > >
> > > > On Tue, Mar 05, 2019 at 05:24:13PM +0200, Ville Syrj=E4l=E4 wrote:
> > > > > On Tue, Mar 05, 2019 at 10:12:40AM +0100, Maxime Ripard wrote:
> > > > > > On Mon, Mar 04, 2019 at 03:05:31PM -0500, Alex Deucher wrote:
> > > > > > > On Mon, Mar 4, 2019 at 2:53 PM Eric Anholt <eric@anholt.net> =
wrote:
> > > > > > > >
> > > > > > > > Maxime Ripard <maxime.ripard@bootlin.com> writes:
> > > > > > > >
> > > > > > > > > In some cases, in order to accomodate with displays with =
poor EDIDs, we
> > > > > > > > > need to ignore that the monitor alledgedly supports audio=
 output and
> > > > > > > > > disable the audio output.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/gpu/drm/drm_edid.c | 8 ++++++++
> > > > > > > > >  1 file changed, 8 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm=
/drm_edid.c
> > > > > > > > > index 990b1909f9d7..c0258b011bb2 100644
> > > > > > > > > --- a/drivers/gpu/drm/drm_edid.c
> > > > > > > > > +++ b/drivers/gpu/drm/drm_edid.c
> > > > > > > > > @@ -4190,6 +4190,11 @@ bool drm_detect_hdmi_monitor(struc=
t edid *edid)
> > > > > > > > >  }
> > > > > > > > >  EXPORT_SYMBOL(drm_detect_hdmi_monitor);
> > > > > > > > >
> > > > > > > > > +static bool ignore_edid_audio =3D false;
> > > > > > > > > +module_param(ignore_edid_audio, bool, 0644);
> > > > > > > > > +MODULE_PARM_DESC(ignore_edid_audio,
> > > > > > > > > +              "Ignore the EDID and always consider that =
a monitor doesn't have audio capabilities");
> > > > > > > > > +
> > > > > > > > >  /**
> > > > > > > > >   * drm_detect_monitor_audio - check monitor audio capabi=
lity
> > > > > > > > >   * @edid: EDID block to scan
> > > > > > > > > @@ -4209,6 +4214,9 @@ bool drm_detect_monitor_audio(struc=
t edid *edid)
> > > > > > > > >       bool has_audio =3D false;
> > > > > > > > >       int start_offset, end_offset;
> > > > > > > > >
> > > > > > > > > +     if (ignore_edid_audio)
> > > > > > > > > +             goto end;
> > > > > > > > > +
> > > > > > > > >       edid_ext =3D drm_find_cea_extension(edid);
> > > > > > > > >       if (!edid_ext)
> > > > > > > > >               goto end;
> > > > > > > >
> > > > > > > > It looks like the motivation for the original flag on Raspb=
erry Pi was
> > > > > > > > "I've got a non-audio monitor, but the system comes up tryi=
ng to play
> > > > > > > > audio to HDMI instead of the analog jack".  Do we have some=
 way for DRM
> > > > > > > > to communicate to ALSA that this is not the right place to =
try to play
> > > > > > > > audio by default?
> > > > > > >
> > > > > > > Apparently not.  We have users using debug knobs in our drive=
rs to
> > > > > > > disable display audio because ALSA defaults to that rather th=
an other
> > > > > > > audio.
> > > > > >
> > > > > > I guess one way to do this would be to register the card only w=
hen an
> > > > > > audio-capable monitor is connected instead of doing this at pro=
be
> > > > > > time. I'm not sure how convenient it is for userspace though.
> > > > >
> > > > > We already provide the ELD to alsa. I'm pretty sure pulseaudio us=
es
> > > > > that stuff somehow to figure out whether to play audio over HDMI.
> > > > > But since I don't use pulseaudio myself I can't be 100% sure.
> > > > >
> > > > > Cc:ing Takashi/alsa folks for confirmation.
> > > >
> > > > I forgot that the .pin_eld_notify() stuff is i915 specific. But
> > > > I see some kind of hdmi_codec_ops thing used by some other drivers.
> > > > I guess that is supposed to achieve the same thing more or less?
> > > > I'm not immediately seeing any kind of drm->alsa notification
> > > > hook in there though.
> > >=20
> > > On AMD hw, the GPU has backdoor access to some of the audio state, so
> > > when stuff happens on the GPU side, it's reflected on the audio side
> > > automatically.
> >=20
> > Right. i915 has a similar thing (my theory is that it's basically
> > an industry wide hardware workaround for inflexible Windows driver
> > architecture). But that was problematic for some power management
> > related reasons (IIRC) so we added a software mechanism for it.
> > Though I believe we still write the ELD into the hardware buffer
> > as well.
>=20
> I'm late to the game as I've been off in the last week, and here is
> just the confirmation.
>=20
> The direct communication from drm to ALSA via component has been
> implemented currently only for i915.  I had some patches to enable the
> feature for radeon and amdgpu, but the enablement on amdgpu DC is
> still missing, and the work is pending for now.
>=20
> For other drivers, we'd need more or less similar mechanism.
> We might want to choose a better infrastructure than the component
> binding, but it's a thing to be discussed.

I guess I would be interested in working on this.

I've looked at the ELD situation on vc4, and even though the control
is exposed for the vc4 driver, and that content seems to be ok,
pulseaudio doesn't pick it up.

My understanding is that pulseaudio waits on an ALSA event before
looking at the ELD control, and only does so for the device that are
considered HDMI, but I'm not quite sure what policy it has for that
yet...

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--liss4z67eskjdrts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIkNygAKCRDj7w1vZxhR
xax5AP44KOcZvFd1Yjw8IOZT007Ct2TZ3ZXq9zWmwxMaq16PZQEAnZ+6TG4/ONCW
KXShFfYSdA3t481uJetFj8aWQuwnXw8=
=ZNDP
-----END PGP SIGNATURE-----

--liss4z67eskjdrts--

--===============1397002818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1397002818==--
