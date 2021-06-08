Return-Path: <SRS0=yD/C=LC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F9BC47082
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 16:14:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FBD61278
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Jun 2021 16:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FBD61278
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DFD5E1774;
	Tue,  8 Jun 2021 18:13:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DFD5E1774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623168878;
	bh=vtBDsdYwIjnuE/Qa12M8yH2abuabIVEFOBn5kcVFfpQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AXoka6doCGPIVwgL5zSobQV2J6V2a14SHYibAgY0WcpqshLlz3nyELYZW5w52ZIPv
	 IYd7Ew9wt0jswM1RL36WaB/Rhmwkpon91YIPQsjHHqBHh6l91t9Ewxjl50Gc+GU+fA
	 vF6WMqME7M5EaXqThW3f9idGtRNVMYiMJD+AUskI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A20EF801EC;
	Tue,  8 Jun 2021 18:13:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 846C6F80218; Tue,  8 Jun 2021 18:13:46 +0200 (CEST)
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net
 [99.33.87.210])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90197F8019B
 for <alsa-devel@alsa-project.org>; Tue,  8 Jun 2021 18:13:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 90197F8019B
Received: from localhost (localhost [127.0.0.1])
 by thursday.test (OpenSMTPD) with ESMTP id ed953c64;
 Tue, 8 Jun 2021 16:13:39 +0000 (UTC)
Date: Tue, 8 Jun 2021 09:13:38 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Ryan Burns <rtburns@protonmail.com>
Subject: Re: alsamixer: use background color instead of COLOR_BLACK
In-Reply-To: <20210206224135.0B465F80171@alsa1.perex.cz>
Message-ID: <alpine.LNX.2.20.2106080841500.25665@thursday.test>
References: <1612651281048146009-webhooks-bot@alsa-project.org>
 <20210206224135.0B465F80171@alsa1.perex.cz>
User-Agent: Alpine 2.20 (LNX 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Alsa-devel <alsa-devel@alsa-project.org>
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

On Sat, 6 Feb 2021, GitHub pull_request - opened wrote:

> alsa-project/alsa-utils pull request #77 was opened from r-burns:
>
> Hi! I have a cosmetic "improvement" I'd like to share. Scare quotes
> because this is possibly opinionated, but I'd still like to know what
> you think.
>
> I think on typical terminals, COLOR_BLACK is the same or quite similar
> to the background color, so this does not make much of a difference. But
> on "solarized" color schemes and similar, the COLOR_BLACK may be quite
> different from the background color, so in my opinion it looks odd to
> have the alsamixer panel stand out this way. For example, I'm using the
> "Nord" color scheme on a pitch black #000000 background, and here's how
> the mixer looks with/without this patch (blank terminal, htop, and
> ncmpcpp also provided for comparison):
>
> ![image](https://user-images.githubusercontent.com/52847440/107131140-dbf46500-6888-11eb-938a-9a3258bf7184.png)
>
> As you can see, the current alsamixer in the center looks a bit strange
> and sticks out
>  against my chosen background color and the other TUIs I'm using. Htop
> and ncmpcpp agree on using the builtin `-1` background color for their
> own backgrounds, but alsamixer uses COLOR_BLACK which stands out from
> the actual background. The alsamixer on the bottom right is using this
> patch, and blends in seamlessly.
>
> Again, this is just my opinion! Feel free to close if this is wrong or
> superfluous. Nonetheless, I thought I'd share this patch, in case anyone
> else feels the same way.
>
> Request URL : https://github.com/alsa-project/alsa-utils/pull/77 Patch
> URL : https://github.com/alsa-project/alsa-utils/pull/77.patch
> Repository URL: https://github.com/alsa-project/alsa-utils
>

This alsamixer patch made it alsa-utils 1.2.5 (and Slackware current) but
it gives me problems.

I have a terminal with a white background (XTerm default), so the white
characters do not appear at all and the yellow characters are extremely
hard to read.

My simple solution is to revert patch:
c867aa8a84a7e9fbf7f9547a3462f8521cfc69b0

Perhaps a better solution could be developed to allow the foreground and
background colors to be changed by the user?

Signed-off-by: Richard Narron <richard@aaazen.com>

--- alsa-utils-1.2.5/alsamixer/colors.c	2021-05-27 10:18:36.000000000 -0700
+++ alsa-utils-1.2.4/alsamixer/colors.c	2020-10-15 04:32:33.000000000 -0700
@@ -50,11 +50,11 @@
 		start_color();
 		use_default_colors();

-		get_color_pair(COLOR_CYAN, -1); // COLOR_PAIR(1)
-		get_color_pair(COLOR_YELLOW, -1);
+		get_color_pair(COLOR_CYAN, COLOR_BLACK); // COLOR_PAIR(1)
+		get_color_pair(COLOR_YELLOW, COLOR_BLACK);
 		get_color_pair(COLOR_WHITE, COLOR_GREEN);
-		get_color_pair(COLOR_RED, -1);
-		get_color_pair(COLOR_WHITE, -1);
+		get_color_pair(COLOR_RED, COLOR_BLACK);
+		get_color_pair(COLOR_WHITE, COLOR_BLACK);
 		get_color_pair(COLOR_WHITE, COLOR_BLUE);
 		get_color_pair(COLOR_RED, COLOR_BLUE);
 		get_color_pair(COLOR_GREEN, COLOR_GREEN);
