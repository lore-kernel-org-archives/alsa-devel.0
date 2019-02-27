From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] ASoC: simple-card: add support for bclk_ratio
Date: Wed, 27 Feb 2019 18:36:22 +0000
Message-ID: <20190227183622.GA11065@sirena.org.uk>
References: <20190225164218.19439-1-TheSven73@gmail.com>
 <877ednbdnz.wl-kuninori.morimoto.gx@renesas.com>
 <20190226091104.xr27vsiayiq3dl2n@shell.armlinux.org.uk>
 <CAGngYiXrGNvwobKy+u8QWWsDowhTE8E7OSpVOOL1Yu9PvH-Z9w@mail.gmail.com>
 <20190226154519.e2wbvbkjynkaob4c@shell.armlinux.org.uk>
 <CAGngYiXSNbQbcY1tbnYURWTCu7rJk=L1H+So7kanJmpxkV5bEQ@mail.gmail.com>
 <20190226170349.h4iqeegl7my6qzpt@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0322166856=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190226170349.h4iqeegl7my6qzpt@shell.armlinux.org.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, David Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Jaroslav Kysela <perex@perex.cz>, Peter Ujfalusi <peter.ujfalusi@ti.com>, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org


--===============0322166856==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 26, 2019 at 05:03:49PM +0000, Russell King - ARM Linux admin wrote:
> On Tue, Feb 26, 2019 at 11:31:15AM -0500, Sven Van Asbroeck wrote:

> > There is talk in the manual about "network mode", which could work by changing
> > the LRCLK only at the first slot - thereby allowing clients to receive all
> > slots just by counting, as long as they know the slot size?

> > LRCLK   _____/-----------------\_____/---------
> > DATA    SLOT1|SLOT2|SLOT3|SLOT4|SLOT1

> From what I gather, these are described using SND_SOC_DAIFMT_DSP_A
> and SND_SOC_DAIFMT_DSP_B dai formats, and the parameters are

Roughly, yes - the DSP formats are formats which only care about one
edge of the LRCLK, the difference being if the first data bit is the
same clock cycle as the transition or the next clock cycle.

> controlled not through snd_soc_dai_set_bclk_ratio() but via
> snd_soc_dai_set_tdm_slot().

> So, IMHO, the TDM formats should be disregarded from consideration
> here.  Mark, ack?

I'd expect set_bclk_ratio() to cover all formats - usually the hardware
either has zero flexibility when it comes to the LRCLK format or isn't
super bothered, this stuff is mainly used to adapt the more flexible
hardware to the less flexible hardware.

TDM is definitely something that only really makes sense with DSP
formats though, I2S TDM is just weird.

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx22KQACgkQJNaLcl1U
h9C67wf+LI5e7n5wfQSOgAf3bSfp4s+9ChGv6IwimLmTBnUCC0TCk+hOo28e/zbT
HD+pYCDjsSHaY0peq/927Xj5ErHLHZLVS1rGIh1SJk5V+2UKMn1lJ4MDLobhm0/U
W+hvnMOnimLlGodvQtF7asE01AooE3GMLTQfdkwnX5y7M/c3whQ+KrLrLUCb/LyA
slGgHscLSaK1I6443dYOhsBn8hkjkoBYtP9AGNQOC0aqkC1i8A+quDPM+ss/q0no
C4686zVU0zanD6Kev1p0T5fsIjqlTZyz5qnVLF4CcPnWFjcJJO+zTBkDveq85pLp
1ng04RT4v4fwaHqUL69WdL3l7OqttQ==
=twmV
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--

--===============0322166856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0322166856==--
