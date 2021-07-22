Return-Path: <SRS0=+9Uh=MO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0AAC6377D
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 14:15:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC80961244
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Jul 2021 14:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC80961244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F75416D3;
	Thu, 22 Jul 2021 16:14:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F75416D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626963321;
	bh=h9bt+2ABEwbCJSPYIOdamsWRy7Ya4biD/RS9Mrg+ThA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QTQECwBHpX7LdD5EGcX5OlWtGzm9NekzwFZJ8IjrBeNHWGBCM9XKNd90ARKT7ccqd
	 Bd/4Njyiq2jcTWVedw46lhjcFinwXAVkCv2GNay52S18zpaT6Zb1AArnYs4N7qe2lS
	 LkeffG+DDQDbN6PwkTe9AJzH2mozM+MIbMWpkIo4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28447F800DA;
	Thu, 22 Jul 2021 16:14:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2A02F80227; Thu, 22 Jul 2021 16:14:29 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B58FAF800DA
 for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2021 16:14:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B58FAF800DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="c+k9lvOj"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02759613AE;
 Thu, 22 Jul 2021 14:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626963260;
 bh=h9bt+2ABEwbCJSPYIOdamsWRy7Ya4biD/RS9Mrg+ThA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c+k9lvOj8/tIhhVZxZjWNi85TGPheT0wf4+cGKHGDQAb34O1JCu3o8oamx+y4HL6o
 XaVstbjEumdqXmg2wfldglQibzJG337VQ3qpRfFEKIOf1RnCuAA0+4oK/bGW4mH906
 oefHSWy18njvPGRK7YjDgJlH8mYMouk8nfvvX2BDP5yr6MZCFTGZCtG4YMhW2e1/uR
 Dt4WfHs8l0XpC3fr6K/fcIByUdVp67EXnfUUtKRB4fL+HDCxer8xOu/JYYebGEiwAy
 1u4FQ/OfVh9JF+kmP0FWn2PYkxYornAZ6lkritSHYanbBHKJ6e0rASuQpQOG9j9n9S
 T1I3/IIS207yA==
Date: Thu, 22 Jul 2021 19:44:16 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH] soundwire: dmi-quirks: add ull suffix for SoundWire _ADR
 values
Message-ID: <YPl9ONsFv+3NeSfd@matsya>
References: <20210714013027.17022-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714013027.17022-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
 pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

On 14-07-21, 09:30, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Sparse throws the following type of warnings:
> 
> drivers/soundwire/dmi-quirks.c:25:17: error: constant
> 0x000010025D070100 is so big it is long
> 
> Let's add the 'ull' suffix to make this go away and find real issues.

Applied, thanks

-- 
~Vinod
