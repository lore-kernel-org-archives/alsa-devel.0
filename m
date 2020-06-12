Return-Path: <SRS0=DU/y=7Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33707C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:09:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78A1207F7
	for <alsa-devel@archiver.kernel.org>; Fri, 12 Jun 2020 08:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KIltM5E/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESWNW/5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78A1207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A053950;
	Fri, 12 Jun 2020 10:08:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A053950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591949368;
	bh=nmZwczgNTKZra6a5oxqRkjjP4HIMvclLNUKSY89o+Ww=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KIltM5E/sSdUOovN4+i+EPE8jTvOpt0NWbSF8DT8fijMUJ9rVdcqi6UH23GZBiZTX
	 p8PPwG4kcXLL1xCJdzVHqYvV6heDiYmIYRFGFSlKIi3/5gLxzewElQwHLoNzjk6fA5
	 2ujR/ew1IQIqkQxffdgXqMh9HVbrMOzeSzghnC/0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0A97F801F7;
	Fri, 12 Jun 2020 10:08:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3F3E6F8021C; Fri, 12 Jun 2020 10:08:36 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28E5EF800CC
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 10:08:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28E5EF800CC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ESWNW/5E"
Received: by mail-pf1-x443.google.com with SMTP id d66so3943688pfd.6
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2020 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=deHfCGYK7sImHkT4VukXUAJWu2KR/QGBA+6TyAj97pI=;
 b=ESWNW/5E+/g3NHeWm+fOP0obMgnb450CQdjU9D6UtJeGj3oPKXbGFuVQMzmWkRgmg9
 COtq4vJ2noq7dW4on1wypjVYXjgWHyB0fRMnV6QZ9j1FiTm00VYKKwgR7MASZKZMRyeA
 dR9T/ajdR5gD7/4IFojbFiUs4rdI1lUswID/e1U5pm2aKElj8noMcoOe4/keDRVrB6ef
 KyjJ6r7qxss1ilwRip7YdYpZw7twEqIm1eAZyvF1m+86gx9AtNA/C3e9NQOzdUmhgAcW
 qAnKk1GUYgxglmNMpsPNlxuYqzdMpn8JRXN/hty9YdAgM4jkMhKH9jTDoRFk0+GOfrG0
 xaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=deHfCGYK7sImHkT4VukXUAJWu2KR/QGBA+6TyAj97pI=;
 b=L9KTyK3rJvpUTh+OmnJ5Ur/LZ7Vs3bdIAYfdbfu8m3winSmDH/RJU8zOnpxkoe+BbI
 L1qfymWqL4bRJAzxuDbHTA13b/2OE6csfnyWAYanZS5cB7imv/KXjqXOWK+QiaAIdCpx
 eLA4LwLssv+oVWcaZIDmDCvoyJizXqwAXcRybzTCqFOjltojb1EF7uwYVahORp4sLNM2
 5BcQAgUTPN+y3epEfMiV4G9efingrHHDP+LPV0ihL91AvXpie5Ccgsyqe7r07uyCPcjM
 Mt2Gxt02fEZm175CYj3idmIT23TET+BdVFoTT+8lCjpTS+tg/7mJ0TdilADcASBW3wQp
 KHug==
X-Gm-Message-State: AOAM533P2wM2L5OFsRLqw8sQkQvrhFA6ZMpt6835oqYJNA2hxtV5O2j4
 xaPaOcGNzt5M3QRj6RpyExE=
X-Google-Smtp-Source: ABdhPJztp5H64H8nc4ALDD29MNCP1/wMgS7+B5pkRhRu2tCOBn/u6z+JZFa6hKutRRkWyc4Y2CsnqA==
X-Received: by 2002:a62:ed02:: with SMTP id u2mr10494227pfh.283.1591949306759; 
 Fri, 12 Jun 2020 01:08:26 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id m9sm5306088pfo.200.2020.06.12.01.08.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 12 Jun 2020 01:08:26 -0700 (PDT)
Date: Fri, 12 Jun 2020 01:08:17 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [RFC PATCH v3 3/4] ASoC: fsl_asrc_dma: Reuse the dma channel if
 available in Back-End
Message-ID: <20200612080817.GC22422@Asurada-Nvidia>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
 <3a79f0442cb4930c633cf72145cfe95a45b9c78e.1591947428.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a79f0442cb4930c633cf72145cfe95a45b9c78e.1591947428.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, timur@kernel.org,
 Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, lgirdwood@gmail.com, tiwai@suse.com,
 broonie@kernel.org, festevam@gmail.com
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

On Fri, Jun 12, 2020 at 03:37:50PM +0800, Shengjiu Wang wrote:
> The dma channel has been requested by Back-End cpu dai driver already.
> If fsl_asrc_dma requests dma chan with same dma:tx symlink, then
> there will be below warning with SDMA.
> 
> [   48.174236] fsl-esai-dai 2024000.esai: Cannot create DMA dma:tx symlink
> 
> So if we can reuse the dma channel of Back-End, then the issue can be
> fixed.
> 
> In order to get the dma channel which is already requested in Back-End.
> we use the exported two functions (snd_soc_lookup_component_nolocked
> and soc_component_to_pcm). If we can get the dma channel, then reuse it,
> if can't, then request a new one.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
