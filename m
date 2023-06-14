Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84ACEB64DA
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jun 2023 06:05:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1EA7574C;
	Wed, 14 Jun 2023 08:04:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1EA7574C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686722725;
	bh=LywPT9B0kduUFSsmry+MOXlatpM7luSxdNAK0SmkElQ=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vUGkfSiu4F5POWL8I8AQn5PiSc94uvs923J1G6MBWYvZ9bY6xhaQmTTqEDRhx9r2T
	 TWxXye1DoOG2C3iHMjpMFsrCM+oqjnJg3Z8OKLZysGaiOC+1aN4qyzSYSUItm3Nn0+
	 HDQZxIwCRPE/TUl0G+CcUSl6/S3atmr7cNCLxKfA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 89B3AF80549; Wed, 14 Jun 2023 08:04:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4494BF80155;
	Wed, 14 Jun 2023 08:04:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26A2AF80155; Wed, 14 Jun 2023 08:01:39 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 1A1AAF80132
	for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2023 08:01:39 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 00/37] ALSA: Add MIDI 2.0 support
From: "Symbolic Debugger" <happy.debugging@gmail.com>
To: alsa-devel@alsa-project.org
Date: Wed, 14 Jun 2023 06:01:39 -0000
Message-ID: 
 <168672249902.20.14647833450036984617@mailman-web.alsa-project.org>
In-Reply-To: 
 <168666978762.22.2520238479965266775@mailman-web.alsa-project.org>
References: <168666978762.22.2520238479965266775@mailman-web.alsa-project.org>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: IL2LZAXPBVNBTEPJGWNCM5NOLXR5HLPS
X-Message-ID-Hash: IL2LZAXPBVNBTEPJGWNCM5NOLXR5HLPS
X-MailFrom: happy.debugging@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/URK2TVYKH5M3JCVMLTDGNNQDX6ZZSEDS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

I could not find the changes and UMP source files on https://github.com/torvalds/linux/tree/master/sound,  is that correct ?
I am trying to build a kernel with UMP support for testing UMP on a custom made development board.
