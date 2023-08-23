Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932B9EE49A0
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Aug 2023 09:31:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E0D68836;
	Wed, 23 Aug 2023 11:30:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E0D68836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692783089;
	bh=9Ks34+15LsRm68cUw4Ha0wSkxyIKN0PzMzXG2uiB7as=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Lv0ZfEzaIkgoSU/wH0mE/wA8yVLTfhmzbCNxq+jB4uFMI4TWSF0CX1OiUcZWXrKzA
	 dZaeCmVT/bLFxWLCNDhUE5PeRYvJbCTLtWyVwbp3n9JCDRO5ETwn3ltUXh4xufkIwd
	 DO90rM4f643piIRa3C7BPniK8FJaoCTkIxPWbMI4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2FF53F800D1; Wed, 23 Aug 2023 11:30:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B69CCF80158;
	Wed, 23 Aug 2023 11:30:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0FADF80158; Wed, 23 Aug 2023 11:29:27 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 2478CF800BF
	for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2023 11:29:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2478CF800BF
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1692782959115009069-webhooks-bot@alsa-project.org>
References: <1692782959115009069-webhooks-bot@alsa-project.org>
Subject: snd_seq_ev_set_ump_data() stack smashing
Message-Id: <20230823092927.D0FADF80158@alsa1.perex.cz>
Date: Wed, 23 Aug 2023 11:29:27 +0200 (CEST)
Message-ID-Hash: AENN4JCSBMSRTQHF23NBHB6Y7NZ7236B
X-Message-ID-Hash: AENN4JCSBMSRTQHF23NBHB6Y7NZ7236B
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AENN4JCSBMSRTQHF23NBHB6Y7NZ7236B/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #346 was opened from symdeb:

snd_seq_ev_set_ump_data(&umpev, buffer, len); 

When called with len > 4 causes stack smashing. 
A ump messages is maximum four  32bit values.
Proposal solution, return error when len > 4 ?

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/346
Repository URL: https://github.com/alsa-project/alsa-lib
