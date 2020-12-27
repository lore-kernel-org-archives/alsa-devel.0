Return-Path: <SRS0=ctet=F7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF4DC433DB
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Dec 2020 18:04:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AAA3208BA
	for <alsa-devel@archiver.kernel.org>; Sun, 27 Dec 2020 18:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAA3208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C276F171F;
	Sun, 27 Dec 2020 19:03:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C276F171F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609092278;
	bh=S2cgdm2rFm6hqUklBWO7sa0odDT34cun43fbSVFsvvc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mI2+QpWqUMdgdA2P5Q0a8p8cd1PPUSaZKNrcfYY5H97gAqH1j/Xx2HT8pzbp9H3nF
	 pbI3qojlgHuu82gLK+8v0/CUUAaYK7x7UbM03qqglXMXoSYkqO/esMw3pfRZIdYKnj
	 Y4EDnkAjxJVs4LdoWEDHcNIP+L1TtGGLQ5fhMG4I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58923F80085;
	Sun, 27 Dec 2020 19:03:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BFD41F8022B; Sun, 27 Dec 2020 19:03:46 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8F4A2F80085
 for <alsa-devel@alsa-project.org>; Sun, 27 Dec 2020 19:03:39 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id CC6E2A0042;
 Sun, 27 Dec 2020 19:03:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz CC6E2A0042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1609092218; bh=R6E0WUyd+HzPTBrB5WL2D70BQXuqhUQ9I4IJCZL5Yg8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=sxMzLrznPgvhLj61Ut3Spe3reCebG+bVP01QFjYEI+A5+5GFlP0e1N/PJU2Y4+LXm
 ZpMlxrDTRhOlPnzXQmbVAezr+63Wydkw67Iw700DEw0aF5Wpb+tf/4Blpfjnfg5l/x
 DMis0Oj78zn0A8SGd6HMB9Ek6cMC4FzzfACGMTJA=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Sun, 27 Dec 2020 19:03:28 +0100 (CET)
Subject: Re: [PATCH] ASoC: amd:Replacing MSI with Legacy IRQ model
To: Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>
References: <20201222115929.11222-1-Vishnuvardhanrao.Ravulapati@amd.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <9f1df5a9-f2ab-33da-3111-c01db88912b4@perex.cz>
Date: Sun, 27 Dec 2020 19:03:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201222115929.11222-1-Vishnuvardhanrao.Ravulapati@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Akshu Agrawal <akshu.agrawal@amd.com>, Mark Brown <broonie@kernel.org>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.com,
 Dan Carpenter <dan.carpenter@oracle.com>
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

Dne 22. 12. 20 v 12:59 Ravulapati Vishnu vardhan rao napsal(a):
> When we try to play and capture simultaneously we see that
> interrupts are genrated but our handler is not being acknowledged,
> After investigating further more in detail on this issue we found
> that IRQ delivery via MSI from the ACP IP is unreliable and so sometimes
> interrupt generated will not be acknowledged so MSI model shouldn't be used
> and using legacy IRQs will resolve interrupt handling issue.

What is the real culprit? It's hw bug? If not, it would be better to fix the
PCI code or the irq handler.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
