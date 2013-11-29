From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ALSA: add new alsa control byte extended
Date: Fri, 29 Nov 2013 11:46:03 +0000
Message-ID: <20131129114603.GS27568@sirena.org.uk>
References: <1385699397-18662-1-git-send-email-vinod.koul@intel.com>
 <s5hbo13fy6c.wl%tiwai@suse.de> <20131129074459.GE8834@intel.com>
 <s5hzjoneft5.wl%tiwai@suse.de> <52986123.5040004@perex.cz>
 <s5hsiufedxu.wl%tiwai@suse.de>
 <20131129110549.GQ27568@sirena.org.uk>
 <20131129102937.GG8834@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5694965394203573940=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DDDE3265577
 for <alsa-devel@alsa-project.org>; Fri, 29 Nov 2013 12:46:08 +0100 (CET)
In-Reply-To: <20131129102937.GG8834@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5694965394203573940==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nccO0ldXW0cuDU6a"
Content-Disposition: inline


--nccO0ldXW0cuDU6a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 29, 2013 at 03:59:37PM +0530, Vinod Koul wrote:

> I think this would a bit problematic for DSPs with large controls. We are
> looking at 3 digit number already and splitting to multiple calls is going to be
> bad from a already constrained latency problem.

System call overhead on Linux is pretty light, and we can probably
arrange for the implementations to know if the algorithm is running and
start doing the I/O immediately if it's not.

> I am leading more towards adding new ioctl for this along with new ones for
> enumerating controls. Then additional support for alsa-lib and tinyalsa.
> That way existing tinymix, amxier can see these as controls while not disturbing
> existing apps. I dont think we need save and restor, then alsactl need not be
> modified.

I doubt you need it specifically for alsactl since that's a bit basic
for most of the users but it would be good to have the ability to write
tools that allow people to tune interactively and then save the results
in a format that's useful for whatever use case management is in use.

--nccO0ldXW0cuDU6a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSmH54AAoJELSic+t+oim9+hsQAJkdtBRaf9bDb/aCC+eQeL1z
DcOQg413UcIrlzlL0TDJEU9w2/4lcK/FbVbEjIVxVSxE4FLokAWPFxsM4TyzpZNM
NMVRhI5Sj5FD2dWgJPerbXLkM18P/RkG4DXwAR9KrjD5LUN5NvFKV0Woeqg+6Rmq
sT9dAfaSf+LSi/L4LUYMhR286eEQtDHhG9r9V6DNtJsTvNpK0YFCSu9i7WvXoFt+
14c/MaFq1D7D3LWjw5tzlcv+yNCaKUDNQHVPpYN7XId9Z91XHYSeH3FTf9McdKo0
Pvpnzjq371LlMpNPkpdX66+2MsgcEf/BFWYyyKa2+zVs1sp4IYXCXmscBaFstXbG
jFHJ8LyhIHHYXkOSTYBMQI98l++y1lxJDFT0dYKEmmLWGRF8Wd69Lh4l4D0ZKje2
lVKctHyXrucRaUrc0fLr/liDPYy/5pWFrHo7kRp7eYuVEr0wTNRk78WET4gYpn9g
qLi27MXy7IXDx/TnFi7KLZ6fmjC27HqMDR3E1N0kX2qBefGXstKlK0+Fj/od5Haa
/bFboygGmZJwLqfOyBOxox78/o5/EucoBmP0Nqv0DazW6p0JFlL4xwf+co37O9Vv
JnhEAbyZo18XWTSWLyzIAP75QBXRKPJL6GYISGl/eDxb/bLkzUyIPnJuUMGMmj/o
AnJLY0OneERRCT3zC3Qj
=5Zni
-----END PGP SIGNATURE-----

--nccO0ldXW0cuDU6a--

--===============5694965394203573940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5694965394203573940==--
