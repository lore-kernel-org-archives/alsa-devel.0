Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C39C433EF
	for <alsa-devel@archiver.kernel.org>; Sat, 12 Mar 2022 21:44:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C47F16CA;
	Sat, 12 Mar 2022 22:44:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C47F16CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647121492;
	bh=Lj7+gauN+noi8Kh/rt0Gv5ORitb5XT3mvdoLJLpk4DE=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NLTjM2/JkyPRtotHy/CUtlFYyqSXRWIQfsXpE5A0KjXIpXA9c3GaYDNJIQUWmf2He
	 KUlIQDq/zcBSfI6dH30toYnAA9Tl/9ShExRJQhSXGXwV99x8HS/w/5iCrPneRyRYim
	 M2SSPR3UmLNm0OtkDa4J3m0sZcXR8KZStCBLjDBQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EB889F80171;
	Sat, 12 Mar 2022 22:44:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 044A1F800B0; Sat, 12 Mar 2022 22:44:01 +0100 (CET)
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.35])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B841F800D2
 for <alsa-devel@alsa-project.org>; Sat, 12 Mar 2022 22:43:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B841F800D2
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
 by unirelay02.hostedemail.com (Postfix) with ESMTP id 9E35F23501;
 Sat, 12 Mar 2022 21:43:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf20.hostedemail.com (Postfix) with ESMTPA id 5FE732002B; 
 Sat, 12 Mar 2022 21:43:53 +0000 (UTC)
Message-ID: <2422fcc6d9a1e03e4dde90ea91327764ab5ee4b5.camel@perches.com>
Subject: Re: [PATCH 3/6] ALSA: seq: oss: use kzalloc
From: Joe Perches <joe@perches.com>
To: Julia Lawall <Julia.Lawall@inria.fr>, Jaroslav Kysela <perex@perex.cz>
Date: Sat, 12 Mar 2022 13:43:52 -0800
In-Reply-To: <20220312102705.71413-4-Julia.Lawall@inria.fr>
References: <20220312102705.71413-1-Julia.Lawall@inria.fr>
 <20220312102705.71413-4-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5FE732002B
X-Stat-Signature: rmt9obkyouuykyseiymery8o93ewmsek
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+wmoUH95/RP/dF0B8Uoo7RJ+6BRXnnwI0=
X-HE-Tag: 1647121433-91170
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
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

On Sat, 2022-03-12 at 11:27 +0100, Julia Lawall wrote:
> Use kzalloc instead of kmalloc + memset.
[]
> diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
[]
> @@ -81,7 +81,6 @@ snd_seq_oss_create_client(void)
>  	system_client = rc;
>  
>  	/* create annoucement receiver port */

unrelated trivia: typo of announcement above

> -	memset(port, 0, sizeof(*port));
>  	strcpy(port->name, "Receiver");
>  	port->addr.client = system_client;
>  	port->capability = SNDRV_SEQ_PORT_CAP_WRITE; /* receive only */
> 


