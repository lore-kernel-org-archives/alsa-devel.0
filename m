Return-Path: <SRS0=iKRb=DH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285B6C4727C
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:23:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916A52072E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LOKUiOPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916A52072E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A029417DA;
	Wed, 30 Sep 2020 18:23:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A029417DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601483031;
	bh=hrjBs5hEpG18gMgFc7PREunPDFj0bu2v5cYLZ/K2VTU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LOKUiOPSHz41BbfzgaPZcDLbgdsw0/NnZqPTKoHL7/SIVKdCc4kAJKMXvT20Eq468
	 LnpUbeJcACy5lzgPabicIfCnIhdvuSpitgG5tVAbO+8ay4n2RdcUUTirOCoSILxTqX
	 nZ3RJWdfVRRLxy/zJwxy3UP3v0ApsIkPzkk9Ei5E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 20C21F801D8;
	Wed, 30 Sep 2020 18:23:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA423F801ED; Wed, 30 Sep 2020 18:22:59 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 4F135F800AB
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2020 18:22:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4F135F800AB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1601482967600851059-webhooks-bot@alsa-project.org>
References: <1601482967600851059-webhooks-bot@alsa-project.org>
Subject: alsa-info: provide DMI system sku
Message-Id: <20200930162259.AA423F801ED@alsa1.perex.cz>
Date: Wed, 30 Sep 2020 18:22:59 +0200 (CEST)
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

alsa-project/alsa-utils pull request #59 was opened from plbossart:

The system sku is used in SOF machine drivers to set specific quirks,
expose it in alsa-info to help support users. Example on a SoundWire
enabled device:

cat /sys/class/dmi/id/product_sku
0A32
dmidecode -s system-sku-number
0A32

Add a variable and expose the results of both methods.

Note that the dmidecode support is very recent and might not yet be
available in all distros:

http://git.savannah.nongnu.org/cgit/dmidecode.git/commit/?id=d70d5e686148eabe90c89fbf4cdcf5258db5aa05

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Request URL   : https://github.com/alsa-project/alsa-utils/pull/59
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/59.patch
Repository URL: https://github.com/alsa-project/alsa-utils
