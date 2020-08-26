Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ADEC433E3
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:48:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CAD22B40
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LXZgORBM";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yGPqnz+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CAD22B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4402B16CF;
	Wed, 26 Aug 2020 15:47:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4402B16CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598449720;
	bh=ZA0fSwL8NzC6mMs/LwDsWlnjWb3abNWBYTeue6Ut3J0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LXZgORBMPOkSg+a+t3jz+87eQSQryQ3nvIRu80efQuUJisaDPJag7kRgQT5Hb3Nqr
	 I/ZLEzSa4ykOQn2Oq6y+Kd+zatrnB4epXElv9FbeOmVuyKKU2tAU2ZYR7PXE5Y7QW4
	 5lRy0aO4Wnv2rCNyjEnBP1IthKbt9XY/kQUZc75k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3400F8016F;
	Wed, 26 Aug 2020 15:47:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 78262F801D9; Wed, 26 Aug 2020 15:47:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 27BBAF80105
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 15:47:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 27BBAF80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="yGPqnz+8"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 936A722B3F;
 Wed, 26 Aug 2020 13:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598449655;
 bh=ZA0fSwL8NzC6mMs/LwDsWlnjWb3abNWBYTeue6Ut3J0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yGPqnz+8edOAOfy0jo/ZjXs/xGpIhkdXhH71X5zqJNfKt9PR/A0B0fry+HGzKX4A8
 0DnMkqnx64qfn7oDcq+DonR6362EP1m+MKw6e6PvZkj3nTLgOafm8743OHKUQZdouW
 iLhtO+YXhc38+OOF7QVA2aQP6lxSc8tdx7L+h0bY=
Date: Wed, 26 Aug 2020 14:46:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Pavel Dobias <dobias@2n.cz>
Subject: Re: [PATCH] ASoC: max9867: shutdown codec when changing filter type
Message-ID: <20200826134658.GG4965@sirena.org.uk>
References: <20200826113904.10265-1-dobias@2n.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vSsTm1kUtxIHoa7M"
Content-Disposition: inline
In-Reply-To: <20200826113904.10265-1-dobias@2n.cz>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, ladis@linux-mips.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--vSsTm1kUtxIHoa7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 01:39:04PM +0200, Pavel Dobias wrote:
> Changing filter type without disabling codec results in filter
> malfunction. Disable codec when changing filter type.

> +static int max9867_filter_set(struct snd_kcontrol *kcontrol,
> +			      struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
> +	unsigned int mode = ucontrol->value.enumerated.item[0];
> +
> +	if (mode > 1)
> +		return -EINVAL;
> +
> +	/* shutdown codec before switching filter mode */
> +	regmap_update_bits(max9867->regmap, MAX9867_PWRMAN,
> +		MAX9867_PWRMAN_SHDN, 0);

This probably needs to return -EBUSY if the audio path is up - obviously
shutting the CODEC down is going to glitch the audio pretty badly.  It
should probably also check to see if the value is actually being changed
so we avoid a fairly expensive operation for noop changes.

--vSsTm1kUtxIHoa7M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GZ9EACgkQJNaLcl1U
h9CSFAf/WR1giJbw0J/Y+TZYpFD4P8Mffgz43/yi+Gpqd71KzPE6qTgZb4MmBkxV
gcU/8MaD+C/f7KVXEU62wkTxknSDMILqoFtyHTmKhH3+l8RQEI5Ws1BARpiTcuhB
IRp5/yjnRu3xdDdgpq8YZQg34uNCKWRiOK6aAFDkrwvy8X3hnajMKgmg5noQW7Kp
tnMFLkgkbm/svX/tu1ILuwUy6d+xKHWyuGnmHLawNsGg6yGkOerW6lHvceEvw8Ea
B37fVR60oGscCp/x5GRmgyJnxTKqbHRoc/Bb9jbaeP3fdITeDFXhFQYwQL/D5Er2
jcHmfOONjCtazgroVN31TGUGRL+F+w==
=kin3
-----END PGP SIGNATURE-----

--vSsTm1kUtxIHoa7M--
