Return-Path: <SRS0=2rKR=B6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B38C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2020 09:12:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DA7A2078D
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2020 09:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nq5c0dy4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="O2gktr8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA7A2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 032741674;
	Thu, 20 Aug 2020 11:11:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 032741674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597914760;
	bh=yclwfo55MX13YgRaQ8Wncbaswr3O8v5V7ekoMGHWdFQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nq5c0dy4SPlOdvTnIEP6pAUPVmK0xOyuD1IDDJgv+ofX09apbrJxSi28eK1XVz2qt
	 21Evu/m0tjsjqWARIA7U7ocBzcK8hFaT98ZV/hvIhF9rWeyKU0u5rehlGJMGb1r4rO
	 ap+zDHQNjmRm55/lo1hxqTNCc3OhK309Cu2b2H7Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 801F9F801F9;
	Thu, 20 Aug 2020 11:11:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 598DBF801F9; Thu, 20 Aug 2020 11:11:48 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6A36F801F9
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2020 11:11:35 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id DB575A0042;
 Thu, 20 Aug 2020 11:11:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz DB575A0042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1597914694; bh=iTmp4BF+lZP6U6m2bKdzx1zFmjtxlbE692na34Cb5vE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=O2gktr8uUizDszVPc7ROoon+ulFs+hn4zFaoYrBSlfHITVJtHuASG+hoVjySewBu1
 EV7cnJvgPVm84zwMr0mFQfJ11SqINxTgnSdSD/UjFCjfhp7TBgJcB7XCdUGvnVNrEn
 T+RArMON31tpURYBxDELp8NFrJ94JE6mgok9oWuU=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Thu, 20 Aug 2020 11:11:27 +0200 (CEST)
Subject: Re: [RESEND] ASoC: SOF: Intel: add build support for SoundWire
To: Bard Liao <yung-chuan.liao@linux.intel.com>, broonie@kernel.org,
 tiwai@suse.de
References: <20200819124429.3785-1-yung-chuan.liao@linux.intel.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <5db411e9-2dba-fe5e-f200-9f5e05410007@perex.cz>
Date: Thu, 20 Aug 2020 11:11:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819124429.3785-1-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: vkoul@kernel.org, alsa-devel@alsa-project.org, bard.liao@intel.com,
 pierre-louis.bossart@linux.intel.com
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

Dne 19. 08. 20 v 14:44 Bard Liao napsal(a):
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Select SoundWire capabilities on newer Intel platforms, starting with
> CannonLake/CoffeeLake/CometLake.
> 
> As done for HDaudio, the SoundWire link is an opt-in capability. We
> explicitly test for ACPI to avoid warnings on unmet dependencies on
> the SoundWire side.

Can we enable SDW/SOF also for the 5.8 stable kernel or some vital pieces are
missing in 5.8?

If I am not wrong, it's a 5.9 patch, right?

				Thank you,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
