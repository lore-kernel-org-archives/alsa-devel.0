Return-Path: <SRS0=3aoS=6E=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BCFC3815B
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 07:10:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1C89206E9
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2020 07:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ALhsnXKs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v+NqI280"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C89206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C0FF9F6;
	Mon, 20 Apr 2020 09:09:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C0FF9F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587366631;
	bh=UWEF8anj4RInPM8cOzySci9CGjDHuS3EH9QM7a51Be8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ALhsnXKsM4oLu533mpaxXgQ7gmbht4NRg32QvHkF/o7am/EdeJPysBOr1b8ykvs2K
	 9XUtcu3pcd4Sl0sffk8gOQ4f/gkDdrDN1dbsyZmZ9ce0Q1ng5u8Ui1noxv4GTt5VcJ
	 /2CfLz+1cYWbHh9Qa42qLFbkFiKEotMkUU9BdGTQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0307FF80292;
	Mon, 20 Apr 2020 09:08:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D003AF80292; Mon, 20 Apr 2020 09:08:35 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7296BF8028F
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2020 09:08:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7296BF8028F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="v+NqI280"
Received: from localhost (unknown [171.61.106.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 68B9021473;
 Mon, 20 Apr 2020 07:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587366503;
 bh=UWEF8anj4RInPM8cOzySci9CGjDHuS3EH9QM7a51Be8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=v+NqI280vQ0VCqH7CFazIGBoespfaQ5HGIU7y9J2GNVY4lMAUOyBbvpPX3sSXWXgy
 uEPdiyzLVxLSdJwO3fphUYn1lb3EWyd1q11gtKxizOmm0jXTOZjpgZJUBHLrYpwqA8
 ZZ7+VyedZzVd8OfTl+41EHEJVHcbrsQlXlIMDMkE=
Date: Mon, 20 Apr 2020 12:38:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] soundwire: intel: use asoc_rtd_to_cpu() /
 asoc_rtd_to_codec() macro for DAI pointer
Message-ID: <20200420070816.GU72691@vkoul-mobl>
References: <87y2qqvdxu.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2qqvdxu.wl-kuninori.morimoto.gx@renesas.com>
Cc: linux-kernel@vger.kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>,
 Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On 20-04-20, 16:01, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Now ALSA SoC needs to use asoc_rtd_to_codec(),
> otherwise, it will be compile error.

Applied, thanks

-- 
~Vinod
