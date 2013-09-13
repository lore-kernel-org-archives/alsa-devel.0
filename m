From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: ab8500-codec: info leak in anc_status_control_put()
Date: Fri, 13 Sep 2013 18:36:45 +0100
Message-ID: <20130913173645.GT29403@sirena.org.uk>
References: <20130913075336.GD19211@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jpNsmycLK1vweNPE"
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130913075336.GD19211@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Fabio Baltieri <fabio.baltieri@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jiri Kosina <jkosina@suse.cz>, Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--jpNsmycLK1vweNPE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 13, 2013 at 10:53:36AM +0300, Dan Carpenter wrote:
> If the user passes an invalid value it leads to an info leak when we
> print the error message or it could oops.  This is called with user
> supplied data from snd_ctl_elem_write().

Applied, thanks.

--jpNsmycLK1vweNPE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSM00pAAoJELSic+t+oim9P3QP/22IHAKPx+KxgPzJ/AbXyITC
t8IR7GZPZDLGGuZU+EKlzf0jKvU/A2p1AjVNEgHB4LzZyqJ62EIc8YK2AiF2mau0
9ALRT0H31BceygAC0AuC1RlQi2BNCqc6y28ZEKq1vnk39cAr/rjTS6iq3eL2U8OO
wg1crh6SveE3xj0f16D0vQZUYBMkPdhiRqU1GkGqmoVVnGE5DKGbJWzNlwYW+ONM
nSRqK58oe79ZwRPVOwS04JXJj8rJSR8HyRDeqrt+5cCR8fqtC9BsCak7/tvcEgcg
HoI/1BSN5DrDSwc7TlKOJL26Md4g2cwDPVswByy54xHRbU9lv6jpxvghxqyQnIvq
6UQAgDVW3Lmp2SRf5sUsi/6m/Z+bIKaZ8w0pjN17igNvlxnNHKdOkoaxebdHaKTG
Ha5IGpfZK2wsOYN5oSN1vSaoBiTHwIRFp7tc3jB7Lh1wMvEvqnE/kjw5/fipP3gL
KPeOhTgsWwA8+8Y05ufdpl6DIJDnu+/5EvCjW4zwHioCQMtFPYmn8RT2bwN7Hnbl
SZNOdvarOZMfL/sLvT/U/MjaE7go2GrbwEuvK94HcdOFFT4sJoIXWRqo3C3DbQKz
vL5YdgdQ3Dj//vJCXg76yd7iNwq9Q3mzfulUNX1veAqrRw/MNmIelgERsDfQ32Fh
o3oa1SZWFb6fk4b4EzNU
=kFrm
-----END PGP SIGNATURE-----

--jpNsmycLK1vweNPE--
