From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch V7 02/10] ASoC: qcom: Document LPASS CPU bindings
Date: Sat, 7 Mar 2015 11:18:38 +0000
Message-ID: <20150307111838.GI28806@sirena.org.uk>
References: <1425428519-12224-1-git-send-email-kwestfie@codeaurora.org>
 <1425428519-12224-3-git-send-email-kwestfie@codeaurora.org>
 <7E5AFC65-1705-4BDC-B57F-0444E83A8987@codeaurora.org>
 <20150306015131.GA15850@kwestfie-linux.qualcomm.com>
 <D5A5C916-4D40-4C51-8307-9CA90FC68347@codeaurora.org>
 <20150306220342.GA25363@kwestfie-linux.qualcomm.com>
 <37AEDC0C-448D-4F3A-B87D-C37B9F2D8E1B@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HkMjoL2LAeBLhbFV"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <37AEDC0C-448D-4F3A-B87D-C37B9F2D8E1B@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>
Cc: Kenneth Westfield <kwestfie@codeaurora.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--HkMjoL2LAeBLhbFV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2015 at 04:06:48PM -0600, Kumar Gala wrote:

As previously and repeatedly requested please fix your mailer to word
wrap within paragraphs, not doing this makes your mails harder to read
and reply to.  I've reflowed your message for legibility.

> > The audio DSP is, in fact, contained within the audio subsystem.  The
> > representation of that relationship in the DT, I believe, would be a su=
bnode.
> > OTOH, if there is a strong sentiment towards using a phandle, that woul=
d be
> > fine with me.

> Just depends on how we communicate with the DSP.  If its mostly via
> MMIO access than a sub node makes sense.  If its via some other
> RPC/communication mechanism than possibly a phandle.  Trying to
> understand a bit more to than see what I=E2=80=99d recommend.

It should be a phandle, while these things are all part of the same
logical function in the CPU they're separate IPs and there may be many
DAIs.

--HkMjoL2LAeBLhbFV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+t6NAAoJECTWi3JdVIfQP8cH/1TSR9AtKzeR9iTdXDlf13aa
b2WIll9t73mx3P0InEhzBMM3ENA/juCxKKuE5I3yPHc+Ux46WsQlhd97+BOKDCzl
2paN2XiZoESfR/IhtBbu8MY6ydykbzEqi7SD+rO49FeB+eqtaYO2t7sDY79xh7Op
zrqBR7uWhMSRq/kcpQ74NQILicoRVRcWLIz42ZAspuGzO9KPjyDMoS7oJGArOBu0
ydeU83tpyenFPu4RRg3wmXWaJ+YCx39Pkm3ZaPu0v2mtcoi1avoFrXGfMe0IJb0j
7KE/oASWrJ4fA4IBtjrlBqb7PR63fVAnhmBhnt4INRoMQOXuU4GtO3cxLp8xwqg=
=LqNV
-----END PGP SIGNATURE-----

--HkMjoL2LAeBLhbFV--
