From: Mark Brown <broonie@kernel.org>
Subject: Re: Create a general function for codec jack detection
Date: Wed, 5 Apr 2017 18:29:14 +0100
Message-ID: <20170405172914.nnlda2qch46xvfnt@sirena.org.uk>
References: <ABFD875FF5FB574BA706497D987D48D701C3ED04@RTITEXTEMP.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5002720439035008146=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 28A80266943
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 19:29:26 +0200 (CEST)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D701C3ED04@RTITEXTEMP.realtek.com.tw>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "xiaoxiang@pinecone.net" <xiaoxiang@pinecone.net>, "zhongan@pinecone.net" <zhongan@pinecone.net>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5002720439035008146==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="getscdv4mheqsiz3"
Content-Disposition: inline


--getscdv4mheqsiz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 14, 2017 at 05:54:35AM +0000, Bard Liao wrote:

> Below is what I am thinking the patch will look like.

It's better to just write the patch for something like this and present
it as such rather than ask to send the patch - it makes things a lot
easier to handle.

> +int snd_soc_codec_set_jack(struct snd_soc_codec *codec,
> +                          struct snd_soc_jack *jack);

We have enough things that have no meaningful configuration to make this
useful I think so OK.

--getscdv4mheqsiz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljlKWoACgkQJNaLcl1U
h9D5Uwf/eSoGD0Lw7kMPOdqueO3e3wc2mCGTgk61mhe8DwDXNVnJIe2akUjapz8e
bJs9yHGS8ANTR8XdLXqhgo5eoys1Zm6VGCQ4CDEL+zreK/57dNb55LEbf5GKQ+lR
yeLmvLwZlxnf+G/FFDOgGKok1pN+1Hs2CvIjS3z6T/lwrUJlT+DDJ49AAXW1kVdw
PN3pGNd0ruuaInzwR+cdKl1ktvci72pdZ6K/bu6VwRALal2EMlvIhHDRCV6yFW4z
f4kUFNF9ACJe3DQvGTPOT4Ci8ISBgEK3F1Vi2JRQozA27DVmuDPydtkgGcIQNUTw
7d6iYvlKrwVXxDBMZCGLqHYMq2rSkg==
=nnG0
-----END PGP SIGNATURE-----

--getscdv4mheqsiz3--

--===============5002720439035008146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5002720439035008146==--
