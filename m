Return-Path: <SRS0=0Rat=K2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C66C47082
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 10:19:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B32611CA
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 10:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B32611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF2D3846;
	Mon, 31 May 2021 12:18:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF2D3846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622456350;
	bh=qVy7jE1KsDpd2VVkiogKDeDjeEBgmPBojpscyMeRFP8=;
	h=Subject:References:To:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tRuHUqffy1HkGcvEeOYstr3Nfsvn47gw2JBn99tP00eQIc4TBglVVSVP33D8N+ZZz
	 HTL2WzlSdZNerROsFnsuk2Shf+x4dDUTWL98agFTFjZwB4mZW/7KsmRfd8gmY66BAm
	 ocq4FBZGhHc8YstoT95Pm4RKRjz68cHU1ypKu6Bk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F310F80273;
	Mon, 31 May 2021 12:18:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EFF67F802E2; Mon, 31 May 2021 12:18:18 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 30BCAF80161
 for <alsa-devel@alsa-project.org>; Mon, 31 May 2021 12:18:11 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 66669A0040
 for <alsa-devel@alsa-project.org>; Mon, 31 May 2021 12:18:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 66669A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1622456290; bh=9Dn6MpwDZEqlOHWxUB0w++crwXDVAN2V5kjUj4gQ0DA=;
 h=Subject:References:To:From:Date:In-Reply-To:From;
 b=sc6cOtIZEgXGJSgkSlTBegxfLzNPDg3BpB8WS0B6SouOFm0tIns+jjdfhQv+7IpVk
 1SID5W9NdxPXnMYyqV34ANP0JrA189eekLK+0rPcxnJZAaqy/8UfCDq/tBMeN2xQVU
 sMRiH0aJcJOW8X3QN4QbxJSnujKi7wkfRP6eNsPQ=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA
 for <alsa-devel@alsa-project.org>; Mon, 31 May 2021 12:18:09 +0200 (CEST)
Subject: ALSA 1.2.5 release
References: <c2860da9-d21f-52bb-e15e-fda214e6890a@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
From: Jaroslav Kysela <perex@perex.cz>
X-Forwarded-Message-Id: <c2860da9-d21f-52bb-e15e-fda214e6890a@perex.cz>
Message-ID: <2c410cdc-bde3-1b37-d517-e2d6a27128e5@perex.cz>
Date: Mon, 31 May 2021 12:18:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c2860da9-d21f-52bb-e15e-fda214e6890a@perex.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Hello all,

     new ALSA userspace packages were released. You may download them from
the ALSA website http://www.alsa-project.org or directly:

     HTTP: https://www.alsa-project.org/files/pub
     FTP:  ftp://ftp.alsa-project.org/pub

Full list of changes:

     https://www.alsa-project.org/wiki/Changes_v1.2.4_v1.2.5

All files on the primary ALSA site have also GPG signature now.
The fingerprint of the public signing key is:

     F04D F507 37AC 1A88 4C4B 3D71 8380 596D A6E5 9C91

				Have fun,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
