From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: rt5640: add device tree support
Date: Wed, 12 Jun 2013 18:06:06 +0100
Message-ID: <20130612170606.GO1403@sirena.org.uk>
References: <1370983240-4976-1-git-send-email-swarren@wwwdotorg.org>
 <20130612164628.GN1403@sirena.org.uk>
 <51B8A84E.9010106@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2575776132801053926=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <51B8A84E.9010106-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, flove-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============2575776132801053926==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V/YKEhZ4Pe4jxeTU"
Content-Disposition: inline


--V/YKEhZ4Pe4jxeTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 12, 2013 at 10:56:46AM -0600, Stephen Warren wrote:
> On 06/12/2013 10:46 AM, Mark Brown wrote:

> > Unfortunately gpio_is_valid() is unhelpful for platform data since
> > often zero is a valid GPIO but it's also the default "do nothing"
> > platform data.  It's therefore better to either include a check for
> > non-zero as well or have code that takes a zero in the platform
> > data and sets it to a negative value instead.

> I think people filling in platform data should simply be required to
> put a valid/correct value in that field. There aren't any users of
> this, so it's not like adding a new field where
> backwards-compatibility might be a concern (and even then, updating
> all users of this platform data type wouldn't be hard), and it should
> be obvious if you get it wrong.

It's not idiomatic to do it this way, it'll catch people out - sadly the
effects are often non-obvious, depending on what actually happens with
the GPIO.  Were it not for renumbering pain it'd probably be most
sensible to just make 0 never a valid GPIO :/

--V/YKEhZ4Pe4jxeTU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuKp7AAoJELSic+t+oim9+jMP/iP7J7Wi5R70QpZbqSDiQE6p
5UkMqim3EMYlW0dRsiqJsXm4n8OWuLn8o0bMw+m9zgIVr6y3yfYBADCpdPyisTZW
7W3L7ZI9kpSNpA2bc9rXtmwC7Al79DJqGTFOtuT1YvLoBOCIDrDEpTEhMBNT/A8W
y2lMICXLWTA6KHl1pSGmgZOVHkMawN0YTIVf0jOyjdxSS/9E41ul4fh2VeU2QJ3J
2HuLlyCTPFSKY2fWGs5PUw6PcZGfYkB/M+5uYFDA2KsKoD41ljcPcVE/8Kc+549K
N59bfOUQP2tdv6KqG9DtRJal7WKJmazWyMEi+anMhdJHMaaxwtSzy+N707nJxOoW
I2QvV9ZEkQJ1hlB1CCxL9b1PLHROA/jo3WyTzagRLSqB2A2/YP/aKzaSpSPL+YfF
yiRTHklP3hVUXSsihvvJ9iuRBA7E/YOuj9+GX25d4Fswr4BgIsxBFs41fAE5Aw5W
cKk6K2DJbceSK3wBlcLB9FRHAFaU20feLmel/XYO5MuyNeFoXSM54xa71w+ZnHrW
VVv3QPmVDsDAD0YiQvX5rvlRLz6RpQkxy0SnGiTYWnyacTYae9TARPtS0VKCMReW
UNbYjALyoOEllMFJBpIFh/b+zUBm3MHbsoJmhPpG9M9JBKM80Fb7pygKHSsCLTsj
KhPbVEvl7VEWtpNFlKLv
=nQc2
-----END PGP SIGNATURE-----

--V/YKEhZ4Pe4jxeTU--

--===============2575776132801053926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============2575776132801053926==--
