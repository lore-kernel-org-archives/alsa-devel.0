From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/9] Add DSP topology management for SKL
Date: Mon, 21 Sep 2015 22:17:45 +0530
Message-ID: <20150921164745.GO2381@localhost>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <20150903081454.GU13546@localhost>
 <20150911114500.GK12027@sirena.org.uk>
 <20150919165612.GA32072@sirena.org.uk>
 <20150921035739.GH2381@localhost>
 <20150921163353.GU30445@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8812306274806517835=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 15306261519
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 18:52:38 +0200 (CEST)
In-Reply-To: <20150921163353.GU30445@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8812306274806517835==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vjQsMS/9MbKYGLq"
Content-Disposition: inline


--5vjQsMS/9MbKYGLq
Content-Type: multipart/mixed; boundary="3xoW37o/FfUZJwQG"
Content-Disposition: inline


--3xoW37o/FfUZJwQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2015 at 09:33:53AM -0700, Mark Brown wrote:
> On Mon, Sep 21, 2015 at 09:27:39AM +0530, Vinod Koul wrote:
> > We did decide to use DPCM, DAPM and topology here to solve manging the =
DSP
> > using these frameworks. yes hard coding a simple mixer and two pipes co=
uld
> > have made code look easy to follow but then we would be redoing those b=
its
> > as we scale these to defferent designs.
>=20
> Sure, and my point here is that that this process of redoing things
> would most likely be a lot faster since it'd be a lot easier to follow
> which would make the review a lot easier.
>=20
> > And to provide what we are trying here I have attached the SKL Topology=
 conf
> > file to give a picture of topology we are trying to build as a referenc=
e.
>=20
> I think you missed the attachment here...

Oops sorry about that, here you go

--=20
~Vinod

--3xoW37o/FfUZJwQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="skl_i2s.conf"
Content-Transfer-Encoding: quoted-printable

SectionControlMixer."media0_mixin" {
	index "1"
=09
	max "1"
	invert "false"
	no_pm "true"

	channel."fl" {
		reg "-1"
		shift "0"
	}

	channel."fr" {
		reg "-1"
		shift "0"
	}

	ops."ctl" {
		info "64"
		get "64"
		put "64"
	}
}

SectionControlMixer."media1_mixin" {
	index "1"
=09
	max "1"
	invert "false"
	no_pm "true"

	channel."fl" {
		reg "-1"
		shift "0"
	}

	channel."fr" {
		reg "-1"
		shift "0"
	}

	ops."ctl" {
		info "64"
		get "64"
		put "64"
	}
}

SectionControlMixer."media2_mixin" {
	index "1"
=09
	max "1"
	invert "false"
	no_pm "true"

	channel."fl" {
		reg "-1"
		shift "0"
	}

	channel."fr" {
		reg "-1"
		shift "0"
	}

	ops."ctl" {
		info "64"
		get "64"
		put "64"
	}
}

SectionControlMixer."media3_mixin" {
	index "1"
=09
	max "1"
	invert "false"
	no_pm "true"

	channel."fl" {
		reg "-1"
		shift "0"
	}

	channel."fr" {
		reg "-1"
		shift "0"
	}

	ops."ctl" {
		info "64"
		get "64"
		put "64"
	}
}

SectionControlMixer."speech_mixin" {
	index "1"
=09
	max "1"
	invert "false"
	no_pm "true"

	channel."fl" {
		reg "-1"
		shift "0"
	}

	channel."fr" {
		reg "-1"
		shift "0"
	}

	ops."ctl" {
		info "64"
		get "64"
		put "64"
	}
}

SectionControlMixer."tone_mixin" {
	index "1"
=09
	max "1"
	invert "false"
	no_pm "true"

	channel."fl" {
		reg "-1"
		shift "0"
	}

	channel."fr" {
		reg "-1"
		shift "0"
	}

	ops."ctl" {
		info "64"
		get "64"
		put "64"
	}
}

SectionControlMixer."dmic01_hifi_mixin" {
	index "1"
=09
	max "1"
	invert "false"
	no_pm "true"

	channel."fl" {
		reg "-1"
		shift "0"
	}

	channel."fr" {
		reg "-1"
		shift "0"
	}

	ops."ctl" {
		info "64"
		get "64"
		put "64"
	}
}

SectionControlMixer."dmic23_hifi_mixin" {
	index "1"
=09
	max "1"
	invert "false"
	no_pm "true"

	channel."fl" {
		reg "-1"
		shift "0"
	}

	channel."fr" {
		reg "-1"
		shift "0"
	}

	ops."ctl" {
		info "64"
		get "64"
		put "64"
	}
}

