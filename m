Return-Path: <SRS0=EqiG=CR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2C5C433E2
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:31:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC1E21D93
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="s8bJ47NG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXCSd7t5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC1E21D93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F0531729;
	Tue,  8 Sep 2020 14:30:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F0531729
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599568309;
	bh=LCVrNQR0n6xhi0XBZwi5U5vpkEB09Qnglc31/QkieYY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s8bJ47NGWv5yUamZUXwbPRUJlS5kn+aRAYWEXAM+b7AF9x/1vtEr4O4pWc89T9l5G
	 JiYA9Fp2C8qwUBEt/nuA869dvZKU3frrCPvwILniKUb4NQ5nMv0XZWrQ78olOVrRGr
	 ECX8FBYBmQfNyJ4mDCslLjcbg9tOeywlnRbtAvok=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4A3DF8015F;
	Tue,  8 Sep 2020 14:30:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C637F8026F; Tue,  8 Sep 2020 14:30:58 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB6E2F8015F
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2020 14:30:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB6E2F8015F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="DXCSd7t5"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E58DB20757;
 Tue,  8 Sep 2020 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599568244;
 bh=LCVrNQR0n6xhi0XBZwi5U5vpkEB09Qnglc31/QkieYY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DXCSd7t5qrdH9m1+fHgrswDu7ZjOP5DBBxLFjMNaquYzAPaptSWyAQX3DMmAYnnJd
 DY8JMPb8cajDuqwfvfmIi98Tya65Sgy0eNNhrvWp1YTumS7V4KvGatBXZBCABpZlSc
 9TgJLrrTI6V6SX6nl+3kmQ3l7Dy6mTZJ2BJW6mUQ=
Date: Tue, 8 Sep 2020 13:30:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v3 0/3] ASoC: Add sdw stream operations to dailink ops.
Message-ID: <20200908123000.GB5551@sirena.org.uk>
References: <20200904182854.3944-1-yung-chuan.liao@linux.intel.com>
 <46f44acb-7d4b-965c-a6e2-98a4da79e6cc@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <46f44acb-7d4b-965c-a6e2-98a4da79e6cc@perex.cz>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com,
 linux-kernel@vger.kernel.org, hui.wang@canonical.com, vkoul@kernel.org,
 srinivas.kandagatla@linaro.org, ranjani.sridharan@linux.intel.com,
 jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>, rander.wang@linux.intel.com,
 bard.liao@intel.com
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


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 08, 2020 at 02:26:14PM +0200, Jaroslav Kysela wrote:

>   "[PATCH v2 0/4] soundwire: Remove sdw stream operations from Intel" and
> cannot be used standalone. I believe that one maintainer should accept it or
> there should be a co-ordination between Mark and Vinod to push this in sync.
> We should really settle, how to accept such changes. I believe that Vinod
> should take it with the ack from Mark for this case. Please, don't require to
> split changes which depends on each other.

Or just tag the bit from Soundwire that needs to be shared so I can pull
it in which is the more usual way to handle this sort of thing.

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9XeUcACgkQJNaLcl1U
h9AAhAf8Cv4OT4BdkRuxqIJ/Qar6kTiZLfYGNEOoPVZNRwbCufv0AHEr6lJUzJ27
AgXDTxC3dpvdMa1thezGg21uizwh54Z2eItpFBgQ8vjPCfBYTpZJalkWFHYpQhd9
xsmY1SfHOJvwE9cOVCiXnKcunwMMd59b8Djn8G+AQjkzBByq8yEKBqWLjgDi559m
/oIRmt8i+WC1eDIjuLTW2bVjwdr49V8B1101ru4D0L8xsaRywHon0ovrzsFj2FvQ
yg9o0NSgdPCDvPdSKxrm8gUoS5Xwww5wNhY6bcITuuPTa52EnN0q+VUdN7hTJC1B
56LjFe1YSYeLxlIlxsb/STxUYRPVrA==
=oa2A
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
