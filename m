From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel]  ASoC and pulseaudio
Date: Wed, 16 Mar 2016 15:09:49 +0000
Message-ID: <20160316150949.GX2566@sirena.org.uk>
References: <B51200AC81AB024499A3C2C9A1BB90A83D3AABF9@SHSMSX101.ccr.corp.intel.com>
 <1457943567.3888.18.camel@loki>
 <20160314160654.GA2566@sirena.org.uk>
 <1458021688.8522.16.camel@loki>
 <20160315084544.GF2566@sirena.org.uk>
 <s5hmvq0glxj.wl-tiwai@suse.de> <1458035331.8522.52.camel@loki>
 <s5h8u1kgj3c.wl-tiwai@suse.de> <1458039506.8522.70.camel@loki>
 <20160316145704.GU13211@localhost>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1160301939=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <20160316145704.GU13211@localhost>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: Vinod Koul <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, Takashi Iwai <tiwai@suse.de>, "han.lu" <han.lu@linux.intel.com>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org


--===============1160301939==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UEYxRAcbr7cS1UOX"
Content-Disposition: inline


--UEYxRAcbr7cS1UOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 16, 2016 at 08:27:04PM +0530, Vinod Koul wrote:

> So I don't think FW name would help, if required we should add dev_info
> to print the firmware which is getting loaded.

We can't really be relying on userspace trawling through the logs -
quite apart from anything else the message might be long gone by the
time the relevant program gets started.

Might be an idea to record it in sysfs somewhere?

--UEYxRAcbr7cS1UOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW6Xc8AAoJECTWi3JdVIfQ3EYH/0tKRamq7AmyBRf1MpaTV7n9
0E90Ne/59Hrl6hcKnib+BENFjDX3KzLdbi/pyqIbCfN54NyZFNjNnfatbr7inwaI
mb3jnpkE5gMW3RdkcRsMCSsZCZdIZrep5WHJaJCy0A/GRFL6OLqQ+mgL2VDubeI5
C3EB0CWG1ArWNAnsWbk3dPggRPurAMJtF7Wr12Wh94q44ap9C9HUj+sYLmjBVv5b
wV3EPfFLLvVfVaUDax69E+RflkddKfdbTRd8jbHcRRbJCWGQn+ZosOGuueLiG8Dq
gTa5iDGwGiqfpAqi3BmS+gZhcOhhfdKcuOTb1LgiY+gislAYQXIxrpormFByf8s=
=YMf/
-----END PGP SIGNATURE-----

--UEYxRAcbr7cS1UOX--

--===============1160301939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vcHVs
c2VhdWRpby1kaXNjdXNzCg==

--===============1160301939==--
