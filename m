Return-Path: <SRS0=v73L=ZE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7523C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:11:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7A2222BD
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 17:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fbVX+3fn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="WBmZhaH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7A2222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17717820;
	Tue, 12 Nov 2019 18:10:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17717820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573578683;
	bh=ypPLL6jZVgoypgdJSQPQETK2rXuL9npMKM9hQq+pUuA=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fbVX+3fn5ug9EMCJ45nwVw0jOhN68Ych3LMV1/JXrBPgDLO4GoCPF1tq4g+6TdReO
	 pBeRD/i6M6pTwSgI6r4e/ceZ4YBc48GL/pticHdBv7F2KqpzIvMWewGYLajk1kazN8
	 Vi8ZSTJfIpSnymYJEXiFIkPQQaQ3Jxu5K3fltBnM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E374F8044C;
	Tue, 12 Nov 2019 18:10:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69D06F80275; Tue, 12 Nov 2019 18:10:30 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BAED3F80275;
 Tue, 12 Nov 2019 18:10:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BAED3F80275
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="WBmZhaH1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7JNGPJT9pRp5AEvMCpQVqADewzMJP/LYO8F+yPQ5RBc=; b=WBmZhaH1HsqqS5zrrCFWQNoQu
 TbyjhFc9QkckLFm2FhZ1IUIvRiBk4fkadEpaP5auB2wWIHXx3YCYbO2EdjZgx+MqhHwB3cGluQEjh
 jF2FnT9tegPahOIU0ZFlmzb3lSBHAQexyD6ek+m7rXkSk09gRY3pDBirZCLuu5u9lnBaQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iUZgN-0008Hu-Bi; Tue, 12 Nov 2019 17:10:23 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id CB5C3274299F; Tue, 12 Nov 2019 17:10:22 +0000 (GMT)
Date: Tue, 12 Nov 2019 17:10:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Pawel Harlozinski <pawel.harlozinski@linux.intel.com>
Message-ID: <20191112171022.GG5195@sirena.co.uk>
References: <20191112130237.10141-1-pawel.harlozinski@linux.intel.com>
 <20191112130237.10141-2-pawel.harlozinski@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191112130237.10141-2-pawel.harlozinski@linux.intel.com>
X-Cookie: As famous as the unknown soldier.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: pierre-louis.bossart@linux.intel.com, cezary.rojewski@intel.com,
 patch@alsa-project.org, tiwai@suse.de, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com
Subject: Re: [alsa-devel] [PATCH] ASoC: rt274: Disable jack report IRQ with
	disabling jack
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
Content-Type: multipart/mixed; boundary="===============1957076352255555366=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============1957076352255555366==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XRI2XbIfl/05pQwm"
Content-Disposition: inline


--XRI2XbIfl/05pQwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 12, 2019 at 02:02:37PM +0100, Pawel Harlozinski wrote:

>  		/* Disable jack detection */
>  		regmap_update_bits(rt274->regmap, RT274_EAPD_GPIO_IRQ_CTRL,
>  					RT274_IRQ_EN, RT274_IRQ_DIS);
> -
> +		disable_irq(rt274->i2c->irq);
>  		return 0;

Shouldn't the register update above be suppressing interrupts?
disable_irq() is a bit of a hammer and interferes with things like
possible share use.

--XRI2XbIfl/05pQwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3K530ACgkQJNaLcl1U
h9CwWwgAhS3plSjsqeYlanJ3/ZFSPXcrRHTGI0bdSH5Zpm+asi9FBlHdCPSmJyFl
LacRk8AN90ZjWNbX66To1e7reshSYtU+XUM0OggNCfpH24WI+K9Ri4oppZRymzG5
uO9r4lvmRPWvNfs6HUX6IUq0MeTjx9rJpd6v37F1symr/Ye3yHNDVLP3vZxRiYBD
0agc8Vlq2sZRAophKmcJyeCvuM+YWToElcq4a083GMt7VO+t4tINnnCfP8VaWRBS
za6ckkCTTfzb9X/l5x/iuZBQ3bhf8mgT29hNWiliNGV2vuGBf+56hzfAvTMsH2EK
BwgWL4NC3mK67bb2PWxztA2MkREpZQ==
=KFhn
-----END PGP SIGNATURE-----

--XRI2XbIfl/05pQwm--

--===============1957076352255555366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1957076352255555366==--
