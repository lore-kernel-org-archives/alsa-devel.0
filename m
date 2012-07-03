From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 3/4] ASoC: SPEAr spdif_out: Add spdif
	out support
Date: Tue, 3 Jul 2012 20:09:56 +0100
Message-ID: <20120703190955.GD29030@opensource.wolfsonmicro.com>
References: <cover.1340862505.git.rajeev-dlh.kumar@st.com>
	<ef5b01e2bff6cb1e72db4e2d216d1a039a048e62.1340862505.git.rajeev-dlh.kumar@st.com>
	<20120628122727.GI28922@opensource.wolfsonmicro.com>
	<4FF12AE9.6000001@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3034902867628702615=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AB9161042FA
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2012 21:09:57 +0200 (CEST)
In-Reply-To: <4FF12AE9.6000001@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, Vipin KUMAR <vipin.kumar@st.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============3034902867628702615==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="exKAuxcSaZxx4B14"
Content-Disposition: inline


--exKAuxcSaZxx4B14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 02, 2012 at 10:30:25AM +0530, Rajeev kumar wrote:
> On 6/28/2012 5:57 PM, Mark Brown wrote:

> >>+int spdif_soc_dai_probe(struct snd_soc_dai *dai)
> >>>  +{
> >>>  +	struct snd_soc_card *card = dai->card;
> >>>  +	struct snd_soc_pcm_runtime *rtd = card->rtd;
> >>>  +	struct snd_soc_codec *codec = rtd->codec;
> >>>  +
> >>>  +	return snd_soc_add_codec_controls(codec, spdif_out_controls,
> >>>  +				ARRAY_SIZE(spdif_out_controls));

> >We should add a framework thing for this...

> I was going through the simaple-card.c file and I think that the
> above is possible if we have a pointer of "snd_kcontrol_new" in
> asoc_simple_card_info structure. In this case we can pass all the
> controls from board file (arch/arm/mach-*). Please share your
> opinion.

Why would we want to do that?  These controls are part of the CPU DAI,
the CPU DAI driver should add them.

--exKAuxcSaZxx4B14
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP80N8AAoJEBus8iNuMP3dfEsP/jdDcpqHcC0jw9bdHmBHx4F4
Upi/8yyUlX+nwHKWiNfJBEZsAoupfl5XIrDHk0synYPEP+KLRJHGxZurOnwApnJj
eEAtveqinVQfwBeZJg/s8kCQlWOtmXw5a7WxBhPCsAqqrlDtq281TwzqbhXaQTJB
lAp17a/EgXz0meig0VunjL+kk/ESykOgrGwr9RjmWovDmolXPi7w6tU5warY4xlQ
v2oe5prsfHi0J3K7kuIE9/HWlcu1/emKBujzuMV+rdHYofzlukQo35ZiFqLT7nVw
lmgRwqzIQY/fGamfw9k2uQ6rnj1sHnvGY/N6t9yMUdDDVByxst8UzJmfQIa0j4gu
lTMXhqZLHCGaPzuGjz0PfOqhtbye9UHkRE7l0RPA9WekB8rSbOqs86nPMMxtVvmg
rT/Jazb4B9dVUyrTa+M91PaPSWOmkUW7YjjU417ZP7gRpRqe8zMsdCzNhWZ3bWro
9gjNinosYI4ToCrGLbmiBPXFnNo5T6DJBgbhlTxr5NV8L7tScG0eKyFHjUJFDLz2
Na1Cnoxxn884IRr8DWF55Mvgrng0eppHDlkE04FIiWruJvsm/KP206w0XRHNGeUz
34qbWFXbhJ3kmFgKsY8AiNVMY9DNPLuHSvkist5IQqyJZi5khdAWK71Mgj5wKtHd
IRsY7gzDTOu1uKWgoCi7
=jEc6
-----END PGP SIGNATURE-----

--exKAuxcSaZxx4B14--

--===============3034902867628702615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3034902867628702615==--
