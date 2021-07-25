Return-Path: <SRS0=9Ww9=MR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB76C4338F
	for <alsa-devel@archiver.kernel.org>; Sun, 25 Jul 2021 20:37:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCF060EB4
	for <alsa-devel@archiver.kernel.org>; Sun, 25 Jul 2021 20:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4CCF060EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 083DE1703;
	Sun, 25 Jul 2021 22:36:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 083DE1703
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627245444;
	bh=ICWLMXrL3f/HQZcU2kU9N1NRJpnx/SB357jDnABgniA=;
	h=From:To:Subject:In-Reply-To:References:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T0UK65Aqwx8Tn+QQCgaj81fLCwuc1CUq75GhXDqNPEG/YNLDNLGWVDqA47dU33ED9
	 EWswA5cB8aw34lbJ/On/3JJgWSMovfaT9ouV9gXV3VgWF3e+xFPN/zjEc3rld3zS6N
	 nG0R8OhO4RT0Pna//Yr308JNc5h0BvhkV7qZxt2c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A875F80258;
	Sun, 25 Jul 2021 22:36:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97FF9F8026C; Sun, 25 Jul 2021 22:36:31 +0200 (CEST)
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD65FF800C0
 for <alsa-devel@alsa-project.org>; Sun, 25 Jul 2021 22:36:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD65FF800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net
 header.b="Uk3oi7fU"
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id D918C2E6;
 Sun, 25 Jul 2021 20:36:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D918C2E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
 t=1627245382; bh=PWJqoRENwRfHbihAwLZLmHYgX4yVLVVGbNyyEZbIyM4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Uk3oi7fUfB1+rPVN4shaOs8zTN7+0hE7QY9VhD347yQq+A/BEFwLnSe/FDM2nEJpQ
 IqVbCFmMEVjw8/Z+Z0yiJQjad1fvc135pW+Le7n63O8kDyzos4F7Z7zfNs/+nJUI3z
 zwe+6mEIjkemi7G+qpiBhQsRZ6ptx8QDGFWsvla6UsdNrlcBvaSYId9ZLp7uqTwHXw
 KgxZt+nRFB9Plzlkp/ZiBEkxAUFFO9RK1qNrUsB0l9nGcubF0zLuhxtSMr9AzjZZer
 YbEqyUf/VF3NgUHKKepPH84ZO5SizCDwr7gsaEW8M3mCQyNcg2+MJwdRB2aCmkuw6a
 saGsVjE6talyw==
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 0/3] Get rid of some undesirable characters
In-Reply-To: <cover.1626947264.git.mchehab+huawei@kernel.org>
References: <cover.1626947264.git.mchehab+huawei@kernel.org>
Date: Sun, 25 Jul 2021 14:36:21 -0600
Message-ID: <87fsw2uo56.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, kvm@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
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

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Hi Jon,
>
> While rebasing my docs tree, I noticed that there are three remaining
> patches from my past series that replace some UTF-8 chars by ASCII
> ones that aren't applied yet. Not sure what happened here.
>
> Anyway, those are the missing ones.
>
> Mauro Carvalho Chehab (3):
>   docs: sound: kernel-api: writing-an-alsa-driver.rst: replace some
>     characters
>   docs: firmware-guide: acpi: dsd: graph.rst: replace some characters
>   docs: virt: kvm: api.rst: replace some characters
>
>  .../firmware-guide/acpi/dsd/graph.rst         |  2 +-
>  .../kernel-api/writing-an-alsa-driver.rst     |  2 +-
>  Documentation/virt/kvm/api.rst                | 28 +++++++++----------
>  3 files changed, 16 insertions(+), 16 deletions(-)

Applied, thanks.

jon