SectionControlMixer."dmic01_voice_mixin" {
	index "1"
=09
	max "1"
	invert "false"
	no_pm "true"

	channel."fl" {
		reg "-1"
		shift "0"
	}

	channel."fr" {
		reg "-1"
		shift "0"
	}

	ops."ctl" {
		info "64"
		get "64"
		put "64"
	}
}

SectionControlMixer."dmic23_voice_mixin" {
	index "1"
=09
	max "1"
	invert "false"
	no_pm "true"

	channel."fl" {
		reg "-1"
		shift "0"
	}

	channel."fr" {
		reg "-1"
		shift "0"
	}

	ops."ctl" {
		info "64"
		get "64"
		put "64"
	}
}

SectionControlMixer."codec0_in_mixin" {
	index "1"
=09
	max "1"
	invert "false"
	no_pm "true"

	channel."fl" {
		reg "-1"
		shift "0"
	}

	channel."fr" {
		reg "-1"
		shift "0"
	}

	ops."ctl" {
		info "64"
		get "64"
		put "64"
	}
}

SectionControlMixer."codec1_in_mixin" {
	index "1"
=09
	max "1"
	invert "false"
	no_pm "true"

	channel."fl" {
		reg "-1"
		shift "0"
	}

	channel."fr" {
		reg "-1"
		shift "0"
	}

	ops."ctl" {
		info "64"
		get "64"
		put "64"
	}
}

SectionWidget."codec0_out" {

	index "1"
	type "aif_out"
	no_pm "true"
}

SectionWidget."codec1_out" {

	index "1"
	type "aif_out"
	no_pm "true"
}

SectionWidget."iDisp_out" {

	index "1"
	type "aif_out"
	no_pm "true"
}

SectionWidget."dmic01_hifi" {

	index "1"
	type "aif_in"
	no_pm "true"
}

SectionWidget."dmic23_hifi" {

	index "1"
	type "aif_in"
	no_pm "true"
}

SectionWidget."codec0_in" {

	index "1"
	type "aif_in"
	no_pm "true"
}

SectionWidget."codec1_in" {

	index "1"
	type "aif_in"
	no_pm "true"
}

SectionWidget."media2_in cpr vmix 0" {
	index "1"
	type "mixer"
	no_pm "true"
	event_type "3"
	event_flags "15"
	subseq "0"

	data "media2_in cpr vmix 0"
}

SectionWidget."media3_in cpr vmix 0" {
	index "1"
	type "mixer"
	no_pm "true"
	event_type "3"
	event_flags "15"
	subseq "0"

	data "media3_in cpr vmix 0"
}

SectionWidget."media01_out cpr vmix 0" {
	index "1"
	type "mixer"
	no_pm "true"
	event_type "3"
	event_flags "15"
	subseq "0"

	data "media01_out cpr vmix 0"
}

SectionWidget."codec0_in cpr vmix 0" {
	index "1"
	type "mixer"
	no_pm "true"
	event_type "3"
	event_flags "15"
	subseq "0"

	data "codec0_in cpr vmix 0"
}

SectionWidget."codec1_in cpr vmix 0" {
	index "1"
	type "mixer"
	no_pm "true"
	event_type "3"
	event_flags "15"
	subseq "0"

	data "codec1_in cpr vmix 0"
}

SectionWidget."dmic01_hifi cpr vmix 0" {
	index "1"
	type "mixer"
	no_pm "true"
	event_type "3"
	event_flags "15"
	subseq "0"

	data "dmic01_hifi cpr vmix 0"
}

SectionWidget."dmic23_hifi cpr vmix 0" {
	index "1"
	type "mixer"
	no_pm "true"
	event_type "3"
	event_flags "15"
	subseq "0"

	data "dmic23_hifi cpr vmix 0"
}

SectionWidget."codec1_out cpr 0" {
	index "1"
	type "mixer"
	no_pm "true"
	event_type "4"
	subseq "0"

	data "codec1_out cpr 0"
}

SectionWidget."codec0_out cpr 0" {
	index "1"
	type "mixer"
	no_pm "true"
	event_type "4"
	subseq "0"

	data "codec0_out cpr 0"
}

SectionWidget."iDisp_out cpr 0" {
	index "1"
	type "mixer"
	no_pm "true"
	event_type "4"
	subseq "0"

	data "iDisp_out cpr 0"
}

