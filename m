From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [RFC 2/8] snd-aoa: add aoa core
Date: Fri, 02 Jun 2006 15:46:14 +0200
Message-ID: <1149255974.11092.14.camel@johannes.berg>
References: <20060601115844.343214000@sipsolutions.net>
	<20060601115845.923706000@sipsolutions.net>
	<s5hverj4qsd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0149744134=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2E01C156
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Jun 2006 15:46:20 +0200 (MEST)
In-Reply-To: <s5hverj4qsd.wl%tiwai@suse.de>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0149744134==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-J/K8ujtNmJV4wKf3erVl"


--=-J/K8ujtNmJV4wKf3erVl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-02 at 15:42 +0200, Takashi Iwai wrote:
> > +static void attach_codec_to_fabric(struct aoa_codec *c)
>=20
> Doesn't this need to return an error?
> I'm afraid that module count is unblanced in the error path of
> aoa_corec_[un]register().

Not sure, I'll have to take a look.

> > +		printk("snd-aoa: fabric didn't like codec %s\n", c->name);
>=20
> Add KERN_* prefix.

Uh, right.

> > +	rt->implementation_private =3D 0;
> > +	INIT_WORK(&rt->headphone_notify.work, pmf_handle_notify, &rt->headpho=
ne_notify);
> > +	INIT_WORK(&rt->line_in_notify.work, pmf_handle_notify, &rt->line_in_n=
otify);
> > +	INIT_WORK(&rt->line_out_notify.work, pmf_handle_notify, &rt->line_out=
_notify);
>=20
> Too long lines.

Heh, I knew I'd get this at lots of places, I'll work on it.

> > +	pmf_gpio_all_amps_off(rt);
> > +	rt->implementation_private =3D 0;
> > +	if (rt->headphone_notify.gpio_private)
> > +		pmf_unregister_irq_client(rt->headphone_notify.gpio_private);
> > +	if (rt->line_in_notify.gpio_private)
> > +		pmf_unregister_irq_client(rt->line_in_notify.gpio_private);
> > +	if (rt->line_out_notify.gpio_private)
> > +		pmf_unregister_irq_client(rt->line_out_notify.gpio_private);
>=20
> Don't need kfree(gpio_private)?

Indeed, forgot that.

> > +	strlcpy(alsa_card->driver, "AppleOnbdAudio", sizeof(alsa_card->driver=
)-1);
> > +	strlcpy(alsa_card->shortname, name, sizeof(alsa_card->shortname)-1);
> > +	strlcpy(alsa_card->longname, name, sizeof(alsa_card->longname)-1);
> > +	strlcpy(alsa_card->mixername, name, sizeof(alsa_card->mixername)-1);
>=20
> Pass sizeof() without -1.  strlcpy() takes the size of the buffer
> including nul-terminator.

Yeah, I was confused about the API. Will fix those too.

Thanks,
johannes

--=-J/K8ujtNmJV4wKf3erVl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIBBJKVg1VMiehFYAQIcnw//W/RegG2OeI7zbUmovru6FTk+oEoWA4cp
Pc5Vtem5sANlrxHrkFyGc9GyrGV++VQFxR7CBmSRifOTVZMkc6LRk1pKHDCHdL47
AFuhKSODQfKw/MrGrRTr4iqEvaOgKciaAfO6OOo1sbUP7CLEzG3PkCbqQQEs6hRD
61Y1BOeo1wwgXZ5iYwVAnqpBuXIuWhOB66kOXa8AVPMGBKezkc031c1U/CVAUmyP
J+mSh2vWUcJnzHV0ent/oQY27D9RO4zscpzlVEuO7SUARhw24UWH67WRZL/7tZQ9
NALojxq3f1m3SaSNEKxlWA9Vrm3B4KpIWaP7BB/w5+BeosbeKdmz5hciHV1oWsgi
Uc1gQ8V71qOj7iaQz6dPSfNRc6rBveVDRPFXPbD3qcXRKl61z6I439Vf8Ri72iW7
WA+vr1WF2kuIzsPmxp4apSFQh0vSVdRrh+7f9H7WE51kK6CFTjbArfyILdinDb50
lpvwbw7NgdijJe28bnBXN7Y+9K3vC/dlg1u8Sse8LZL0l1TKbRu1X2WD8lxVbbIN
kpi9Cy2H7+TLvT4Y83UPYN8Mw7rAtyPkJl8tl719ZH94SVBPQIl2lKv7F1PVkyHP
lWbYgZhUgBStoV4jA0fSbYcVcU9dmBOG+U33uDG4iLr/Vb8EnVYOWnWqPtDnvTVN
e0oqzHY+IW8=
=pmHv
-----END PGP SIGNATURE-----

--=-J/K8ujtNmJV4wKf3erVl--



--===============0149744134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0149744134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0149744134==--
