Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A816CA90AF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 18:04:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5F9120673
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 18:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VP67s1fW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiWEmaCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5F9120673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27CA116C2;
	Tue, 12 May 2020 20:03:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27CA116C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589306659;
	bh=hQk0S1yJ70rST/GSmYuGPqAK8UD3U8opXJDuyLeuq74=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VP67s1fWO734R4urUmgPe9+K6CwAo2M631tTiI3ORCIQE/IvKqY4DZd7NNtnG9jPL
	 vg8F7eVWauTDnCQcsyE2U02pMtHt8lMLEX55RiF1fO9hVFM6by/UbC6gBKzxPDIJNQ
	 NisHQQK5dDa3Vst7SB+toj//r/hSCf+M+XeR+tBs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 98596F80112;
	Tue, 12 May 2020 20:03:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97BE0F8014C; Tue, 12 May 2020 20:03:26 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 62C78F800E3
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 20:03:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 62C78F800E3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hiWEmaCJ"
Received: from embeddedor (unknown [189.207.59.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0872220673;
 Tue, 12 May 2020 18:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589306600;
 bh=hQk0S1yJ70rST/GSmYuGPqAK8UD3U8opXJDuyLeuq74=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hiWEmaCJxtteCzKgEpk3ScqKypcslzHaJKpzXPTM/myPshzlMocgTDf34jV4wxzqC
 cZIVwNGpcaco49PyjLp0F3iZGxx809hXuzCQ+oO/RPh11XIl8fIaOEu6V8EFKOvM2e
 Q8zk76DxQHfy1zdcSh3DKPYLqbJF56FTPRKsLpW0=
Date: Tue, 12 May 2020 13:07:54 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ALSA: Replace zero-length array with flexible-array
Message-ID: <20200512180754.GE4897@embeddedor>
References: <20200507192223.GA16335@embeddedor> <s5ha72j32sh.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5ha72j32sh.wl-tiwai@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>
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

On Thu, May 07, 2020 at 10:31:26PM +0200, Takashi Iwai wrote:
> On Thu, 07 May 2020 21:22:23 +0200,
> Gustavo A. R. Silva wrote:
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks, applied now to for-next branch.
> 

Thanks, Takashi.

--
Gustavo