SectionWidget."media0_out cpr 0" {
	index "1"
	type "mixer"
	no_pm "true"
	subseq "0"

	data "media0_out cpr 0"
}

SectionWidget."media2_out cpr 0" {
	index "1"
	type "mixer"
	no_pm "true"
	subseq "0"

	data "media2_out cpr 0"
}

SectionWidget."codec1_out_mixout mix 0" {
	index "1"
	type "mixer"
	no_pm "true"
	event_type "1"
	event_flags "15"
	subseq "10"
=09
	data "codec1_out_mixout mix 0"

	mixer [
		"media0_mixin"
		"media1_mixin"
		"media2_mixin"
		"media3_mixin"
		"speech_mixin"
		"tone_mixin"
		"dmic01_hifi_mixin"
		"dmic23_hifi_mixin"
		"dmic01_voice_mixin"
		"dmic23_voice_mixin"
		"codec0_in_mixin"
		"codec1_in_mixin"
	]
}

SectionWidget."media0_mixout mix 0" {
	index "1"
	type "mixer"
	no_pm "true"
	event_type "1"
	event_flags "15"
	subseq "10"
=09
	data "media0_mixout mix 0"

	mixer [
		"media0_mixin"
		"media1_mixin"
		"media2_mixin"
		"media3_mixin"
		"speech_mixin"
		"tone_mixin"
		"dmic01_hifi_mixin"
		"dmic23_hifi_mixin"
		"dmic01_voice_mixin"
		"dmic23_voice_mixin"
		"codec0_in_mixin"
		"codec1_in_mixin"
	]
}

SectionWidget."media2_mixout mix 0" {
	index "1"
	type "mixer"
	no_pm "true"
	event_type "1"
	event_flags "15"
	subseq "10"
=09
	data "media2_mixout mix 0"

	mixer [
		"media0_mixin"
		"media1_mixin"
		"media2_mixin"
		"media3_mixin"
		"speech_mixin"
		"tone_mixin"
		"dmic01_hifi_mixin"
		"dmic23_hifi_mixin"
		"dmic01_voice_mixin"
		"dmic23_voice_mixin"
		"codec0_in_mixin"
		"codec1_in_mixin"
	]
}

SectionWidget."codec0_out_mixout mix 0" {
	index "1"
	type "mixer"
	no_pm "true"
	event_type "1"
	event_flags "15"
	subseq "10"
=09
	data "codec0_out_mixout mix 0"

	mixer [
		"media0_mixin"
		"media1_mixin"
		"media2_mixin"
		"media3_mixin"
		"speech_mixin"
		"tone_mixin"
		"dmic01_hifi_mixin"
		"dmic23_hifi_mixin"
		"dmic01_voice_mixin"
		"dmic23_voice_mixin"
		"codec0_in_mixin"
		"codec1_in_mixin"
	]
}

SectionWidget."iDisp_out_mixout mix 0" {
	index "1"
	type "mixer"
	no_pm "true"
	event_type "1"
	event_flags "15"
	subseq "10"
=09
	data "iDisp_out_mixout mix 0"

	mixer [
		"media0_mixin"
		"media1_mixin"
		"media2_mixin"
		"media3_mixin"
		"speech_mixin"
		"tone_mixin"
		"dmic01_hifi_mixin"
		"dmic23_hifi_mixin"
		"dmic01_voice_mixin"
		"dmic23_voice_mixin"
		"codec0_in_mixin"
		"codec1_in_mixin"
	]
}

SectionWidget."media2_mixin" {
	index "1"
	type "pga"
	no_pm "true"
	event_type "4"
	event_flags "15"
	subseq "10"

	data "media2_mixin"
}

SectionWidget."dmic01_hifi_mixin" {
	index "1"
	type "pga"
	no_pm "true"
	event_type "4"
	event_flags "15"
	subseq "10"

	data "dmic01_hifi_mixin"
}

SectionWidget."dmic23_hifi_mixin" {
	index "1"
	type "pga"
	no_pm "true"
	event_type "4"
	event_flags "15"
	subseq "10"

	data "dmic23_hifi_mixin"
}

SectionWidget."media3_mixin" {
	index "1"
	type "pga"
	no_pm "true"
	event_type "4"
	event_flags "15"
	subseq "10"

	data "media3_mixin"
}

SectionWidget."codec0_in_mixin" {
	index "1"
	type "pga"
	no_pm "true"
	event_type "4"
	event_flags "15"
	subseq "10"

	data "codec0_in_mixin"
}

