Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62A5C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 13:03:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1566861930
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 13:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1566861930
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41D5F167A;
	Mon, 22 Mar 2021 14:02:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41D5F167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616418210;
	bh=3FwD+iGdMY6tDr9Btv3T+UB2LLTX6/F6BH6nIYPTdZw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kdkiOWiDr4B1YUAvbQwAfWZvojMWeWvxwdaj7vuMDQ23zAWm0EN6/xGLnJYzqYO+8
	 Kqmp6wQ8hreVdxSenM6p/mkeAnBtNeI5C6cY20NufWRUo+tOEdm1DwTAVj+B7jbCAh
	 6dYIvhj6E7gqX8Yz0Prl+5jrjL+9x9CNV0NYrHBQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1779FF804A9;
	Mon, 22 Mar 2021 14:01:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0CAAAF804AA; Mon, 22 Mar 2021 14:01:22 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7796EF8049C
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 14:01:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7796EF8049C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qQRyNER9"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B88661931;
 Mon, 22 Mar 2021 13:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616418073;
 bh=3FwD+iGdMY6tDr9Btv3T+UB2LLTX6/F6BH6nIYPTdZw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qQRyNER9d/VX0hx58Ntm+5Do9XbEi9VUlrAh3B1efx+JxfKFgrL/zaMOSV11lMduY
 Tjy6ufaLZCOXItsyiMApliRuZOG8lPe6RpKgyWbLaWfgLWE/ig9YCbgk6QRxwHn0Rd
 0k0YIB5sLdhFexm6zDbkt6KAhx9yHLMnngy1KJFD63qAs3inLYvZGVGVhLXPALw7jN
 osXDCMgqIooqZzB2BNa5Mi1Qc+YO9kwYgUSTcstuoFuuMfvEAEVf3vsotTSqtzBgb/
 90IyKCtYvoCgqXo3BqnPOq71GRRQKmF0SVkZfbKUgZuOENhXTQiCNJrrPxY3u17h2A
 ClFcEPtZf6EDg==
Date: Mon, 22 Mar 2021 13:01:07 +0000
From: Mark Brown <broonie@kernel.org>
To: derek.fang@realtek.com
Subject: Re: [PATCH 1/2] ASoC: rt5682: Add a mclk name property to the device
 tree
Message-ID: <20210322130107.GC4681@sirena.org.uk>
References: <20210322124706.17303-1-derek.fang@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <20210322124706.17303-1-derek.fang@realtek.com>
X-Cookie: A friend in need is a pest indeed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, lgirdwood@gmail.com, "derek.fang" <derek@realtek.com>,
 shumingf@realtek.com, flove@realtek.com
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


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 22, 2021 at 08:47:05PM +0800, derek.fang@realtek.com wrote:

> +- realtek,mclk-name : Specify the mclk name that codec uses as clock provider.

This is really non-idiomatic interface design for the device tree (or
anything really) - the names for the clocks are defined at the device
scope, it doesn't make sense to have a property like this.

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmBYlRIACgkQJNaLcl1U
h9BLfQf+L7jG4wM7HgLIIwBVtJNU0+zd1k3tiByax/G8cWZf2Qw7hpo2HNS1m5/b
5ac+ZAsoJch/PpEj0dw1fT2nmXh/O5W8za7irosFtmkz3sf1CL/qa4hQY1uBBBfC
CNkkJu/o/zEerejzDMNXclbEaoK306wCTFHtbKHTZKHPFbNrt8Fx7VoYTrAP0hHn
NgV7n5nBxZoxjIqnhlm0XjW4I5NrgYc/Q6V7hsioS5ju+O17uNPTtQd+yhHF4RfP
0qlRzg3GqSceQfBX0DaaQLC6wPGMbxtRfcZ9fe1dvKEXKuOF8K5UJ0yOPJUkVeUy
TTPTu6k5a7y7FGr2FP0jaz8VGpxgJg==
=GxoQ
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
