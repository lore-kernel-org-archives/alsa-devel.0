From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC and pulseaudio
Date: Tue, 15 Mar 2016 10:00:33 +0000
Message-ID: <20160315100033.GL2566@sirena.org.uk>
References: <CAL9uMOHRjcCJomr6zzR0ySh384AVj1FRvASZSp3KsPqfeS8Lzw@mail.gmail.com>
 <56C8AEFD.4060808@linux.intel.com> <1456225994.6424.35.camel@loki>
 <B51200AC81AB024499A3C2C9A1BB90A83D3AABF9@SHSMSX101.ccr.corp.intel.com>
 <1457943567.3888.18.camel@loki>
 <20160314160654.GA2566@sirena.org.uk>
 <1458021688.8522.16.camel@loki>
 <20160315084544.GF2566@sirena.org.uk>
 <s5hmvq0glxj.wl-tiwai@suse.de> <1458035331.8522.52.camel@loki>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0545286287=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <1458035331.8522.52.camel@loki>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Linux Upstreaming Team <linux@endlessm.com>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, "han.lu" <han.lu@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0545286287==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FnOKg9Ah4tDwTfQS"
Content-Disposition: inline


--FnOKg9Ah4tDwTfQS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 15, 2016 at 09:48:51AM +0000, Liam Girdwood wrote:
> On Tue, 2016-03-15 at 09:55 +0100, Takashi Iwai wrote:

> > > Shouldn't we use whatever we use to figure out which firmware to load
> > > rather than the firmware name?  Someone might do something like try to
> > > replace one firmware with another and get everything confused.

> This is not to load FW for our use case, the FW name is hard coded in

It's not for loading, it's because the firmware name we requested may
not be the firmware that actually got loaded.

> driver tables. We do have several FWs for the BYT driver that all have
> different capabilities. Userspace could set the correct config for each
> FW if it knew the FW that was being used.

Is the firmware configuration sufficiently reusable between boards or
could that just be figured out in userspace?

> > The short name is something between them.  The alsa-lib USB-audio
> > config file refers to the short name because the driver doesn't
> > provide a unique id for driver_name for various workarounds.  But it
> > should be considered as an exception.  Ideally, driver_name should be
> > unique enough for each different configuration.

> So IIUC this would mean ?

> 1) short name is optional, but could be board name.

I'd not make it optional, the long names tend to be on the verbose side
so applications do seem to use the short name for user rendering
purposes.

--FnOKg9Ah4tDwTfQS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW590/AAoJECTWi3JdVIfQqncH+wRvz7/miHCr/ofyL6NQGD4P
juMm8kcOM8tDzDsFkVL/9TAzf9NCNbyomLYSFcGgGHRjTwxuoNepZpV6H67DYvaL
oqM3ZSZcqMR+fp0jGCiAHnlaZMZxe2qVolWc4tDHuFfowKD7bz5wvc+NrHkVrq5s
6vKo/qllu7osmQAwx9loNFfqDmpWos0zENzKilHuvBbo2l4iQWZVLro5EreZI33y
3tk1RidCEIwBT1rYON/39YFpJB7TEzgZasJh38dUMAMrL4f3V1iXc0f/U5vRvSLJ
+XxgiMDWW2Z4xwyXhCzcQFxInnsGL6o4zaCPV2K5ZGJVwwK7QEUlscx662IaKs4=
=BHjv
-----END PGP SIGNATURE-----

--FnOKg9Ah4tDwTfQS--

--===============0545286287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vcHVs
c2VhdWRpby1kaXNjdXNzCg==

--===============0545286287==--
