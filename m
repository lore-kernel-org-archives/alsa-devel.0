From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: add RT286 CODEC driver
Date: Thu, 13 Mar 2014 20:43:23 +0000
Message-ID: <20140313204323.GM366@sirena.org.uk>
References: <1394521896-27721-1-git-send-email-bardliao@realtek.com>
 <5320CE8C.8090608@metafoo.de>
 <ABFD875FF5FB574BA706497D987D48D7398652@RTITMBSV03.realtek.com.tw>
 <53216DDC.9090502@metafoo.de> <s5h61nizdj5.wl%tiwai@suse.de>
 <20140313192902.GL366@sirena.org.uk> <s5hzjkteufy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2149227878079844805=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 839D826547E
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 21:43:37 +0100 (CET)
In-Reply-To: <s5hzjkteufy.wl%tiwai@suse.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============2149227878079844805==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JjpRhe3EFs1LrwYV"
Content-Disposition: inline


--JjpRhe3EFs1LrwYV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 13, 2014 at 09:04:49PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > We don't really *need* the cache, it just makes it easier to do resume
> > and gives a bit of a performance boost.

> Well, the caching isn't just a bit.  Without caching, you'd have to
> whip the sound hardware powered up/down at each time querying the
> current mixer value.

Realistically most hardware can't actually do that - there's a couple of
the idle_bias_off devices that have built in LDOs which can but it's
relatively unusual to be able to remove enough power to loose register
I/O (and in any case you wind up needing to cache the values per control
or something in order to do system suspend).

--JjpRhe3EFs1LrwYV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIhhoAAoJELSic+t+oim9DhEP/2wrfSviMG4kWfvUaT+fWaCX
Q3C5WjKZuJpHX/AGWtHxQhHazD3zxYTy6Mt7w0AH0iwMJyzaNNnZrPRYd6pSOO0a
gjBh0d0BfTrDokIYZhD4OcBU7l+jFmqbdOIoBxSVpZIa+dyFE1sfLRIuC+dcJ3aF
u/uHqBr5Awa7WeB0MV5mR73vYtJLdiP9lAqd2Ji1JVYJobTQyCsQ+YGIFQwrwfP6
8JxgINzQg/TPtpFtJ0w0JQNaEtIUayiGG7HLjUMfSJr8sWyedgegO6YRXSQo+hqz
XHnejE62/C7jnlhtwrymyp7M6z5aaLj8oYzHZSHU/Todz1BKJ1nGoSPUqEbhrzfH
yifq87q9HS3UwgC+V+IABEPvKMabx4wQJc6UN6btn4ShBYdsbJ+jh3CO0nTQfIHM
GXxVSlI3okOtyZcYvXVBk7hC/DMOSCY4ub5mKyon42/t9pT0rShLCnUzDRczyC21
n9peS1vuHmk/TibGT63/HkS7E8F44O58B4Hc70Y3Tb3HUNV4vMxtme1pOt1LFMrD
CQi9e6mQwcyzAXmcLY4vmmDDLV7UnqYOcvbmqktRyAUuhEzUzu/si7MoErn+tBm2
A5PcVfeb8RW6LXyciec8vV9EbX/2uH+eReAI5Yy/H775q6c5yuou61Lc4H5wNI9w
Z/kC7pt8bEMwHp/Y6LxV
=w2Zv
-----END PGP SIGNATURE-----

--JjpRhe3EFs1LrwYV--

--===============2149227878079844805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2149227878079844805==--
