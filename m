Return-Path: <SRS0=yBFe=LJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E0BC48BE5
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 22:08:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D632610EA
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Jun 2021 22:08:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D632610EA
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12A271677;
	Wed, 16 Jun 2021 00:07:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12A271677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623794897;
	bh=dEFKOuMYW4nF99zofGxMTazsI8sJ15RcDhZSb1zmvz0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iHRtsXiZzXMKNOz9q3EQ4K1i+6+XW6C0vxJN1KYqVb9gkltvK9+jh1pLbAHszlOu3
	 9uBcRGhD/g12rB9qH8zfGsPUFvHaXcskI9nzb86IIaWVH1O8YllF+KBQfJ8iSyeic5
	 fYPxVDq0MtqDYdk4/JHK5L8O7op/41L0B/SW0G5Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99A7EF8016D;
	Wed, 16 Jun 2021 00:07:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F527F80171; Wed, 16 Jun 2021 00:07:25 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 52FCAF8016C
 for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2021 00:07:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52FCAF8016C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1623794837558520079-webhooks-bot@alsa-project.org>
References: <1623794837558520079-webhooks-bot@alsa-project.org>
Subject: conf: refine check for snd_config_is_array
Message-Id: <20210615220725.7F527F80171@alsa1.perex.cz>
Date: Wed, 16 Jun 2021 00:07:25 +0200 (CEST)
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

alsa-project/alsa-lib pull request #158 was opened from ranj063:

Apart from checking the index, also check if the
node is not compound to qualify a config as an array.

For ex:

mixer [
	"mixer1"
]

is an array but

mixer.0 {
	name	"mixer 1"
}

is not an array even though the id is 0.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Request URL   : https://github.com/alsa-project/alsa-lib/pull/158
Patch URL     : https://github.com/alsa-project/alsa-lib/pull/158.patch
Repository URL: https://github.com/alsa-project/alsa-lib
