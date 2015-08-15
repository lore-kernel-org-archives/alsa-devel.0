From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/9] ASoC: Intel: Skylake: Add topology
 core init and handlers
Date: Sat, 15 Aug 2015 19:46:58 +0530
Message-ID: <20150815141658.GF13546@localhost>
References: <1438976184-6160-1-git-send-email-subhransu.s.prusty@intel.com>
 <1438976184-6160-6-git-send-email-subhransu.s.prusty@intel.com>
 <20150814220313.GW10748@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8943736454637162760=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E5C92608EC
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 16:15:00 +0200 (CEST)
In-Reply-To: <20150814220313.GW10748@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8943736454637162760==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="at6+YcpfzWZg/htY"
Content-Disposition: inline


--at6+YcpfzWZg/htY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2015 at 11:03:13PM +0100, Mark Brown wrote:
> On Sat, Aug 08, 2015 at 01:06:20AM +0530, Subhransu S. Prusty wrote:
>=20
> > +	struct skl_pipeline  *ppl;
>=20
> > +	pipe  =3D devm_kzalloc(dev, sizeof(*pipe), GFP_KERNEL);
>=20
> There's lots of random spaces in this code so far and some further down
> too.
sorry about that, will fix

>=20
> > +	struct skl_dfw_module *dfw_config =3D (struct skl_dfw_module *) tplg_=
w->priv.data;
> > +
> > +	skl_tplg_dump_widget_info(bus->dev, dfw_config, tplg_w);
>=20
> Consider implementing debugfs for this...

yes that a good idea, will drop this here.

>=20
> > +/* This will be read from topology manifest, currently defined here */
> > +#define SKL_MAX_MCPS 30000000
> > +#define SKL_FW_MAX_MEM 1000000
>=20
> Oh dear, this sounds like we need another ABI update to add these
> manifests?

Not yet. So we will add this and few other stuff in topology manifest vendor
data for Intel. So Topology Kernel ABI will not get modified with this.
Yes we need to start adding these data sets to Kernel ABI, but I am planning
to add that, one shot at the end of SKL cycle so that we don't have to modi=
fy
ABI defines.

>=20
> > +	dev_dbg(bus->dev, "In%s req firmware topology bin\n",  __func__);
>=20
> Those "In%s" are going to come out as the function name prefixed with
> In.  What's that for?  It's just going to make the logs harder to read
> as far as I can tell :(

Will fix this

>=20
> > +	const struct firmware *fw;
>=20
> > +	ret =3D request_firmware(&fw, "dfw_sst.bin", bus->dev);
> > +	if (fw =3D=3D NULL) {
> > +		dev_err(bus->dev, "config firmware request failed with %d\n", ret);
> > +		return ret;
> > +	}
>=20
> We're ignoring the return value (which is what we should be paying
> attention to here) and checking to see if fw is NULL but fw wasn't
> initialized :(

Yes, will fix

>=20
> > +	/* Index is for each config load */
> > +	ret =3D snd_soc_tplg_component_load(&platform->component, &skl_tplg_o=
ps, fw, 0);
>=20
> Which index?
The last arg of snd_soc_tplg_component_load() is id which is set as
tplg.req_index =3D id;

So the comment tries to explain how last 0 index is added. We have only one
load so we will be always 0 index


Thanks
--=20
~Vinod

--at6+YcpfzWZg/htY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVz0naAAoJEHwUBw8lI4NHn6QP/32zFQ/b+Gq7yF+FcgegNYxn
cC4bEaWZFbauZdshNEbrZR+twrzCbd9/wAjw+6DXOY/igCRCWh7hMJSUNSKaXBNI
McHh/oEOZBTlgOWj9Gku3lyZjwxhX/KGCIwpRfjl6TlDotUg2e1efpDGmYb36a1+
COmzWNm+uB67wJHw2Q3ek0boNoapnNBanrgu/cKUTXP5vRD+tXGXshZ236GhoSRg
t053qGauyTBFnwUc/FW5DUBDW1fd8UQcu2Ex/Dfplyozl1SvuGZih5PzFPmwWSL/
jNf193Unb+1N/3ubsuTbNsq6/cyF5KOa3ukQaCSwHa97z4H5h5rpXikTLaSEQn+z
UpEpXiIUZdSoKyDtIGOe6jaBZVqhVCdkjPOFlvaBqZdUu4AjHfvqLU/OfoMfY3bY
oMtuqurg4hjpXAasYERLIOc4HtXKDPeMRJaiIhUWFgCRjzOtvFxM0cJ78InAt9bl
xUPNgV+Q3rPqtO0Nethq55KAcUjXLQgPpuRuBPbf/FL/lfflv/M8zvsrp2BQPXop
u/PIXP8Umuzr/V5EbkoQDRiw6K7yoc+Y6+vIriu3lpfFPXXlO17nZthIHLtTCI24
p98vWsvqeSp7UEz4ksNogByug3TAMSV4RJtZguDSziKpS/jVDhN+D0NhkRXO/KfI
ZP8jjs2bLpTw9mK1GvrT
=0k+s
-----END PGP SIGNATURE-----

--at6+YcpfzWZg/htY--

--===============8943736454637162760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8943736454637162760==--
