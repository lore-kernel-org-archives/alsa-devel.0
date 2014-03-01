From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4-resend 1/7] ASoC: sirf: Add SiRF
 internal audio codec driver
Date: Sat, 1 Mar 2014 12:16:46 +0900
Message-ID: <20140301031646.GJ29849@sirena.org.uk>
References: <1393399342-31177-1-git-send-email-rongjun.ying@csr.com>
 <1393399342-31177-2-git-send-email-rongjun.ying@csr.com>
 <20140227053339.GU9383@sirena.org.uk>
 <86130EF012BDF348AA0D464A4F449478012AE51755@SHAASIEXM01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3592236404086324477=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E7EB0265976
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 04:16:55 +0100 (CET)
In-Reply-To: <86130EF012BDF348AA0D464A4F449478012AE51755@SHAASIEXM01.ASIA.ROOT.PRI>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rongjun Ying <Rongjun.Ying@csr.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, DL-SHA-WorkGroupLinux <DL-SHA-WorkGroupLinux@internal.csr.com>, Liam Girdwood <lgirdwood@gmail.com>, RongJun Ying <rjying@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3592236404086324477==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ONvqYzh+7ST5RsLk"
Content-Disposition: inline


--ONvqYzh+7ST5RsLk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 28, 2014 at 01:52:32AM +0000, Rongjun Ying wrote:

> > > +static struct sirf_audio_codec_reg_bits
> > sirf_audio_codec_reg_bits_prima2 = {
> > > +	.dig_mic_en_bits = 20,
> > > +	.dig_mic_freq_bits = 21,

> > This looks like the sort of thing that the regmap_field layer was
> > supposed to hide?

> Do you mean I need use the regmap_field_read/write to hide these?

You should certainly consider it and if it's not a good approach
understanding why may help us improve that API.

> > > +static int sirf_audio_codec_runtime_suspend(struct device *dev) {
> > > +	struct sirf_audio_codec *sirf_audio_codec = dev_get_drvdata(dev);
> > > +	regmap_update_bits(sirf_audio_codec->regmap, AUDIO_IC_CODEC_CTRL1,
> > > +		(1 << sirf_audio_codec->reg_bits->codec_clk_en_bits),
> > > +		0);
> > > +	return 0;
> > > +}

> > Can you disable the clock in the clock API as well?  This might allow
> > further supply clocks to be disabled and is genarally good practice.

> This is a workaround. The capture ADC and touch ADC use a same power supply,
> The codec ADC's change pump set or clear will impact touch ADC unstable.
> So It's need enable codec clock and set change pump when the Audio driver init.

That doesn't really answer the question for me - I wasn't asking why the
clock was being disabled, I was asking why the disable wasn't also being
done at the clock API level.

--ONvqYzh+7ST5RsLk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEVEbAAoJELSic+t+oim9rVQP/10g0PT35jk8WxUJLKXUNprY
uvw7RUWT5dT2krRYRhCAQ9428GrRu/PWyXm4dEgPZZfOdtuYmSwZNEGPNg04kix0
OVp4+9OQVPvjhRwJQnS5ZiwDcSc+mgH85611bpyPC5PUzytFnEIGaowJ0PJpdBWr
LpXzBDpsSlA6uG0RtRBZprJpsP/Ix1/oNXET4XsvxRwEFrqpzz/WsC1dbxUfhAOf
bC9ke7TH9TjKvXy3q5L/p/54OJ/ynlCtxOo39pfNS+7fJqCajTiMhZrUzJAdbJue
Ktp1fjfcQBIZmtDdVl2qf71YL0RxQA5mjseOEmqRSekArI5zJxnkTY0SWShGxX2v
/Yj0BpcGiptG+FpQ5UUx0eB6yU3LOc6txNZJjcP8eODm+g7x8tO9j40xdhuN8edr
iWkMti23FGdQHBMscYh8IAF4Gxl2hHZ6p22h7gsaclSuCEy7yWua5FyLKY6RbYe4
IOIiHtQXoHXUsOadyYNF6O0a4zvMtoghT9HpfR+ABNcj95N8zRuvSCKOT85aCZaH
OHxhyzH145MkdQnRQjmHXTpLmHmF/lCGU8vT3sTRaztySYY0oLuDmFXB9lD8gpqy
ENGYNRI3kZJfTlmWW0IW94cQjjIeULtKgZ0DfoSwM8XPU8WFIM4aCYIJ4Sgr+858
aNYyNLHjq9T/FaIJI1lo
=IwdW
-----END PGP SIGNATURE-----

--ONvqYzh+7ST5RsLk--

--===============3592236404086324477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3592236404086324477==--
