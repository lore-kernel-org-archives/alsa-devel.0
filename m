Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DDFC54E49
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:12:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83B8A741;
	Mon,  4 Mar 2024 07:11:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83B8A741
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709532729;
	bh=+Yym+MEQrZ2rmumOPOzJwm7h2L96OF/shY4T5TqP7do=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=R7O6NvsVxALXv14ym8kvpGVHr9Qhp5coQl/5dTC5MwlEFAXq+xt0pRZ6wtr/kNC34
	 LecyY9WPdG3RIy7j/ijuG+fZHPAzz0Pqn3kFF1ZJR8AMKsnGJXJc9oGdFJYcquZN0A
	 /Ds+MalkNTWWSmA82W4gb0fA2i5WWFbZ1/DdvuMI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C4CEDF802E8; Mon,  4 Mar 2024 07:11:37 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 14583F805A1;
	Mon,  4 Mar 2024 07:11:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 46153F8024E; Mon,  4 Mar 2024 07:08:43 +0100 (CET)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id 2218EF80093
	for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2024 07:08:43 +0100 (CET)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] [alsa-lib][PATCH] conf: USB-Audio: Add Corsair HS60 Pro
 to the
 IEC958 blacklist
From: seda18@rolmail.net
To: alsa-devel@alsa-project.org
Date: Mon, 04 Mar 2024 06:08:43 -0000
Message-ID: 
 <170953252308.7258.4494475006522140416@mailman-web.alsa-project.org>
In-Reply-To: <20240226141403.13948-1-seda18@rolmail.net>
References: <20240226141403.13948-1-seda18@rolmail.net>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: 2ZQPK7VX5DZ63L5MWNHJRKTSHAFRR72J
X-Message-ID-Hash: 2ZQPK7VX5DZ63L5MWNHJRKTSHAFRR72J
X-MailFrom: seda18@rolmail.net
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/X23744RNSEZD2J3ZMBCJGHXFZIWL3ECU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hey,
I was wondering if this patch just got forgotten. If there is something wrong with the patch please let me know, because I would like to fix this.
Thanks in advance!
