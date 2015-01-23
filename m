From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: add generic dt-card support
Date: Fri, 23 Jan 2015 19:13:43 +0000
Message-ID: <20150123191343.GW21293@sirena.org.uk>
References: <cover.1421868426.git.moinejf@free.fr>
 <d0c66c2e2f200119f9990fa52a503b1a4af6238f.1421868426.git.moinejf@free.fr>
 <54C0088F.9070609@metafoo.de>
 <20150122090723.50ac0156@armhf>
 <54C14EB3.8080305@metafoo.de>
 <20150123131554.623003f9@armhf>
 <54C252F4.9000504@metafoo.de>
 <20150123193456.276ea512@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8a48p4KKsB+A/3VY"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150123193456.276ea512@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--8a48p4KKsB+A/3VY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2015 at 07:34:56PM +0100, Jean-Francois Moine wrote:

> A card builder is a device which
> - scans the graph of ports,
> - fills the struct snd_soc_card according to the links between the
>   ports and their properties,
> - and, eventually, calls snd_soc_register_card().

> The simple card builder, 'dt-card' (maybe a better name would have been
> 'graph-card'), acts just like the simple-card except that it does not
> appear in the DT. Its creation is done by an audio controller.

Which audio controller?  There may be several CPU side audio interfaces
in the same card.  For example people often want to have both low
latency and high latency audio paths from the CPU into the hardware (low
latency tends to increase power burn).  SoC centric system designs do
sometimes also have PDM I/O, expecting to be directly connected to DMICs
and so on, which results in a relatively large number of CPU interfaces.

> > > With a DT graph, each CPU/CODEC would know exactly the widgets and
> > > routes it has to define.

> > Which widgets/routes do you mean?

> Well, forget about this. I never clearly understood why some widgets
> and routes had to be defined at card level.

Please do try to understand the idea of representing simple components
on the board and analogue interconects between devices - it's really
important and not something that can be neglected.

> > I'd agree if this was some kind of kernel internal stuff, but this is=
=20
> > creating ABI and we have to maintain it forever. Rushing this in withou=
t=20
> > proper discussion and consideration of the more complex use-cases is in=
 my=20
> > opinion not a good idea.

> Using a graph of port to describe the audio subsystem has been pushed
> forwards by many people for a long time, as shown by the creation of
> the document Documentation/devicetree/bindings/graph.txt.

That DT binding was done entirely in the context of video applications
IIRC, this is the first time it's been discussed in this context.

--8a48p4KKsB+A/3VY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUwp1mAAoJECTWi3JdVIfQLMYH/1nsWWiyQztPjj7Q0emFBs7q
hmYaFi57DOH9VZBQ48aE+crsD0y1ycblJUTGIEbhae9GNzIg+U3D9FRWP7n2Sosi
l7EVK4oO4l/otol0o/1uR6abnvOFz7lMaLDeVXRjMJg3LJb+YP9ndwL77FDwrfgt
k4n4ljKpK0hHP0xOpow/ITQouPelz2Tu/p2FYMJWAkR7EedRnTmMn3bUWNrTjeZS
CEY2ldrl6WtLOBIqOIZbdIqLeHg4+tUqV6pjBZuAqmj1hkdS1EU95NcaW/yCebZV
jkBpTh0Nz0fITv+955L9q84Ehu5UfnelGmcYzd48ONFV8tDPFZVI7tmzKrBhsn0=
=SQoT
-----END PGP SIGNATURE-----

--8a48p4KKsB+A/3VY--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
