From: Keith Packard <keithp@keithp.com>
Subject: Re: [PATCH v3] pass ELD to HDMI/DP audio driver
Date: Wed, 03 Aug 2011 19:48:08 -0700
Message-ID: <yunk4atlwnr.fsf@aiko.keithp.com>
References: <20110729130759.37aca083@jbarnes-desktop>
	<20110801135140.GA24205@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1952056230=="
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20110801135140.GA24205@localhost>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Wu Fengguang <fengguang.wu@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
	Zhenyu Z" <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>, Christopher White <c.white@pulseforce.com>, Jeremy Bush <contractfrombelow@gmail.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

--===============1952056230==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Aug 2011 21:51:40 +0800, Wu Fengguang <fengguang.wu@intel.com> wr=
ote:

> 1) intel_write_eld() is not called at all
>    It seems we need to call intel_write_eld() in other places besides
>    inside ->mode_set(). Is ->detect() the right place to do so? In
>    other words, are there established connector<=3D>encoder mapping
>    that can be queried inside intel_hdmi_detect()/intel_dp_detect()?

The connector has a link to the encoder (struct intel_connector contains a
pointer to a struct intel_encoder).

> 2) intel_dp_detect() is called even though it's an HDMI monitor
>    connected to an HDMI jack.. It may be a bug specific to the
>    hardware I'm testing (attached its full dmesg).

We run all of the hotplug functions when any connector change is
detected; easier than trying to track what happened from the bits
visible from the interrupt.

I note that this patch does not include the necessary hooks for
Ivybridge; we'll need that included (and tested) for this to be
considered for kernel 3.1. I'd be surprised if it couldn't use
ironlake_write_eld just fine, so it should just be a matter of setting
the write_eld field and testing it on actual hardware.

=2D-=20
keith.packard@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iD8DBQFOOghoQp8BWwlsTdMRAu45AJ4go6QL9WlE3btYhL4MKCTxDVBWnACggVfj
sFrMChzVwgWx3ATyyaGmvvs=
=qwDk
-----END PGP SIGNATURE-----
--=-=-=--

--===============1952056230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============1952056230==--