SectionWidget."codec1_in_mixin" {
	index "1"
	type "pga"
	no_pm "true"
	event_type "4"
	event_flags "15"
	subseq "10"

	data "codec1_in_mixin"
}

SectionPCMCapabilities."System Playback" {

	formats "S24_LE,S16_LE"
	rate_min "48000"
	rate_max "48000"
	channels_min "2"
	channels_max "2"
}

SectionGraph."Pipeline 1 Graph" {

	index "1"

	lines [
		"media2_in cpr vmix 0, , System Playback"
		"media2_mixin, , media2_in cpr vmix 0"
		"media3_in cpr vmix 0, , Deepbuffer Playback"
		"media3_mixin, , media3_in cpr vmix 0"
		"codec1_out_mixout mix 0, media0_mixin, media0_mixin"
		"codec1_out_mixout mix 0, media1_mixin, media1_mixin"
		"codec1_out_mixout mix 0, media2_mixin, media2_mixin"
		"codec1_out_mixout mix 0, media3_mixin, media3_mixin"
		"codec1_out_mixout mix 0, speech_mixin, speech_mixin"
		"codec1_out_mixout mix 0, tone_mixin, tone_mixin"
		"codec1_out_mixout mix 0, dmic01_hifi_mixin, dmic01_hifi_mixin"
		"codec1_out_mixout mix 0, dmic23_hifi_mixin, dmic23_hifi_mixin"
		"codec1_out_mixout mix 0, dmic01_voice_mixin, dmic01_voice_mixin"
		"codec1_out_mixout mix 0, dmic23_voice_mixin, dmic23_voice_mixin"
		"codec1_out_mixout mix 0, codec0_in_mixin, codec0_in_mixin"
		"codec1_out_mixout mix 0, codec1_in_mixin, codec1_in_mixin"
		"codec1_out cpr 0, , codec1_out_mixout mix 0"
		"codec1_out, , codec1_out cpr 0"
		"codec0_out_mixout mix 0, media0_mixin, media0_mixin"
		"codec0_out_mixout mix 0, media1_mixin, media1_mixin"
		"codec0_out_mixout mix 0, media2_mixin, media2_mixin"
		"codec0_out_mixout mix 0, media3_mixin, media3_mixin"
		"codec0_out_mixout mix 0, speech_mixin, speech_mixin"
		"codec0_out_mixout mix 0, tone_mixin, tone_mixin"
		"codec0_out_mixout mix 0, dmic01_hifi_mixin, dmic01_hifi_mixin"
		"codec0_out_mixout mix 0, dmic23_hifi_mixin, dmic23_hifi_mixin"
		"codec0_out_mixout mix 0, dmic01_voice_mixin, dmic01_voice_mixin"
		"codec0_out_mixout mix 0, dmic23_voice_mixin, dmic23_voice_mixin"
		"codec0_out_mixout mix 0, codec0_in_mixin, codec0_in_mixin"
		"codec0_out_mixout mix 0, codec1_in_mixin, codec1_in_mixin"
		"codec0_out cpr 0, , codec0_out_mixout mix 0"
		"codec0_out, , codec0_out cpr 0"
		"iDisp_out_mixout mix 0, media0_mixin, media0_mixin"
		"iDisp_out_mixout mix 0, media1_mixin, media1_mixin"
		"iDisp_out_mixout mix 0, media2_mixin, media2_mixin"
		"iDisp_out_mixout mix 0, media3_mixin, media3_mixin"
		"iDisp_out_mixout mix 0, speech_mixin, speech_mixin"
		"iDisp_out_mixout mix 0, tone_mixin, tone_mixin"
		"iDisp_out_mixout mix 0, dmic01_hifi_mixin, dmic01_hifi_mixin"
		"iDisp_out_mixout mix 0, dmic23_hifi_mixin, dmic23_hifi_mixin"
		"iDisp_out_mixout mix 0, dmic01_voice_mixin, dmic01_voice_mixin"
		"iDisp_out_mixout mix 0, dmic23_voice_mixin, dmic23_voice_mixin"
		"iDisp_out_mixout mix 0, codec0_in_mixin, codec0_in_mixin"
		"iDisp_out_mixout mix 0, codec1_in_mixin, codec1_in_mixin"
		"iDisp_out cpr 0, , iDisp_out_mixout mix 0"
		"iDisp_out, , iDisp_out cpr 0"
		"System Capture, , media0_out cpr 0"
		"media0_out cpr 0, , media0_mixout mix 0"
		"media0_mixout mix 0, media0_mixin, media0_mixin"
		"media0_mixout mix 0, media1_mixin, media1_mixin"
		"media0_mixout mix 0, media2_mixin, media2_mixin"
		"media0_mixout mix 0, media3_mixin, media3_mixin"
		"media0_mixout mix 0, speech_mixin, speech_mixin"
		"media0_mixout mix 0, tone_mixin, tone_mixin"
		"media0_mixout mix 0, dmic01_hifi_mixin, dmic01_hifi_mixin"
		"media0_mixout mix 0, dmic23_hifi_mixin, dmic23_hifi_mixin"
		"media0_mixout mix 0, dmic01_voice_mixin, dmic01_voice_mixin"
		"media0_mixout mix 0, dmic23_voice_mixin, dmic23_voice_mixin"
		"media0_mixout mix 0, codec0_in_mixin, codec0_in_mixin"
		"media0_mixout mix 0, codec1_in_mixin, codec1_in_mixin"
		"Reference Capture, , media2_out cpr 0"
		"media2_out cpr 0, , media2_mixout mix 0"
		"media2_mixout mix 0, media0_mixin, media0_mixin"
		"media2_mixout mix 0, media1_mixin, media1_mixin"
		"media2_mixout mix 0, media2_mixin, media2_mixin"
		"media2_mixout mix 0, media3_mixin, media3_mixin"
		"media2_mixout mix 0, speech_mixin, speech_mixin"
		"media2_mixout mix 0, tone_mixin, tone_mixin"
		"media2_mixout mix 0, dmic01_hifi_mixin, dmic01_hifi_mixin"
		"media2_mixout mix 0, dmic23_hifi_mixin, dmic23_hifi_mixin"
		"media2_mixout mix 0, dmic01_voice_mixin, dmic01_voice_mixin"
		"media2_mixout mix 0, dmic23_voice_mixin, dmic23_voice_mixin"
		"media2_mixout mix 0, codec0_in_mixin, codec0_in_mixin"
		"media2_mixout mix 0, codec1_in_mixin, codec1_in_mixin"
		"codec0_in_mixin, , codec0_in cpr vmix 0"
		"codec0_in cpr vmix 0, , codec0_in"
		"codec1_in_mixin, , codec1_in cpr vmix 0"
		"codec1_in cpr vmix 0, , codec1_in"
		"dmic01_hifi_mixin, , dmic01_hifi cpr vmix 0"
		"dmic01_hifi cpr vmix 0, , dmic01_hifi"
		"dmic23_hifi_mixin, , dmic23_hifi cpr vmix 0"
		"dmic23_hifi cpr vmix 0, , dmic23_hifi"
	]
}

