From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/13] ASoC: Move IO functions to soc-io.c
Date: Wed, 19 Mar 2014 11:10:57 +0000
Message-ID: <20140319111057.GA11706@sirena.org.uk>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <1395129736-11938-5-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9132944296903304579=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 07ABE265043
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 12:11:18 +0100 (CET)
In-Reply-To: <1395129736-11938-5-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============9132944296903304579==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FgNmq+ZeolcS4uuG"
Content-Disposition: inline


--FgNmq+ZeolcS4uuG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2014 at 09:02:07AM +0100, Lars-Peter Clausen wrote:
> soc-core.c is getting quite crowded. Move all IO related functions that are
> still in soc-core.c to soc-io.c

No, we're trying to make soc-io smaller!  Besides, if this stuff is
getting cleaned up then:

> -unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg)
> -{
> -	unsigned int ret;
> -
> -	ret = codec->read(codec, reg);
> -	dev_dbg(codec->dev, "read %x => %x\n", reg, ret);
> -	trace_snd_soc_reg_read(codec, reg, ret);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(snd_soc_read);

...making small things like this static inlines in a header is probably a
better move (we can probably drop the trace - I don't think anything in
active development doesn't use regmap and it's a carrot to push people).

--FgNmq+ZeolcS4uuG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKXs+AAoJELSic+t+oim9bskP/25OwvjjoL/QcyRPPfuvyEMU
VHp5BsliJmUcydnmpP9WUMgLUWI+F06zuYMuBpZGqDpFMgA9tc+HrXszSJ58ACRy
9yH1cT1+C9JgFf1IRV0Fq8f5XfKQpoZQ85gdOQdLx5sb0izERwPNhYu5cU+Ie9yo
MsfcWY8/ZPcpGhlHL+20RK2Bjvhf2yqheKP4Rf5Y8TwzNYI/qYt0AbAyWUZvpI3L
4jFkE7fnt5SqZUOl5r500JLyJYUvfFk+3HrNNMvLnyNlqf5IclmwaCQY0e9fmopp
6qQ4Hk3jtKuFG/QvItQeCi8V1G/s5ZtcYPaiKiNIBIWXcHddWE2hvaYozw6F3UHd
vLkKcenTLVXwxVveC/yugQGHmz6UFhPYZke1JxdASsw7IN5TXgDzTSDNWvlZYZpE
RBuEw7uJTt890iMGLbZajlNJxeuNUPJ6+bvLEd1T8P2fcQbrVJqUDD3LzM77V4K/
1LDwBB6+10lUEUMpO/OZsCxFcwBUMXpN0/OpFpHlV8ibtokYL55ayNU/ytbzgmBm
AKRNYyZItvfStcrPO1Mn2L809/u+23snhzT7KuUL9vucKarBR+4PgiUDlDSzu/bZ
wXms01buCYWo7Uxi0fOIkPpOCtNVv/TMtsHpGwYEu48osfL3X4wwmnpRhiKOcqgp
aCCZ/kNz+CDSDrdvIu5b
=zv22
-----END PGP SIGNATURE-----

--FgNmq+ZeolcS4uuG--

--===============9132944296903304579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9132944296903304579==--
