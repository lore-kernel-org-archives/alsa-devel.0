Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A08C606A327
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=tbiGL7Qy;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RA+fK3Rn
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EE288601FA;
	Fri, 13 Nov 2026 23:58:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EE288601FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794610716;
	bh=CZGWgKoiOb0WZzX9tkDAcCd5qrNdKR7L4JdHq86Y1VE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tbiGL7QytY2N3mae1vyhH3PyrWjNneCR2lLGtTi5kcp+oa9qRaIZ3rcKmA/n6gxKe
	 9lJUgViQBEu0CwTtDjEQ0PcVz7XyJZNx/5ue7T5wdzWEUx2Kjf9E4NBF2mAkTxBm++
	 coQVd5KjQvstnMoxHjJf+8zDIAiLLMOMUx9807Ww=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ACF64F80601; Fri, 13 Nov 2026 23:58:02 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F1ECF80600;
	Fri, 13 Nov 2026 23:58:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 871D9F80495; Fri, 13 Nov 2026 23:57:56 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794610675;
	b=p/SyjZiI/nc1ne7YaTeB/HLW7v76mRl7msSjMNyIynZeIVTDsnDV1UZF4lbueZ3a3vGY
	 FLnRohWtX8mV44MYCE5lQASOe4qQm5+R5ufXieSB85IslD57O2KTA+3DbO3SEkDDMuo1I
	 xBA0+hgRsGDiIOWFja+EnG3PNaBehnTzdXGq/NMPQsj3Itc9KfZDBU0mSV66WVFYJLI3I
	 zkX6/kivzDyKGtgoU1yE2TpNmGNg+Spk4xltFA649lthMJUybK/uGpRLvyK4GWGWy7ANp
	 B/+vslQVFHzIhwn8umAmz1h8h2lpIyR4Oqw72t23RQ1EHbAOboK6BQ7SAv0BrePYwyQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794610675;
	h=DKIM-Signature:MIME-Version:Subject:From:To:Date:Message-Id;
	bh=CZGWgKoiOb0WZzX9tkDAcCd5qrNdKR7L4JdHq86Y1VE=;
	b=OT5Q0sRodU2oUGifCfT9t9XUV2GhpNZdAHS4uhyQPzck1Muj7dF76NgWj3rpbNiEu24/
	 kCOn0cwNOtB7hCnHm2xdz5MF15hfOjvGNgJ3zMkL9qbvCN911iYrPxPvefhSBc5g6Ngjz
	 vp6AMg8XFTftzzrShs2jSRgntoSec2SKehan0uIGv1nLz+nLVBKFoLb3Rh0IHPgAtup7O
	 xxQ9aSGEBtEB8eyeBslRPiDQvqOK8zjutqrk70A/jyO2obiSC0RR+t8YkfgPIfTGYz9s2
	 C6YCU8vF4F+djThe3DEs52kJYhJdwuJbxtileWBBtI3qMiIehrZfmiUKIJygCopN3ig==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RA+fK3Rn;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 77C43F80495
	for <alsa-devel@alsa-project.org>; Fri, 13 Nov 2026 23:57:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77C43F80495
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RA+fK3Rn
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DDBE061DB7;
	Fri, 13 Nov 2026 22:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB071F000C4;
	Fri, 13 Nov 2026 22:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794610671;
	bh=bVjai6LLNarFx4zAm4mT7O1O9wWtA74SjHQ0do3jQHw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=RA+fK3RnOz5pKae2Gt+V1eUv8iLmqCGYaGFCSvcy0Wecqjq08FmJ+8uqrVBImUtZ0
	 GsArh4WPUccH9BmXvcTTdj6RdZgmx/85lPawLod5S/qP46c8aQRIrnFE6fRBcn0mYb
	 ydtkUk6KczDgDX5sZGB8PNr81PNCcBYJVsZGjbeqBlBPswokDyWZb0pYsA4bojU1/2
	 1pQNLSX6rGCMqqltwHmrpWbaUI4kBvKOM7Q9QaGvzaBmgPKEyPPgNbzNLNVllAjhBc
	 QObXjQjLpV5zF54Vbr4vCFSkRdZRpdUHb32q43AlhiaFxh+ILpkfjziu0rX95SrgvI
	 kIHS/kvU1zhog==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id C9CB7327EB4C;
	Fri, 13 Nov 2026 22:57:44 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1] ASoC: tas2783-sdw: Add basic BPT support
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: broonie@kernel.org, tiwai@suse.de, andriy.shevchenko@linux.intel.com,
 13916275206@139.com, alsa-devel@alsa-project.org, shenghao-ding@ti.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, k-yi@ti.com,
 henry.lo@ti.com, robinchen@ti.com, niranjan.hy@ti.com, pin-hao.huang@hp.com,
 Syed.SabaKareem@amd.com
