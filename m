From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 09/10] ASoC: topology: Change stream
 formats to bitwise flag
Date: Fri, 14 Aug 2015 21:34:28 +0100
Message-ID: <20150814203428.GR10748@sirena.org.uk>
References: <cover.1439217448.git.mengdong.lin@intel.com>
 <b9a7ab97e4b4f96cced9faa2e2bce2b533d25a10.1439217448.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2738970378088398193=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F9202664F4
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:12:13 +0200 (CEST)
In-Reply-To: <b9a7ab97e4b4f96cced9faa2e2bce2b533d25a10.1439217448.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2738970378088398193==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rwwPlZPbpBX9O0Yk"
Content-Disposition: inline


--rwwPlZPbpBX9O0Yk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 10, 2015 at 10:48:37PM +0800, mengdong.lin@intel.com wrote:

>  struct snd_soc_tplg_stream_caps {
>  	__le32 size;		/* in bytes of this structure */
>  	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
> -	__le64 formats[SND_SOC_TPLG_MAX_FORMATS];	/* supported formats SNDRV_PCM_FMTBIT_* */
> +	__le64 formats;	/* supported formats SNDRV_PCM_FORMAT_* */

Argh, this is *another* ABI change which you've buried in the middle of
a series you're sending right at the end of the release cycle (this was
sent after -rc6, we may not even get a -rc7...).  Given how close we are
to the release and the invasiveness of the changes in this series it's
very lucky I even saw it before release, I'm reading this on my flight
to Plumbers which means my bandwidth next week will be limited.

This should have at the very least been sent at the start of the series,
and really should have been sent separately.  It is also worrying that
there is nothing in the subject or changelog talking about the fact that
this is an ABI change or explaining why it is required.  The changelog
was simply a statement of the content of the diff, not a rationale:

| The toplogy user space tool will generate this bitwise flag by using
| SNDRV_PCM_FORMAT_* exposed by asound.h, and the topology core will copy
| this flag when generating DAI streams.

Once the release goes out this sort of incompatible change will be
unacceptable.  Given the number of changes that are going into the ABI
(we also had some others went in last week) I'm now giving some serious
thought to the idea that we should ask Linus to revert the topology code
for v4.2 and waiting for v4.3 so we've got more chance to make sure the
ABI is one we actually want to stick with.  Liam, Takashi I don't know
what you think?

--rwwPlZPbpBX9O0Yk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzlDTAAoJECTWi3JdVIfQoIQH/1I/Qqqz6vZWYZyOP07SLedW
J2pp9hpYjeyTQFJNUzFTckRIgIENXAmPBFGLTBUW28seewS7t1djzDqze8l4P+tB
E7uZo6wRNSh2r+adPV5ucJpTo4roVE/74G8uNwhA8mi07j5VG9idVDsFw9lT0V0a
4XM18Vmgyo5hKtCrfW+PYj+xBT+SZZpmgxK3OFLu+Ej8dAl8yeN482PTtyxE/ZYB
MSblTnqMlVh3Bi0/OtnhNLk/53xPBZtYWya79u5B8Qu+DnxoSsqODiFL+bHLJRn7
+GZFw/mWozBLuoALzTLMSBCQewhOyeGGJCwj/H44nI350fKhYD9mcYdVVB33P1I=
=OTwA
-----END PGP SIGNATURE-----

--rwwPlZPbpBX9O0Yk--

--===============2738970378088398193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2738970378088398193==--