--3xoW37o/FfUZJwQG--

--5vjQsMS/9MbKYGLq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWADSxAAoJEHwUBw8lI4NHCtAP/0Py+byP+VfySvSpTubmmSiu
TtgcgXBdlkp4Pen7IP5rOSYrujYDwmoFjKhNfjeH7toMus5FToAUn9KkKer1RX4L
wCuJAADLAuchWGGcRgYLB1cEtO9jKhM0MFSMB2O4VnXflJlBP5UYy94od/YQ5h9i
HT1BnYfgcQ+9s3tJnMvcspKnEjx3fUg8O7IJdvl1loDcXk0vcvdNTg/Qc1M5szeZ
/FeNnFV4l5hIJBMoMVXf/+cgNDZqrTjom2CocZMEkrWNlD/TErL3sKAxikCXQP5p
6EclDMu/nVXyXTKI3nAR1En2LT3zvuhWN9yVG22z1m/pHVDcfaB/FcEbbI5Mm6zG
UzhX82zSsZh8S41zae8VNLjeaZBZIDCM5hzQAHbsPy75TAySxWS59UUnFfZIaajK
AQs+kR7uAe7wA/Gh7xLksLMfsc5eMXVRdbLKjEfHjBZ1UECHCA+278xnYWaPdCH1
zsN7zdwupNoUFAdbhb6mS6GX2w49u6aTWV7MQJpGNsldpBInc2TlrEjiBB1QjDAa
9BiT6vW7n+H9bIv1IlxdxL5wwlUysQPtJdjbE1y5QPpcBpbHPCHTucYO48SxpMVH
MIQotF7g69t7y+AMU9R1c0gLwG1hEGejJMFYStQpwQtfJqYZ12rGUA+TikvHBWed
lD5IfXEv3YLljuqjnFNY
=B7FM
-----END PGP SIGNATURE-----

--5vjQsMS/9MbKYGLq--

--===============8812306274806517835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8812306274806517835==--
