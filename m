From: Keith Packard <keithp@keithp.com>
Subject: Re: [PATCH v3] pass ELD to HDMI/DP audio driver
Date: Sat, 06 Aug 2011 13:02:02 -0700
Message-ID: <yun8vr61f7p.fsf@aiko.keithp.com>
References: <yunk4atlwnr.fsf@aiko.keithp.com>
	<20110804094024.GB21137@localhost>
	<yunsjph835u.fsf@aiko.keithp.com> <20110805124958.GA9531@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2146517067=="
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20110805124958.GA9531@localhost>
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

--===============2146517067==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Transfer-Encoding: quoted-printable


> Good questions!  In general the audio functionalities should not
> depend on the display activeness. There are even audio-only HDMI
> devices. So I'll need to make intel_write_eld() work even without
> information about the current display mode.

Yeah, we'll need to figure out what the ELD should look like with no
display active. I think you've got the whole link available, so there
shouldn't be any restrictions on formats.

> That would be a good feature. For one thing, I find it annoying that
> the music playback fades out when the screen goes to power saving
> mode..

I'm not sure we can make it completely seamless without keeping most of
the pipe active (which will consume some power). Probably we'll just
leave the clock alone while the display is DPMS'd, but if we actually
need the resources for another display, I'm afraid there may be some
noise on the HDMI audio link. Will need experimentation to figure out
how to make this work as nicely as possible.

I was just reading through the reference manual and found that there is
a mode that leaves the HDMI running without requiring a pipe or plane,
just the FDI PLL. So, audio without display seems pretty simple now;
just a matter of a bit of API negotiation between the audio and video
drivers.

=2D-=20
keith.packard@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFOPZ27Qp8BWwlsTdMRAlhOAJ4rIzqeSk/gqAA1ExuKN/u9trt4PwCfat5S
N1zMTgES3fP2nndbbqoF+MQ=
=2YiS
-----END PGP SIGNATURE-----
--=-=-=--

--===============2146517067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============2146517067==--
