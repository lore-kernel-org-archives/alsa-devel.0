Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0A9C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:23:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07879207EA
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JIcMgyMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07879207EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D90731790;
	Mon,  5 Oct 2020 21:22:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D90731790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601925780;
	bh=Aahgpnwxc+ptkMZyefAlgA+//XP1VDX51HJ5VQzR7Qk=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JIcMgyMKs7Lgq+uPLfTluLNUJBTBczwvwlwUvYR1BZ5bESghmDD+g12F7myHiNsrv
	 S/tTl/pIAd706JltEZ5hsxNQUJwt/lRGa6oreFLXFNkixjPAGVXifRkxYsWu66iaxX
	 XFOx4ok0etSkcs6YSMXZglwOAPIMerooE0TSjI2c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 72814F80245;
	Mon,  5 Oct 2020 21:22:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B947F8025A; Mon,  5 Oct 2020 21:22:00 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0025.hostedemail.com
 [216.40.44.25])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 550F2F80121
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 21:21:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 550F2F80121
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id CDE0518224D77;
 Mon,  5 Oct 2020 19:21:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: wall78_50031f1271c0
X-Filterd-Recvd-Size: 1640
Received: from XPS-9350.home (unknown [47.151.133.149])
 (Authenticated sender: joe@perches.com)
 by omf18.hostedemail.com (Postfix) with ESMTPA;
 Mon,  5 Oct 2020 19:21:52 +0000 (UTC)
Message-ID: <714e5d92d8b9f3ba365ec0cabf1406ea1a847d69.camel@perches.com>
Subject: Re: [PATCH] sound: sparc: dbri: fix repeated word 'the'
From: Joe Perches <joe@perches.com>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2020 12:21:51 -0700
In-Reply-To: <20201005191234.12715-1-rdunlap@infradead.org>
References: <20201005191234.12715-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
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

On Mon, 2020-10-05 at 12:12 -0700, Randy Dunlap wrote:
> Drop the duplicated word "the".
[]
> --- lnx-59-rc8.orig/sound/sparc/dbri.c
> +++ lnx-59-rc8/sound/sparc/dbri.c
> @@ -620,7 +620,7 @@ A circular command buffer is used here.
>  while another can be executed. The scheme works by adding two WAIT commands
>  after each sent batch of commands. When the next batch is prepared it is
>  added after the WAIT commands then the WAITs are replaced with single JUMP
> -command to the new batch. The the DBRI is forced to reread the last WAIT
> +command to the new batch. The DBRI is forced to reread the last WAIT

Maybe Then the?

>  command (replaced by the JUMP by then). If the DBRI is still executing
>  previous commands the request to reread the WAIT command is ignored.
>  

