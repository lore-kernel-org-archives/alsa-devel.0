Return-Path: <SRS0=v4AK=LB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A92C4743C
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 07:03:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111BC6120F
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Jun 2021 07:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111BC6120F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chmail.ir
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C39D71672;
	Mon,  7 Jun 2021 09:02:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C39D71672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623049387;
	bh=GEINSpW5fUx7axb542SfnzOMyEa5vKbHjeKmzPGsVec=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FANOMqpB04M3B+ItwHSpw8LStvOhoJ0SgbkPAIlEW2UPR3hNBWiz0uYdDrfXUFzUC
	 vZFbe05mNWPoGBQ5DJBgNy91nVaEihOSTvcq49wOHZacUMBJ42amcQaVozN8OcH3Ck
	 z3cXDm8Rt+VE+0aA7M74McYm0cbyDbcysEF57M+U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44E16F8020D;
	Mon,  7 Jun 2021 09:02:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E576F80212; Mon,  7 Jun 2021 09:02:15 +0200 (CEST)
Received: from prx2.chmail.ir (unknown [80.191.56.172])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1BF8BF801EC
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 09:02:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1BF8BF801EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=chmail.ir header.i=@chmail.ir
 header.b="L3yKvjxc"
Received: from localhost (localhost.localdomain [127.0.0.1])
 by prx2.chmail.ir (Postfix) with ESMTP id 0218040DBC24
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 11:31:56 +0430 (+0430)
Received: from prx2.chmail.ir ([127.0.0.1])
 by localhost (prx2.chmail.ir [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 8_yN7cCgUtzC for <alsa-devel@alsa-project.org>;
 Mon,  7 Jun 2021 11:31:51 +0430 (+0430)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by prx2.chmail.ir (Postfix) with ESMTP id C1FAB40DBC4A
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 11:31:51 +0430 (+0430)
DKIM-Filter: OpenDKIM Filter v2.10.3 prx2.chmail.ir C1FAB40DBC4A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chmail.ir;
 s=chmailv; t=1623049311;
 bh=Dffm91JOLWjtJ4nnhSPHrzfWbLyfOoIaoe4Io+Sngpc=;
 h=To:From:Message-ID:Date:MIME-Version;
 b=L3yKvjxcx1AHujzURnfzJNRi36cPPo84OTxABTVqml4rOjTxiH/642FJO33FEeH/k
 Rbu1FK+BSm5QT3+C/MVqmaSCxHhb6j/aWv9fk+6XuVJfQapL75uoPJeDTM1mUFwyi6
 qlHntZoCZeGkGPNX6rlE/3yGy6bWVThbOXJSDOiLiuULXCVY7RnOpnxI3FDTvC4UIh
 gD0LwqAeq2EDdupP/41Hu9KJyYzhnXT6tZw431Svq+StsqYIDWTflhv1i5l1qOA7pv
 X3snK3eM7fWn9r1CoRdYfuunqkeX7byLTfsbjVxtSdCT/BDv6EQJPS8k9vUgDwalbA
 7g3Dv3Y6rldsQ==
X-Virus-Scanned: amavisd-new at 
Received: from prx2.chmail.ir ([127.0.0.1])
 by localhost (prx2.chmail.ir [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id LENe1CxyY5pB for <alsa-devel@alsa-project.org>;
 Mon,  7 Jun 2021 11:31:51 +0430 (+0430)
Received: from [192.168.1.146] (unknown [93.119.214.80])
 by prx2.chmail.ir (Postfix) with ESMTPA id 9442940DBC24
 for <alsa-devel@alsa-project.org>; Mon,  7 Jun 2021 11:31:51 +0430 (+0430)
To: alsa-devel@alsa-project.org
From: Meghdad Moradi <meghdad.moradi@chmail.ir>
Subject: Possible ALSA bug: Cannot record via mic while PA is running
Message-ID: <9424b819-f35e-a857-c2ef-a852d14121a3@chmail.ir>
Date: Mon, 7 Jun 2021 11:31:42 +0430
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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

   Hello,

   Please take a look at the following thread that I created some time
   ago:

   [1]https://ubuntuforums.org/showthread.php?t=2462882&p=14041574#post140
   41574

   I have included most relevant and useful info in the first and last
   post.

   pa-info output:

   [2]https://gist.github.com/no149/5c239626048a860a882f8d412013a4e6

   I'd provide further info, if it's needed.

References

   1. https://ubuntuforums.org/showthread.php?t=2462882&p=14041574#post14041574
   2. https://gist.github.com/no149/5c239626048a860a882f8d412013a4e6
