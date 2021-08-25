Return-Path: <SRS0=JRP5=NQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA9FC4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 10:28:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA02961184
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Aug 2021 10:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA02961184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0684F846;
	Wed, 25 Aug 2021 12:27:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0684F846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629887307;
	bh=/dGcdnDJQSuikSxYpLybghGo6DeDQ9TcuR3g7ByXcx8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fWyzKC6o6t2Ni0VSwr+y0Q4qtBeHPHLwbFOoobYQhto8oxp2bgbbCYJ8m31dHwIUm
	 h3aAJtaWCYx5nLKa4oGq5kAR4rN+aMslqtLm0MEn8HBRStZTdwHa73FEzIwjBw457f
	 2iuyvvkZrwwygrsmGb4z7LW4LBn72QEp4Sfob7+o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 934D6F8003C;
	Wed, 25 Aug 2021 12:27:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BA135F8020C; Wed, 25 Aug 2021 12:27:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64BBAF8003C
 for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2021 12:27:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64BBAF8003C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="YzQfIITY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14E3161212;
 Wed, 25 Aug 2021 10:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629887249;
 bh=/dGcdnDJQSuikSxYpLybghGo6DeDQ9TcuR3g7ByXcx8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YzQfIITYt+EvmJkw15OcJ5ISgWzmfAAa9l1OY26UMXJYFyuibz1c+h+8Mk1FZCuHQ
 kAJTQSl0ONbTNT/9lrv6hzN6QhLVWUwE815h7VOrCdY8YvCWgS3u1bctTLujiM8iyu
 M2sRBLq78Vru85NB9m3LEF3gSubrENg5UHN8Qhq244f/WJpBeL5APGDRjTizsqga+P
 R+am+zkLRFhNBWRZjsjF1VkOahqzMZZHXYrgTUgbynHQ0MUTdn3jtNfP6dJ5fNKPOR
 2OS8+sxjO8jOeELe4bpM0maGGU4KaC22/bulQY5Ka345TX0/+psJIL/4XIVTsRsbp1
 lpZrdGca7ZZAQ==
Date: Wed, 25 Aug 2021 11:27:01 +0100
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Use 'enum' instead of 'oneOf' plus 'const'
 entries
Message-ID: <20210825102701.GB5186@sirena.org.uk>
References: <20210824202014.978922-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <20210824202014.978922-1-robh@kernel.org>
X-Cookie: MY income is ALL disposable!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Vignesh R <vigneshr@ti.com>,
 linux-pci@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-phy@lists.infradead.org, Lee Jones <lee.jones@linaro.org>,
 Marc Zyngier <maz@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Kishon Vijay Abraham I <kishon@ti.com>, linux-serial@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmaengine@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 24, 2021 at 03:20:14PM -0500, Rob Herring wrote:

> 'enum' is equivalent to 'oneOf' with a list of 'const' entries, but 'enum'
> is more concise and yields better error messages.

Acked-by: Mark Brown <broonie@kernel.org>

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmEmGvUACgkQJNaLcl1U
h9AfCwf/TPAwmd3i8vLyV5kU4MWAOn8zovhbZ+gXG2hJek5nLRjdW7eTl2yXz1gx
xdOp2MMA5ldnXUjncRKHMJYykdL7ZtEsOUWT44WgHT0h1WEQzTHSnoVgkt/DDbsP
tuovH5NV986VPCJXIC+mBkt5a4MPzdD1nYVmPss+8R+HXfTRZauTlZefXvwCzNDT
Md/IxPvIbcqw5Ks12P4kdojbEGB92MONTO3vRYkzCeY1toRL9fOY3DJE30Kd6o3+
hzCYzeRkTgoibpK8oG+ZqMOJ38/shj8Wiyfovdhd7LOj9orgkbGdGRi10R1997IR
tDWFSsOVWZ8p+r2ZuI06T7GlVjygag==
=GpUP
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--
