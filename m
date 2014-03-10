From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: davinci-evm: Add AM43xx-EPOS-EVM
	audio support
Date: Mon, 10 Mar 2014 11:57:47 +0000
Message-ID: <20140310115747.GD28112@sirena.org.uk>
References: <5315DF41.1090302@metafoo.de>
 <1393947831-26116-1-git-send-email-jsarha@ti.com>
 <20140305014259.GR13126@sirena.org.uk> <5319BF67.3060403@ti.com>
 <20140309081102.GL28112@sirena.org.uk> <531D98D4.7080806@ti.com>
 <20140310110926.GX28112@sirena.org.uk> <531DA283.1020402@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2143213315259500542=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3184226507F
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 12:57:58 +0100 (CET)
In-Reply-To: <531DA283.1020402@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: liam.r.girdwood@linux.intel.com, detheridge@ti.com, alsa-devel@alsa-project.org, lars@metafoo.de, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2143213315259500542==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HiaQvdnqo9FN6ymz"
Content-Disposition: inline


--HiaQvdnqo9FN6ymz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 10, 2014 at 01:31:15PM +0200, Peter Ujfalusi wrote:

> Exactly, CBM_CFM means that the codec is the master of both clocks. Codec is
> configured as master and the cpu side is configured as slave.

> But the issue is that with simple card (when you want to have the codec as
> master for both clocks):

> simple-audio-card,codec {
> 	sound-dai = <&aic3106>;
> 	bitclock-master;
> 	frame-master;
> };

> simple-audio-card,cpu {
> 	sound-dai = <&mcasp1 0>;
> };

> The codec will get CBM_CFM, however the cpu_dai will end up having CBS_CFS
> (since *-master is not specified in the dts).

What I would expect the code to be doing here is coming up with the same
setting for both ends of the link rather than trying to parse the two
ends of the link independently - though that *is* more flexible it's
unlikely to actually work in a system.  The properties on each end of
the link aren't independent of each other.

> So when the simple card parses the master/slave configuration it has to invert
> the cpu_dai settings it got back from snd_soc_of_parse_daifmt() to get it right.

Or there should just be one unified parse.  When reading Jiri's mail the
lack of any reference to the code it really sounded like he was asking
for the result of a single parse to inverted between passing to the
CODEC and CPU sides.

Needs looking at.

--HiaQvdnqo9FN6ymz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHai4AAoJELSic+t+oim9ZHgP/3RsVOYU+oT7HchJhM+GwC6u
DXozxJdN3L97GpXQPRO0wzy896QDMz9EZ65kgKIh7faw7g+yv9YbtAkO2We2w0BU
ai0Yh1NVXiXX1LQOZm3W/zqP324ky7cZSha/LGVIsmRPlR/zeL+x9NgJQVigjYBS
UPwETJIGGcshIn1Usfusk+1jTykev9BuQCIfxrc6ZLLCZAyqdNeFxW2BXSn2DNwD
Ri6r1iLGvb8+tOiI4V+vZy8T3DGL2VAdWvwhbevhHvwCSZCOW4Yzyya2yepzC2MH
2dTH9Zhr0+DALvola5RBEc6ZrCmCV1eJJhUY3rEHjEAFEYXHkMCV2VUBwLrPGn0l
HRhKVfflCjhk7XAWhwLsY8YHKzEUDIf8frkiQ/BWIcpu9+tFZ8EonWLiXA53zDmE
/kHEmvlQui+UtKyW9rOlifVNS1j5f9E+babVN/jAqAmDoETiGwug6PFrZ65xKR7A
GoMzBxXzyuKg8a5ROiofHeRKhwRqjL3li9hLksvBYkfDU0urV714fWFKCLYzBTOU
vKIKDe+jW/VjSkjuqpOndovJEo+nD7KzpjsTH9r67+iFzsOnWZlK42KzDZb5cfK3
hjqi9RCBQcoyR9v/cZsob56LC+BjP2Qty1xZiK9N/zZuxYUnFK60my6uU2ZNYdsK
4aAH5IGLmOh8U5A2I7iy
=5t1A
-----END PGP SIGNATURE-----

--HiaQvdnqo9FN6ymz--

--===============2143213315259500542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2143213315259500542==--
