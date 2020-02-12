Return-Path: <SRS0=nhcg=4A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3F1C2BA83
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:01:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9CFE2082F
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Feb 2020 12:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KvdJyPmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9CFE2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17B081673;
	Wed, 12 Feb 2020 13:00:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17B081673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581508890;
	bh=T2SFg8Fmxo3dr+hSWip0rESQdKhpf+bORRjk+wfjslI=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KvdJyPmR0mCim8GXEleaTfZzY8+Y3L6a95ogdh8hHTAk0WUN5otTlZ1M+zUV1wbeA
	 W6/cHtoWmRDdLKYNKE2SmbEUV3XBXVWa0Sd1sXNaOs+63m+qOUVsCfZU6Hw2uA5p5H
	 A5/IoJ8By1z5i5XbFMVm/GCD8C61BBpRX+1IaXxI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AF7DEF80157;
	Wed, 12 Feb 2020 13:00:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 56473F8019B; Wed, 12 Feb 2020 13:00:38 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 89F45F80125
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2020 13:00:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89F45F80125
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DAEE30E;
 Wed, 12 Feb 2020 04:00:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A54FF3F6CF;
 Wed, 12 Feb 2020 04:00:33 -0800 (PST)
Date: Wed, 12 Feb 2020 12:00:32 +0000
From: Mark Brown <broonie@kernel.org>
To: vishnu <vravulap@amd.com>
Message-ID: <20200212120032.GD4028@sirena.org.uk>
References: <1581426768-8937-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20200211153847.GK4543@sirena.org.uk>
 <c4b900ee-743e-8ce0-1061-02c383bff90e@amd.com>
MIME-Version: 1.0
In-Reply-To: <c4b900ee-743e-8ce0-1061-02c383bff90e@amd.com>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Alexander.Deucher@amd.com, Wei Yongjun <weiyongjun1@huawei.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
 Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
 Colin Ian King <colin.king@canonical.com>,
 Akshu Agrawal <akshu.agrawal@amd.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: amd: Buffer Size instead of MAX
	Buffer
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
Content-Type: multipart/mixed; boundary="===============0829664518007658358=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============0829664518007658358==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Content-Disposition: inline


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2020 at 02:36:32PM +0530, vishnu wrote:

> prior to this fix the value in Tx/Rx Ring Buffer Size register
> ACP_BT_TX_RINGBUFSIZE,ACP_BT_RX_RINGBUFSIZE and same in I2S RINGBUFSIZE
> registers was statically set to maximum which is wrong.
> Buffer size must be equal to actual allocated.

OK, makes sense - this is the sort of thing which should have been in
the commit message.

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5D6N8ACgkQJNaLcl1U
h9DZiQf/dWgDV9LNXeiT35fpCE0NNPfQAot1I/qWDk4lx8xnWZkk7Yst9HKWTZ45
5QMT35X8ffIrVDWwbiIWfN+ba+z89OhY5vInIfxYQQ4iRJXnOVEwN4LaCub00Iq+
XfO+f5Y0nB7aQEFeMWFC1mduSg2uGNK7+p4AXhXVI33tfl2uJhzIM7vRhdMW1+9F
SxZhZAT3SZaUwbHD3QE35wGSZvxM+902oXYLMsac9USfVNj2DjcUNvU0xXHE6p25
XES2+b++z6ihK9p4ZggZ0mSLdRwLMGatIWdXLrNvU6EQlJeAFM623z7cyskVWBEp
IpgjwHZYEkN85PbpOutNNmEaCljHEA==
=Bcit
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--

--===============0829664518007658358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0829664518007658358==--
