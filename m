From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/6] ASoC: rt5645: fix wrong mask for
	button report
Date: Fri, 1 May 2015 17:34:42 +0100
Message-ID: <20150501163442.GD22845@sirena.org.uk>
References: <1430389127-24609-1-git-send-email-bardliao@realtek.com>
 <1430389127-24609-5-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4754983032792077457=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 86AD82605F5
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 18:34:47 +0200 (CEST)
In-Reply-To: <1430389127-24609-5-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4754983032792077457==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ePb1vBESXVFrMIkZ"
Content-Disposition: inline


--ePb1vBESXVFrMIkZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 30, 2015 at 06:18:46PM +0800, Bard Liao wrote:
> rt5645->btn_jack is for jack button report. So the mask should be
> SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2 | SND_JACK_BTN_3.

It doesn't matter in this case but generally bug fixes should go at the
start of the series, that way they don't end up depending on other
things and it's easier to apply them and get them sent to stable if
needed.

--ePb1vBESXVFrMIkZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQ6shAAoJECTWi3JdVIfQNRkH/06qD//aaomhqvAYy3y+MsVB
MBsoQ9QAxP9CZrfUnblZN3nNxnL8A5frZOTiF+TdK6BdLgdA/iwu3yQzfh2G3lC/
i94ILVa1wGrGTFj8ModA1vD6BKbaRc0GvHGnPTcduBClqEzW/xym61q/Tw+obSMg
yOluZkIb1r9TjJnz6Ys0B2F9d78COJGNkP0NCLCUaof1YF1GBC14NoizL4A6LZ37
binasFxEeyPte8TSEH/XC362p3ZgKp2lHMNjUZxekteAqDmCiIngGhj9PB8Xo+00
ImoD/yqIKB5NDvl0lomMc/om29523zR/dmpjgzp+aoUKQ0I5uTzoy1jPOx70rY4=
=9I9e
-----END PGP SIGNATURE-----

--ePb1vBESXVFrMIkZ--

--===============4754983032792077457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4754983032792077457==--
