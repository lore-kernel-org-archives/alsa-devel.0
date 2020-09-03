Return-Path: <SRS0=NgmJ=CM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB89AC43461
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:46:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614E320709
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Sep 2020 20:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WHvklEcV";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="b7HKGFwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614E320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED12A1AD7;
	Thu,  3 Sep 2020 22:45:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED12A1AD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599165981;
	bh=3ShBjho57CyBCDaFiR0VcVrnZD03FaczjRtG1DNCDLI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WHvklEcVeWJ1OTvN0TxcB4FXrjex4Jrrsblr+uvO542DEyvUZBkaOn3qEq1Q3F5vH
	 +CUS6EwUcyC+cnvAzGBykt/RDzPgl8RqHJAQKxngLzKbfTBnYzliX3aenxwEYkxi4D
	 ou9osYG/3Gzvl00iZR+8jfbhrP9906Fbeg9qsyC0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05433F80278;
	Thu,  3 Sep 2020 22:42:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C7EEF80278; Thu,  3 Sep 2020 22:42:46 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF1B6F802A1
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2020 22:42:34 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 3A3A2A0040;
 Thu,  3 Sep 2020 22:42:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 3A3A2A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1599165754; bh=6Lq8gDffFAHde2eBuFGDiBaW+gW4wRjspkIWhTbOU2M=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=b7HKGFwUNccL8rWMTMU2xiZf3jL852uaJMH4UPMRmkFoIPtetiVwnAe3kkUUjmc9d
 8GByfamDUpTQr045p4uQEP2DRC50XmAvAOiIK4Y/JdpquKMLg39O2rFFCMVhmmMOZF
 xISD4NmVQmnHADY4KXQbnKbX2JeLw1241m8co0cM=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Thu,  3 Sep 2020 22:42:30 +0200 (CEST)
Subject: Re: [RFC PATCH 0/3] alsa-lib/ASoC: use inclusive language for
 bclk/fsync/topology
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org
References: <20200903201024.1109914-1-pierre-louis.bossart@linux.intel.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <cac824a4-3882-85dd-dc0b-8366090dce94@perex.cz>
Date: Thu, 3 Sep 2020 22:42:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903201024.1109914-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, broonie@kernel.org
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

Dne 03. 09. 20 v 22:10 Pierre-Louis Bossart napsal(a):
> The SOF (Sound Open Firmware) tree contains a lot of references in
> topology files to 'codec_slave'/'codec_master' terms, which in turn
> come from alsa-lib and ALSA/ASoC topology support at the kernel
> level. These terms are no longer compatible with the guidelines
> adopted by the kernel community [1] and need to change in
> backwards-compatible ways.
> 
> The main/secondary terms typically suggested in guidelines don't mean
> anything for clocks, this patchset suggests instead the use of
> 'provider' and 'follower' terms, with the 'codec' prefix kept to make
> it clear that the codec is the reference. The CM/CF suffixes are also
> replaced by CP/CF.

Only my 2 cents: It's just another word combo. See bellow for sources for others.

I would prefer probably provider/consumer . It sounds more technic.

[1] https://en.wikipedia.org/wiki/Master/slave_(technology)
[2]
https://www.zdnet.com/article/linux-team-approves-new-terminology-bans-terms-like-blacklist-and-slave/

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
