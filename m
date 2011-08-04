From: Keith Packard <keithp@keithp.com>
Subject: Re: [PATCH v3] pass ELD to HDMI/DP audio driver
Date: Thu, 04 Aug 2011 11:03:41 -0700
Message-ID: <yunsjph835u.fsf@aiko.keithp.com>
References: <yunk4atlwnr.fsf@aiko.keithp.com>
	<20110804094024.GB21137@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0194333418=="
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20110804094024.GB21137@localhost>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
	Zhenyu Z" <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>, Christopher White <c.white@pulseforce.com>, Jeremy Bush <contractfrombelow@gmail.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

--===============0194333418==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Aug 2011 17:40:24 +0800, Wu Fengguang <fengguang.wu@intel.com> wr=
ote:

> Right. I actually have this chunk. dmesg shows that in intel_hdmi_detect(=
),=20=20
> the drm_encoder object is there, however encoder->crtc is NULL at the
> time.

Correct. encoder->crtc is set only when the output is active.

> You may wonder why the mode parameter is needed in intel_write_eld().
> This is because the ELD field aud_synch_delay (ie. A/V sync delay) may
> have different values in progressive/interleaved display modes.

Ok, so you can't write ELD data until the display is active, which
happens at mode_set time.

Do you need to provide ELD when the display is inactive? Is this only to
enable audio output when the display is not on? In that case, we will
need to essentially turn enough of the output on to allow for audio
data, picking a mode which provide sufficient bandwidth.

> I tested Ivybridge yesterday and ironlake_write_eld seems to not work
> properly for Ivybridge. Need to double check its spec.

That's unfortunate...

=2D-=20
keith.packard@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFOOt79Qp8BWwlsTdMRAokiAJ9KvQJrenKXHYtGajmIvH25hWjK/gCgwhBU
lGVKeKScZrk80d8PDyM7G1Y=
=v2Iw
-----END PGP SIGNATURE-----
--=-=-=--

--===============0194333418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============0194333418==--
