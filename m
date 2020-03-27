Return-Path: <SRS0=JTem=5M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72768C43331
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:06:20 +0000 (UTC)
Received: from alsa0.perex.cz (unknown [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0651E20716
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Mar 2020 16:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0651E20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 35F5C168C;
	Fri, 27 Mar 2020 17:05:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 35F5C168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585325178;
	bh=PX+bk0SriFFOTn0IwjZDpf3jeV0MqMfr9HfMd+kK13s=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q6J3FbgglIPxH3aqlDYm/O8MxrmqocNjzKv6oy0yMeEE/BbSUcXzO4E1WLUmgF1hi
	 ZN0CGCBRSavER3wWLK6CuDAYv/hQfdImO/4nM6VRJHd3eHnBF6YpMrZXPs4QCIkts+
	 1lsukd4cbqO2kwOICriUu+UEYK2fpAxgSbj1UVp4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A400DF80147;
	Fri, 27 Mar 2020 17:05:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 37CBBF80158; Fri, 27 Mar 2020 17:05:26 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 3E83AF8011B
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2020 17:05:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3E83AF8011B
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 681441FB;
 Fri, 27 Mar 2020 09:05:17 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFAFD3F71F;
 Fri, 27 Mar 2020 09:05:16 -0700 (PDT)
Date: Fri, 27 Mar 2020 16:05:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC: Intel: add SoundWire machine driver
Message-ID: <20200327160515.GG4437@sirena.org.uk>
References: <20200325220746.29601-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Content-Disposition: inline
In-Reply-To: <20200325220746.29601-1-pierre-louis.bossart@linux.intel.com>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
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


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2020 at 05:07:42PM -0500, Pierre-Louis Bossart wrote:
> To handle multiple hardware combinations, this patchset suggests a
> single machine driver which will create and initialize dailinks
> dynamically. This allows us to support new configurations easily, as
> shown with the TigerLake rt5682 example.

This doesn't apply against current code, please check and resend.

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5+JDoACgkQJNaLcl1U
h9BrzQf9HD/oJXuENoB5jb2aCA9JJCVeucnikIjbpudw7gcNsq3eS+xFrdikJXGg
Wf+PW78bsFZ7ESbIgadR1K0uAveiCKXCtszfhcE/TTlIQgFggLk6LTztdQsjLQdr
Ml3wArrMLzyOlBg4+Zj52Xrr1WYrrzsNkApe3rHK6309CE9JhLbDaKlepit2RU44
TcweFxMrD7HGEMwAlc6yLbWNR9pBLKVN/AYSWIXbZBCMnG6kBUlUNVfyOro9I146
Yf9Gj74RJ530C0JM0mhgf6IyO8epu41jbkzDg+Nn9rw0rsNrfJAbd3rMg5Wyrypc
OON3u4p3VO1Z+f4LCuAfKSltQCsIEQ==
=m45M
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
