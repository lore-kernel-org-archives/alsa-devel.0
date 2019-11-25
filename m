Return-Path: <SRS0=E7cH=ZR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD95DC43215
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Nov 2019 11:00:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDD422068E
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Nov 2019 11:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="S20qQ9fL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="5T6dIiMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD422068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3E631884;
	Mon, 25 Nov 2019 11:59:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3E631884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574679610;
	bh=Ca+IkLP26l1P0k/diG8c1rEoQn7EtrlyEjdh8wVZZTo=;
	h=References:To:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S20qQ9fL7ik064FB4HvTSNw8c1/Vqj/i8OiGnHCSzbW864NhEoiDrpTPGvBVbbfJX
	 ZlhgVf11Lk1sNZaFm5/9PrL0sYYABrRe9TxiF4z+8glc9qhQk4KVR7BlBjKtP+7KwL
	 iocehHw88VSLgOrqalKGS+puoZsfd4aZp4y+Mj/U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D070F8014D;
	Mon, 25 Nov 2019 11:59:19 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E76BF8016F; Mon, 25 Nov 2019 11:59:18 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A6EFF800AB
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2019 11:59:15 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 71971A003F;
 Mon, 25 Nov 2019 11:59:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 71971A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1574679555; bh=/r/8Zgcu+mLWwbJIObUQ6Jx/z1ynng+T1bPBlS8B09Y=;
 h=Subject:References:To:Cc:From:Date:In-Reply-To:From;
 b=5T6dIiMbvPRnEL5UhMI1fgTsgXcpJW6mVFs0KiyfMiW36jNob06dQSYTsY8vqeRRF
 RR5kn2JcMNb7yzLKsUXiLr5lz64ePKBep1BXjXKW+flBri4VWo0M72lYamvWfb5ciM
 i4PxDErgA48aF6j8qQpNz5WomzL5fcFX7yjL6h4s=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 25 Nov 2019 11:59:13 +0100 (CET)
References: <07f9c6fd-0dcf-e399-b012-05cd2cf6aced@perex.cz>
To: ALSA development <alsa-devel@alsa-project.org>
From: Jaroslav Kysela <perex@perex.cz>
X-Forwarded-Message-Id: <07f9c6fd-0dcf-e399-b012-05cd2cf6aced@perex.cz>
Message-ID: <a9ef39bb-d77b-4470-d247-b68706748d7f@perex.cz>
Date: Mon, 25 Nov 2019 11:59:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <07f9c6fd-0dcf-e399-b012-05cd2cf6aced@perex.cz>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>
Subject: [alsa-devel] alsa-lib 1.2.1.1 release
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hello all,

    it is a quick bug fix release for the alsa-lib package. A few UCM
problems were fixed in the code. You may download the package from
the ALSA website http://www.alsa-project.org or directly from the FTP
server ftp://ftp.alsa-project.org/pub .

Full list of changes:

    http://www.alsa-project.org/main/index.php/Changes_v1.2.1_v1.2.1.1


				Have fun,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
