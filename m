From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5670 CODEC driver
Date: Mon, 30 Jun 2014 10:56:25 +0100
Message-ID: <20140630095625.GU23300@sirena.org.uk>
References: <1402028138-27444-1-git-send-email-bardliao@realtek.com>
 <20140627153143.GP23300@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D75C87D9@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4886018653159560559=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EDCD82608E8
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 11:56:53 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D75C87D9@RTITMBSV03.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4886018653159560559==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dzQpwWBOJ0CmsuPs"
Content-Disposition: inline


--dzQpwWBOJ0CmsuPs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 30, 2014 at 05:38:59AM +0000, Bard Liao wrote:

> > > +static int check_dac_monor_asrc_source(struct snd_soc_dapm_widget
> > *source,
> > > +			 struct snd_soc_dapm_widget *sink) {
> > > +	struct snd_soc_codec *codec = source->codec;
> > > +
> > > +	return is_using_asrc(codec, RT5670_ASRC_2, 4); }

> > I have to say I'm not convinced all these wrapper functions are really
> > adding much - just making is_using_asrc() take a widget and passing the
> > arguments directly seems as simple.

> Do you mean use is_using_asrc() as the checking function for all of those
> widgets, and use different arguments for different widgets?

Yes, it seems like that's all the functions do which isn't adding much.

--dzQpwWBOJ0CmsuPs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTsTRGAAoJELSic+t+oim9p6EP+gKNNFLUA2T+nt/zRw+QHWZ5
0CGP8sUUkIOIrpBd1chfhEVwNrWJ9e/zA+qTigRXPaVaXvP+Dd92zIrn85wYnWWI
muQNpvqcYCWD9L+xOg4EMA8qn4pfV5VQAwYpW9XmSbwC3YTDaMEme6q/FvkfIXXq
lATAtkH+V7aoGbEYTwC4yNwzNKhf6E3OJrsq/RBfvKmjWUd/HGNOnHVKA1FWve0l
Czrfk24rTLAvCfXrNB44xclfuYgT44zNbhPInUWgj1bRDvPSFd8f/sEQdxFFWK9k
GPg75Ft14M8uXH7CWhaYODnjXu9HMZNF8Ys1DAIrI72lL8YKToBUPDxwSWRqPRMl
y6MJUKls9oNIaZtaLix4GO+o/JJibbI6Vln5lD9bczwMEoyscC66E7oTrd6rJcBg
aCnkQeDiNNvA3l7FDtJsuGWsKb6453t7KLnCLTYA57tb1u7jLVa39DJPbz5GDdhG
giLj3LafXy9+/JSP+0PHX6AbzT1azWYoghYP/+OpgkmZAjMz3VN4wc5g4po7/yC9
Orn4CgaO/GSe4BOGWz8pXlOZToBgku+a79gBW45IvmtoAsQwrTvTMtciFbGtWfw3
pbxOSgNdqRI3IKMTiH7KSBF8khKtruBQU8ybaId5VCy9s14J4EwEMn00ATVYO3UB
8a8/imwKcHhG968vjvmd
=Pfav
-----END PGP SIGNATURE-----

--dzQpwWBOJ0CmsuPs--

--===============4886018653159560559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4886018653159560559==--
