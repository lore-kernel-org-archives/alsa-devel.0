Return-Path: <SRS0=FWLr=6Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE9CC47255
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 06:17:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0258E2080C
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 06:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MddJrjPk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+ZaYDS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0258E2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 582491669;
	Mon, 11 May 2020 08:17:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 582491669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589177873;
	bh=TUadx5+SdYwVic4bSA5yBIVqyqRRvQup0KvV521JFXg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MddJrjPkCVUwUzq4dU8cxavqH8B+xMEYAVKSqE6lS/u8g2SKyYSU3ImMbXPbGxFnQ
	 A+Dlveww9Du4G4IY5KVeoQ6RIMzbXdFhDnOOcxJLIsrOCnWWEr486oyFaJCMiWbN/0
	 1red6wbI6m5xmdDySDGrT68ji/YkyAA3wktQ/zXw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AEFB2F80291;
	Mon, 11 May 2020 08:16:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A12BAF8028F; Mon, 11 May 2020 08:16:16 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 221A0F8027B;
 Mon, 11 May 2020 08:16:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 221A0F8027B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="s+ZaYDS8"
Received: from localhost (unknown [122.167.117.121])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C77FD20708;
 Mon, 11 May 2020 06:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589177771;
 bh=TUadx5+SdYwVic4bSA5yBIVqyqRRvQup0KvV521JFXg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=s+ZaYDS8wOfqr0hM/ykcSMOYRGotOPhALdDgtGrlrv09b4ZtqZUIdGdDmH5RsFoMH
 +ltxE9M/hXo2aIVfd5jowOufuWGl9oErvOoVnSQgEQL74J0WARdJPp5vh+LudQht+a
 utFwW28GlAlchqxeyoUwrso5s1ewKssC/BHAnGEY=
Date: Mon, 11 May 2020 11:46:07 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [PATCH v2 0/2] soundwire: remove multiple superfluous "else"
 statements
Message-ID: <20200511061607.GR1375924@vkoul-mobl>
References: <20200508003046.23162-1-guennadi.liakhovetski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508003046.23162-1-guennadi.liakhovetski@linux.intel.com>
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 sound-open-firmware@alsa-project.org
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

On 08-05-20, 02:30, Guennadi Liakhovetski wrote:
> Two patches cleaning up the same issue for soundwire core and Intel-
> specific code.

Applied, thanks

-- 
~Vinod
