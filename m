Return-Path: <SRS0=evnw=K6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FBFC47083
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 11:09:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3C161421
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Jun 2021 11:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3C161421
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC2A81713;
	Fri,  4 Jun 2021 13:08:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC2A81713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622804986;
	bh=fiAswCz7bY8QqnhC2dCnlVm3Zt7dlksscUAYizplLdA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gZwpWxRS9L+aOJ1WL5Jkx38dl/unUKK/S2W+ulN6YpT1GF3B5IVdVqFGOu9p+K0WA
	 GJquWwCDFBuv98drRPCtdjPHoHnLPr4Sbd2xzJaP6dClYWk+INgqbrzM6HTN0+wvIC
	 tEkCJDAhGa7TUvYUoBE1zO4lyGgOT9yfKQf0yTNY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B1D5F802A9;
	Fri,  4 Jun 2021 13:08:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F89BF802C4; Fri,  4 Jun 2021 13:08:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9EA0F80103
 for <alsa-devel@alsa-project.org>; Fri,  4 Jun 2021 13:08:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9EA0F80103
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="MoUsvpX1"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8B2F61412;
 Fri,  4 Jun 2021 11:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622804918;
 bh=fiAswCz7bY8QqnhC2dCnlVm3Zt7dlksscUAYizplLdA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MoUsvpX1FYOVqEKIzygu/YNPtDqIL9SBN/0H81SpM3I+SlGXp90IlbpJ/D1lBvRvr
 Dhgc8crnrijjaTSgTipFewovNXolk1sd/7BYcIRqQXslkgpueY306Z32j9KZO3ZHTH
 FO2Xf2KD9pdlXyVimGCkY8kfNMYbxsGq+pNp2maVJqADhglMvvMODzeQpz7fCd59qz
 ZW1qHmtkO23fRpnIlYEkqZjKGhoYndZ2Ar+v2b0eTCsmq1a0f95js7NMHsfqFqr6ju
 BhlBJsCSyjaQ4xxaZoBEIFxveGDIiAMykAeYYD5MEI/f8OFtqOXkVbMH8MdSpcO0NW
 0VmdwvsgYOHNA==
Date: Fri, 4 Jun 2021 12:08:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5682: Fix the fast discharge for headset
 unplugging  in soundwire mode
Message-ID: <20210604110826.GA4045@sirena.org.uk>
References: <20210604063150.29925-1-oder_chiou@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20210604063150.29925-1-oder_chiou@realtek.com>
X-Cookie: There is a fly on your nose.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: libin.yang@intel.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, sathya.prakash.m.r@intel.com, derek.fang@realtek.com,
 bard.liao@intel.com, shumingf@realtek.com, flove@realtek.com
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


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 04, 2021 at 02:31:50PM +0800, Oder Chiou wrote:
> Based on ("5a15cd7fce20b1fd4aece6a0240e2b58cd6a225d"), the setting also

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC6CakACgkQJNaLcl1U
h9AEtgf+KVs4zni01qsAuPcpttENVpAd+JKS6wk7fZg3rFiDJzPrVdWyviDouzdf
bnhnn3+iRMW+XRKT6wvxldOlnZYf0GZU6fs2blentzc/8iATQKOnk2tCyiOJxXVU
rU67soK1F545js/GCyADpq+aTooj7npbBDO5DaV0VLoKu7gzbI7mauPVHTCjWOsn
B8URI0BuIIaDi/QTNAwJdq/WzwxmyKSUQuizbBSgb5cJzZbbZl392tiZ+y6eu3dU
r1frQpe9E8QOUI8iidduUjayk03lHe9MNSbDPDQb27TCaTIl+kp9lovzqTr/erWE
E0bo3mCOX9dIpRqru6AJGM30VmM6KQ==
=DnZZ
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