In-Reply-To: <20261103133853.1612-1-baojun.xu@ti.com>
References: <20261103133853.1612-1-baojun.xu@ti.com>
Date: Fri, 13 Nov 2026 22:57:43 +0000
Message-Id: <179461066380.590303.4284235915024640231.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2367; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CZGWgKoiOb0WZzX9tkDAcCd5qrNdKR7L4JdHq86Y1VE=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLK+T30xj8d66vFmwXmMNVkHPn+1nb32zNKtJ8+uO7Oov
 X/Nd1WdEx2lLAxiXAyyYooscVncL+tLXq/hO7iwDWYOKxPIEAYuTgGYyEYpRoZLM+ytd72rCghm
 4vt16uNejUOHzE4sUvyu/VtvUhsn55Fwhv/JypWB0mwMGzeoq7pectVSlHq/9IX0+YznVy4LHdi
 6oooBAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Message-ID-Hash: PPL3HM4GJ543HLA2KJFILARUEMTSSIXS
X-Message-ID-Hash: PPL3HM4GJ543HLA2KJFILARUEMTSSIXS
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PPL3HM4GJ543HLA2KJFILARUEMTSSIXS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

> Add for BPT supported.

It might help to expand the acronym here, it's not at all obvious to me
what this is intended to do.

> +enum {
> +	SDW_MSG_FLAG_READ = 0,
> +	SDW_MSG_FLAG_WRITE,
> +};
> +
> +struct sdw_bpt_section {
> +	u32 addr;
> +	u32 len;
> +	u8 *buf;
> +};
> +
> +struct sdw_bpt_msg {
> +	struct sdw_bpt_section *sec;
> +	int sections;
> +	u8 dev_num;
> +	u8 flags;
> +};

These look like generic SoundWire definitons, they should come from
SoundWire headers.

> +static int tas2783_fw_download_bpt(struct tas2783_prv *tas_dev,
> +				   const struct firmware *fmw)
> +{

> +	ret = sdw_bpt_send_sync(bus, slave, &msg);

Can we call this while tas_fw_load() is waiting for the load to
complete?  That gets called from Soundwire callbacks.  There's some
Sashiko reports about the issue (and quite a bit of other stuff).

> +static bool tas2783_bpt_supported(struct tas2783_prv *tas_dev)
> +{
> +	struct sdw_slave *slave = tas_dev->sdw_peripheral;
> +	struct sdw_bus *bus = slave->bus;
> +
> +	return bus && bus->ops && bus->ops->bpt_send_async;

Does that guarantee that the bus actually has BPT, how strict is
Soundwire about not registering the same ops struct for everything and
returning an error if the hardware doesn't have the feature?

> @@ -761,7 +877,7 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
>  	if (!fmw || !fmw->data) {
>  		if (!tas_dev->fw_use_fallback) {
>  			tas_dev->fw_use_fallback = true;
> -			dev_info(tas_dev->dev,
> +			dev_dbg(tas_dev->dev,
>  				"Failed to read preferred fw binary: %s, attempting fallback binary load\n",
>  				tas_dev->rca_binaryname);

Separate patch please.

> @@ -1216,25 +1358,32 @@ static s32 tas_fw_load(struct tas2783_prv *tas_dev, struct sdw_slave *slave)
>  static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
>  {
>  	struct tas2783_prv *tas_dev = dev_get_drvdata(dev);
> +	uint val;
>  	s32 ret;
>  
>  	if (tas_dev->hw_init)
>  		return 0;
>  
> -	tas_dev->fw_dl_success = false;
> -
> -	ret = regmap_write(tas_dev->regmap, TAS2783_SW_RESET, 0x1);
> +	regmap_read(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 7), &val);
> +	dev_dbg(dev, "Got B0P0R7 = %02X with %d.", val, ret);

We removed the assignment to ret but we're logging it?

-- 
Mark Brown <broonie@kernel.org>
