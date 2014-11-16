From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Fix kerneldoc errors
Date: Sun, 16 Nov 2014 14:46:35 +0000
Message-ID: <20141116144635.GO3815@sirena.org.uk>
References: <1415652427-827-1-git-send-email-tiwai@suse.de>
 <20141114125704.GA3815@sirena.org.uk>
 <20141114172924.GJ3815@sirena.org.uk>
 <s5hbno7o7wo.wl-tiwai@suse.de>
 <20141116110647.GN3815@sirena.org.uk>
 <s5hy4rbmjm6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0544393316925682022=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 260BF2606E0
 for <alsa-devel@alsa-project.org>; Sun, 16 Nov 2014 15:48:08 +0100 (CET)
In-Reply-To: <s5hy4rbmjm6.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0544393316925682022==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1bAr2geOuLSduR5p"
Content-Disposition: inline


--1bAr2geOuLSduR5p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 16, 2014 at 01:10:25PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > One of the reasons I don't do that is that you don't have a branch which
> > tracks Linus' tree merged into your own while I do track Linus' tree so
> > once I've sent a pull request to you and another -rc has come out git
> > has trouble constructing a sensible pull request, either the diffstat is
> > bogus or the changelog is and I use both when reviewing what I'm
> > sending.

> Hm, but this does happen even if you send once, doesn't it?

No, I just send my pull request against Linus' tree.  That just shows my
changes which is fine.  Then if I want to send a further request I
either use his tree again and get all the previous changes included in
the request or I use your tree and get everything in Linus' tree since
-rc1.  Either way it's hard to keep track.

> If you need the merge of Linus tree beforehand, just let me know.
> I must review what I'm pulling, of course, so your demand is my
> demand, too.

It would help a lot to get a branch that's merged with the -rcs.  I base
all my merges off Linus' latest release since there's no sense testing
without the latest bug fixes and this helps track what fixes still need
to go.

--1bAr2geOuLSduR5p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUaLjKAAoJECTWi3JdVIfQ6DwH/3J9fAQ8s+bSVlaIGsPZD0gj
Nnh+2h8y3g9gn4LtKE/1WDg7EsMJp6hT8TbpXYRDt62hGIY6yjXOkWBljkFSLGn4
Dmtc38l93sjRSKzAS1dvrEjceW0OvNv9dGk2e9pH0P2f7HVqzcS/kCr5nlHKnxWn
zLloROJkOJ772hWqhR8OCteCaW0ynra2JbpTnUGCw77lXXbFrKgF1ISVH3eVKqYE
oHWxO2Xnya1Uw+7zG0pKQlOcetKPYFln/DYRe5PSwzVP2MjC/c8OvbV949lcprNm
9+H1K2uFxpcs4glaxC+CkxiG1M53Uxu4yL/FM7mTDT+GxBvoDaK49DmOh3EbMVA=
=SOzX
-----END PGP SIGNATURE-----

--1bAr2geOuLSduR5p--

--===============0544393316925682022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0544393316925682022==--
