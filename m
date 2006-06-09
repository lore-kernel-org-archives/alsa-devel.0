From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 03/12] snd-aoa: add aoa core
Date: Fri, 09 Jun 2006 14:10:02 +0200
Message-ID: <1149855002.3864.14.camel__41687.6097479419$1149855102$gmane$org@johannes.berg>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130911.997152000@sipsolutions.net>
	<s5hk67s4ywh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0576792768=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 139AF175
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Jun 2006 14:10:17 +0200 (MEST)
In-Reply-To: <s5hk67s4ywh.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, netstar@gatheringofgray.com
List-Id: alsa-devel@alsa-project.org


--===============0576792768==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Oef2AFpX+8sFpfuLlfcJ"


--=-Oef2AFpX+8sFpfuLlfcJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-07 at 20:13 +0200, Takashi Iwai wrote:
> At Wed, 07 Jun 2006 15:09:12 +0200,
> Johannes Berg wrote:
> >=20
> > --- /dev/null
> > +++ b/sound/aoa/core/snd-aoa-gpio-pmf.c
> (snip)
> > +void pmf_handle_notify_irq(void *data)
> > +{
>=20
> Missing static.

Added, thanks.

> > --- /dev/null
> > +++ b/sound/aoa/core/snd-aoa-gpio-feature.c
> (snip)
> > +static struct device_node *get_gpio(
> > +	char *name, char *altname, int *gpioptr, int *gpioactiveptr)
>=20
> Unconventional style.

Heh ok, fixed.

> > +irqreturn_t ftr_handle_notify_irq(int xx, void *data, struct pt_regs *=
regs)
> > +{
>=20
> Missing static.

Added.

> > +static int ftr_set_notify(struct gpio_runtime *rt,
> > +			  enum notify_type type,
> > +			  notify_func_t notify,
> > +			  void *data)
> (snip)
> > +	if (old && !notify) {
> > +		free_irq(irq, notif);
> > +	}
> > +	if (!old && notify) {
> > +		request_irq(irq, ftr_handle_notify_irq, 0, name, notif);
> > +	}
>=20
> Remove braces. =20

Right.

> Any error check from request_irq()?

Ah, I figured it didn't matter, but it indeed does. Fixed.

johannes

--=-Oef2AFpX+8sFpfuLlfcJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIllGKVg1VMiehFYAQLieg/7BrQJUfyNhRwabyy6A5GQuV5i8W6V5Mxk
FboPzPp52VfuteqUcCtpItoztKmCsLwJrZA9s4YyLAiYFjNUzN31mSejPatK3ZuE
2Rka2x3dEbvinYHP8LvIo6YdlbeLwX10zCIe1aJOvf+7lwb8z1xGus/GXDaqK9ht
UsmN2mX+HCpxs5RbLHeem+85moquMCacNF+qnOUGwMc6QoQBtQOGy0N3tZ3t6XE3
Dt5iqoyNwMNqxBtPkx1q0kfiKV4+LIJWFN8pFHEwojObYyicFtyayTQ2IFzehVe7
TnKMmxHhfJVdhfJT3xdFkX7nkzNCGV/kCE6RUR5qtcPCoUxacUKji1UdU5JZNjME
OuWXe1wtbO2DzFOZ3WzcwKQdZP7729OkqQqzhEsNyVIW96wwyiU0mOK25OPdGrY9
SSfO05kGgVL6GHU3bq3clFQufOj30G2DPUthdyml79aGameITQ0htKkqcCF2RGH7
AnG8623YP5ChTv47lfZzD4dTF7bEFS2P8reWytPewPV2+dsCTYDFlGln2uSvs5mm
ox15PSpSQLKlX2KtBasNnQNquSRC3q36upxDZKcjf5IGsirX0/sKtxO3Mt59nuEh
erTNKsurzlQKNWRzSlQgdjMQzcX9XOqZbblRCoOYLLddwV4DYEGo/0a/MVYJkt0A
GGRweIstSGI=
=FG4v
-----END PGP SIGNATURE-----

--=-Oef2AFpX+8sFpfuLlfcJ--



--===============0576792768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0576792768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0576792768==--
