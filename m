Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9168C2D0A3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:13:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C6522370
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pAXLQvLM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C6522370
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ladisch.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9425D169D;
	Tue,  3 Nov 2020 17:12:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9425D169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604420012;
	bh=ZAwy1SyCHUV+1HTbl2YK9B/0PuANQqx/C+z/bSEyiwM=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pAXLQvLMH6ohRvi8+nsiqXp9o1Yrezs0VuVciyIIKBhwQZzdymRNCLJQ4pyXmTcKZ
	 cOf+KSPcEclVV8RT7P/U+a4H7yzKb625W2PHO2d96+9sfRkqHImxf0u7i0W8ocOFqL
	 RnzNGJqhzQqjk81qIvmZCSYBNPIycTOlLWzWOALY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 153E4F80162;
	Tue,  3 Nov 2020 17:12:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7968F80171; Tue,  3 Nov 2020 17:12:39 +0100 (CET)
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [IPv6:2a01:4f8:212:88::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98522F80083
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2020 17:12:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98522F80083
Received: from [10.1.0.120] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 76A3E56205C4
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2020 17:12:34 +0100 (CET)
Subject: Re: snd_bt87x on Kworld KW-TV878RF
To: alsa-devel@alsa-project.org
References: <CAOoeSP+sPgxziFPPTWsCWHTK7cotXQPxJiZwJnj6ciEpK06zsA@mail.gmail.com>
From: Clemens Ladisch <clemens@ladisch.de>
Message-ID: <ef21f7ca-7f79-c59b-9e9b-d90c8bf4db97@ladisch.de>
Date: Tue, 3 Nov 2020 17:13:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAOoeSP+sPgxziFPPTWsCWHTK7cotXQPxJiZwJnj6ciEpK06zsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.101.5 at webclient5
X-Virus-Status: Clean
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

Tamás Hámor wrote:
> I load ... snd-bt87x with "load_all".

Does it work?


Regards,
Clemens
