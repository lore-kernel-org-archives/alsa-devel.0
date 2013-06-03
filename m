From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: check suspend state in
 dapm_dai_check_power()
Date: Mon, 3 Jun 2013 20:46:28 +0100
Message-ID: <20130603194628.GV31367@sirena.org.uk>
References: <1370281000-1120-1-git-send-email-swarren@wwwdotorg.org>
 <20130603185120.GS31367@sirena.org.uk>
 <51ACEB94.9020205@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0625451573558236797=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id AD1FB264FE3
 for <alsa-devel@alsa-project.org>; Mon,  3 Jun 2013 21:46:31 +0200 (CEST)
In-Reply-To: <51ACEB94.9020205@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org


--===============0625451573558236797==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tuFXEhzhBeitrIAu"
Content-Disposition: inline


--tuFXEhzhBeitrIAu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2013 at 09:16:36PM +0200, Lars-Peter Clausen wrote:

> I think it is just an oversight that this is not working properly right now.
> In snd_soc_suspend() where we also stop the DMA streams etc the DAI link
> widgets are put into suspend, by calling snd_soc_dapm_stream_event(...,
> SND_SOC_DAPM_STREAM_SUSPEND). But dapm_dai_check_power() doesn't consider
> this and hence stays active and also keeps the whole DAPM context (this is
> not CODEC specific) active.

It's clearly an oversight but I don't think this is a joined up fix for
it.

--tuFXEhzhBeitrIAu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRrPKQAAoJELSic+t+oim9KggP/it6HwtJ2l9pxtd/LHbVaPQu
z7jLvz58wD0xdT+HIY1AZtPS4HX/VupsZepeLdALbGpiX4MzavSFPZfKwsQIDQUP
RwaQRKzzkY7u4CntW7FNlJRMWJNY6Jw3DPFSqF5x2+ZsAFV2gIcTR77womfKk/c5
PkKPT0l1SvW4FboJTU4DsqVEzD3otVcZU4cPF0VwNIKsA9IpbYc9BqBA/g+NhRfH
TrIc5hW87aUtYc3sqktScTBbsxnrQmid9Hnuog8AseT8/EXogetOjJ77pt0HOsbq
aC5b6CIp1vud+BDDf59g04tcda0u7GTVzRkbLF10xbZ3D95I0yZRr1m6mw22Q+28
KfXXzDoBc436AV59eZ6wy5cfqSZvJ7oc7ksk2RLpSy8YY0PpFhpNe6ai1hr/lUpN
IYULLflUwz6Hk0HPABCwq7cuB/8VLkV5sYRYDhjwAwkmJdiaXHZP8pfR6DWtcB7m
n5uREzScHdPvC2GRWMUWhj4VYa7yKMrG9ELwKO/+8D7lq02FxTxoibx+8TkYj4Mo
13BoH7LMKlcDFGngbUsD36uQ2euAOxOhKTHAwD4AIiy7VNgrsJ1yfHLxO04CR38a
K79RNBkb/04gbWdO8tS+3abCnVazVqBFZcwyhZu6c2zClqyfIx/XPQvaNztabxjp
XZxuuVkdnKYZO/lmBKIW
=E7lU
-----END PGP SIGNATURE-----

--tuFXEhzhBeitrIAu--

--===============0625451573558236797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0625451573558236797==--
