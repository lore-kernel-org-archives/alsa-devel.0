Return-Path: <SRS0=lB/p=BW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182DCC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:07:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93FBC2080C
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Dn9XOztM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT2HBedN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93FBC2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5D8A1663;
	Wed, 12 Aug 2020 14:06:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5D8A1663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597234025;
	bh=MM8pmV2QgsjxdXSSM0B2DrSsgot2dM8rNva9Cu3oxH8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dn9XOztMtMx8/vVuqO9EOkQVnaXVMR94xYh7l79hBWdfHLEE+xV4mXCsbmAeYsUWI
	 3xHE0WZ8fbazP/irJtFPHLoNWFGacFA2RY2v3AFVycpwtWf704kIDtQN+7AglOf7nu
	 qMcTWgJg96zchGeww0YBOX93PxlkU7h9nZ8yQsT0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72E37F800F4;
	Wed, 12 Aug 2020 14:06:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DA980F8022B; Wed, 12 Aug 2020 14:06:13 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01A93F800F4
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2020 14:06:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01A93F800F4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="jT2HBedN"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E78D4207F7;
 Wed, 12 Aug 2020 12:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597233964;
 bh=MM8pmV2QgsjxdXSSM0B2DrSsgot2dM8rNva9Cu3oxH8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jT2HBedN+7Xl2ZMqfco4gYuAi3jJlp6W72K6S+ofFy1AO5aUUC1zZeI5QwXPv89S+
 JV0aP++AnLYNFZ7uvMw85wcAQJ7QwOTYxV2wD89dpQubayYvwWjJCwntESy3xnX3r1
 0jrjy1RRyENK1rJGcsxsZdOpUos08yVoOzHs1NG8=
Date: Wed, 12 Aug 2020 13:05:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v2 1/2] ASoC: mediatek: mt6359: add codec driver
Message-ID: <20200812120537.GA5545@sirena.org.uk>
References: <1597028754-7732-1-git-send-email-jiaxin.yu@mediatek.com>
 <1597028754-7732-2-git-send-email-jiaxin.yu@mediatek.com>
 <20200810185933.GI6438@sirena.org.uk>
 <1597217353.23246.45.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <1597217353.23246.45.camel@mhfsdcap03>
X-Cookie: No purchase necessary.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, shane.chien@mediatek.com,
 howie.huang@mediatek.com, tiwai@suse.com, linux-kernel@vger.kernel.org,
 tzungbi@google.com, robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 eason.yen@mediatek.com, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
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


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2020 at 03:29:13PM +0800, Jiaxin Yu wrote:
> On Mon, 2020-08-10 at 19:59 +0100, Mark Brown wrote:
> > On Mon, Aug 10, 2020 at 11:05:53AM +0800, Jiaxin Yu wrote:

> > > +void mt6359_set_playback_gpio(struct snd_soc_component *cmpnt)
> > > +{
> > > +	struct mt6359_priv *priv =3D snd_soc_component_get_drvdata(cmpnt);

> > What are these, should they not be managed through gpiolib and/or
> > pinctrl?

> These are the functions that control the mux of input or output
> signal. I refer to the other codec drivers, most of them are manipulate
> the regs in their codec drivers also. Maybe it's easier to control?

These functions are exported for other drivers to use rather than
something done internally by the driver - if this were internal to the
driver it'd not be a big deal but when it's for use by another driver
it'd be better to go through standard interfaces.

> > > +int mt6359_mtkaif_calibration_enable(struct snd_soc_pcm_runtime *rtd)
> > > +{

> > > +EXPORT_SYMBOL_GPL(mt6359_mtkaif_calibration_enable);

> > Why is this exported?

> This function is exported to machine driver to do calibration when
> registering. The interface between MT6359 and MTK SoC is a special
> interface that named MTKAIF. Therefore, if MT6359 is to be used
> normally, it needs to rely on the platform for calibration when
> registering.

So this needs the SoC to do something as part of callibration?

> > > +	switch (event) {
> > > +	case SND_SOC_DAPM_PRE_PMU:
> > > +		priv->dev_counter[device]++;
> > > +		if (priv->dev_counter[device] > 1)
> > > +			break;	/* already enabled, do nothing */
> > > +		else if (priv->dev_counter[device] <=3D 0)

> > Why are we doing additional refcounting on top of what DAPM is doing?
> > This seems like there should be at least one widget representing the
> > shared bits of the audio path.

> We have "HPL Mux" and "HPR Mux", there will be two paths enabled when
> playback throuh HP. But actually they share the same control sequences.
> So in order to prevent setting it one more time we do additional
> refcouting.

That sounds like you should just have one output path defined in DAPM
and merge the left and right signals together rather than maintaining
them separately.

> > > +	/* hp gain ctl default choose ZCD */
> > > +	priv->hp_gain_ctl =3D HP_GAIN_CTL_ZCD;
> > > +	hp_gain_ctl_select(priv, priv->hp_gain_ctl);

> > Why not use the hardware default?

> We have two ways to control the volume, there is to select ZCD. Because
> the other one it not often used, ZCD is used by default.=20

Why not just let the user pick at runtime?

> > > +	ret =3D regulator_enable(priv->avdd_reg);
> > > +	if (ret) {
> > > +		dev_err(priv->dev, "%s(), failed to enable regulator!\n",
> > > +			__func__);
> > > +		return ret;
> > > +	}

> > Perhaps make this a DAPM widget?

> "vaud18" needs to be always on so we enable it when codec probe.

If it is just supposed to be left on all the time it's better to do this
in the main device model probe rather than the component probe.  The
component probe should usually only be used for things that need the
rest of the card to be there.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8z2xAACgkQJNaLcl1U
h9D7Wwf+OdwVBUD42cfqMOKbAwel1jObAQofx/ASxy8YgjsPQp8Jjkm39G6YSYyJ
8nK3lQ1sz6qZtJ2KsZp6jG/aEOC5w7aBQdZszyRHXuneIp4KtvLG+AYHSO54DMXb
ftsOw4EyQjzNY61qz0ZZ3H7vMObW+1o8uMEBKadB8MMz7oufbCUcV8auAps+K+L1
si165INgJFZpfrKk/8YvNVqBAlcXMDjGpcZtO6gfEi9AuDQnZfJWte/1hOBgQynL
84UFJWIEtkVCWadlYwBU1VcQD/3bOkpfyFMIoYII0BquCKBUqxmcLA2NxFV7Ami1
U58UVe1qf4mt+vS7hAjBlmh6JTrUnw==
=Fkwb
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
