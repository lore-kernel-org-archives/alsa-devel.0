From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [RFC PATCH v2] ASoC: dpcm: prevent snd_soc_dpcm use
 after free
Date: Wed, 6 Mar 2019 17:09:44 +0000
Message-ID: <20190306170944.GD21220@sirena.org.uk>
References: <1551861979-26601-1-git-send-email-kaichieh.chuang@mediatek.com>
 <0c9de818-80b4-d172-422d-a96b47aa7f1e@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8622034053737852568=="
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <0c9de818-80b4-d172-422d-a96b47aa7f1e-/Fr2/VpizcU@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, hochi.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, michael.hsiao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--===============8622034053737852568==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline


--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 06, 2019 at 10:19:38AM +0100, Jaroslav Kysela wrote:
> Dne 06. 03. 19 v 9:46 KaiChieh Chuang napsal(a):

> > +		spin_lock(&fe->card->dpcm_lock);
> >  		list_del(&dpcm->list_be);
> >  		list_del(&dpcm->list_fe);
> >  		kfree(dpcm);
> > +		spin_unlock(&fe->card->dpcm_lock);

> The unlock might be moved before kfree(). Also, I don't see the
> list_add() spin lock protection in your patch.

Yes, the free *needs* to be outside of the spinlocked section - we
shouldn't do dynamic memory operations in atomics context.

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlx//tcACgkQJNaLcl1U
h9A6Jwf/dQE6mXos5FyIrGxUTSQR0WbBN2xq2Xv8Y7LNrWFUgyzDawwuivTd5BFw
ugcht2XsxkMAKi51AK+ASKk7DqaS+a0tzb5HmUfKbFyoN1k/arFlholP3dUwQPGb
cVgttlp3TB9HuN+uac3DTKD1MrDgVPDN5hAZHqHe2SOkS7DRd+35yLP7o8btpmzG
9hEMgfPAdWYxMomL2TOzIj9la+nicnpVLBBHfkcQ6NEpBIeIgGHCzyS4GvyCUnbX
z+yIoFByLXGOHrwqo/h5Qbl8oEKGR0fP5vK+VaB6LkoMd3mG0Hm+gPy0Pxd8Issp
X9cH/PfZglG5hjRBdVNKEKaz4sEOpw==
=7njO
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--


--===============8622034053737852568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============8622034053737852568==--
