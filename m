From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: why snd_soc_suspend is not called
Date: Thu, 21 Jun 2012 10:12:53 +0100
Message-ID: <20120621091252.GG4037@opensource.wolfsonmicro.com>
References: <CAMj5BkgV9odU+1VwhXx5w0Y8pPdHg25tHWNMX-5ecG_aL+r+cw@mail.gmail.com>
	<20120619093000.GA3974@opensource.wolfsonmicro.com>
	<CAMj5BkgbmdALET_hiHL1LNs7v-+9RyEQPgg1EBzyadt6rZ+EJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5130047804629823875=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <CAMj5BkgbmdALET_hiHL1LNs7v-+9RyEQPgg1EBzyadt6rZ+EJg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Qiao Zhou <zhouqiao@marvell.com>, alsa-devel@vger.kernel.org, Leo Yan <leoy@marvell.com>
List-Id: alsa-devel@alsa-project.org


--===============5130047804629823875==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Content-Disposition: inline


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 21, 2012 at 10:47:12AM +0800, zhangfei gao wrote:

> Thanks Mark.
> Using snd_soc_register_card, pm ops of cpu driver has to be provided
> instead of dai driver as before.
> However, SNDRV_PCM_TRIGGER_SUSPEND/RESUME can not be called.
> SNDRV_PCM_TRIGGER_START/SNDRV_PCM_TRIGGER_STOP will be called in suspend/resume.
> Is it right?

No.  The ASoC suspend and resume process should be exactly the same for
both cases.

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP4uWNAAoJEBus8iNuMP3dmrkP/iUE2hzVQsBtn0nnRAsjWw8C
brUKD9qPRT/+R9S7vgOuU19NOgNrXKGOP/qYV1NedYlECojH3LEL+eb8LVTDs06C
SooFuAmMtvqNUCV4ZLEJsPzXj4qSGgaxAsSe+RqbJ3jvwEz9ZB03TiOXcOtn8cxK
QJV4w44Qz83feC2ZxlGJMj75oG1Ov1oWm/oAfniZ1PYap/Ggb/QIY8nh3idTG52A
OB/We4xDVtVqNA6Ic/15hkNUFqGR6vcQmAcNyNsndWX9dENC8SFifswyX0ETnqlk
y7HpAt7OA977JJtZ5tmQpdVNYqqKhofLkxPdT5ON+wJYwYgYBWHiYzGdgTQhZaFF
qyD0hA5psQiv+xX/+F+xyIOl/KZ5A+bFzI+MGOA46sVzv+UMaiTv6yrql5M1xrS5
abLNu3rO8591tdhI/y1LGNaJkH6hKgRJTPbeiK0E4NHTXnZXRV8oPdN20mfbEYuw
fry6cyBTsT1LOye2SHD28EGHw0lQ91xQXM4moF9cYuo2IVKRRc+YbVOJTI1/JPpd
9qSC4kN0nkmlRBPXdwY0n2pViypUafsvFhLSk0inlLn/2uTmGfERj4h2BOxN8L4p
aVnH/u5F8n/a3U4KKlQ1d/y4dFSFwCUvVIRN8FfryqF6uZnVEPtyGP+ie+2jv1Ba
o8vMkUMntHvhIMejxKH0
=hy3u
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============5130047804629823875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5130047804629823875==--
