Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F27D3B98B
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:06:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5389B219E;
	Tue, 26 Nov 2024 14:06:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5389B219E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1732626406;
	bh=o9nXG+Bh3HdM6YCEnytKq1+n5wauigf8u809S6t1GXA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=JgzRzRHj9CHRgLh0LiZQPibufhT1QhzvOjkdPZiaRiATtuTi8ll0loWjk2Y3SXc+A
	 CJv/YYy4GmP3N5jslX4gmPTjSDctAxDMepUYhZyuN8q0aDV5sLdJOi+WdayhxsKHro
	 XzD9emlZm87UpFELfJWX0Y6pRP1LnJqqFBEBmsoU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 88686F805C5; Tue, 26 Nov 2024 14:06:14 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 258D1F805AE;
	Tue, 26 Nov 2024 14:06:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 00DD2F80496; Tue, 26 Nov 2024 14:06:09 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 307BEF8019B
	for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2024 14:06:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 307BEF8019B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1732626360683715820-webhooks-bot@alsa-project.org>
References: <1732626360683715820-webhooks-bot@alsa-project.org>
Subject: alsa-lib update from 1.2.12 to 1.2.13 causes HDMI/DsiplayPort
  outputs to disappear
Message-Id: <20241126130610.00DD2F80496@alsa1.perex.cz>
Date: Tue, 26 Nov 2024 14:06:09 +0100 (CET)
Message-ID-Hash: 74FGVDTJH2YAGZKJJNNUSO6UBSRYWU7G
X-Message-ID-Hash: 74FGVDTJH2YAGZKJJNNUSO6UBSRYWU7G
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/74FGVDTJH2YAGZKJJNNUSO6UBSRYWU7G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #423 was opened from mwsltn:

Basic Info: 
Linux Distro: Arch 
Kernel Version: 6.12.1

I have very reliably been using a USB-C connected external monitor that has internal speakers represented by the output device:

 `HDMI / DisplayPort 1`

After running a package update this AM all the HDMI/DisplayPort outputs disappeared. First I downgraded the kernel which didn't help, then checked the pacman logs to see what else had changed and the list included the following: 

```
[2024-11-26T05:07:01-0600] [ALPM] upgraded alsa-ucm-conf (1.2.12-1 -> 1.2.13-1)
[2024-11-26T05:07:01-0600] [ALPM] upgraded alsa-lib (1.2.12-1 -> 1.2.13-1)
[2024-11-26T05:07:01-0600] [ALPM] upgraded alsa-utils (1.2.12-1 -> 1.2.13-1)
```
So I downgrade: 
```
[2024-11-26T06:51:22-0600] [PACMAN] Running 'pacman -U file:///var/cache/pacman/pkg/alsa-ucm-conf-1.2.12-1-any.pkg.tar.zst file:///var/cache/pacman/pkg/alsa-lib-1.2.12-1-x86_64.pkg.tar.zst file:///var/cache/pacman/pkg/alsa-utils-1.2.12-1-x86_64.pkg.tar.zst'
[2024-11-26T06:51:24-0600] [ALPM] downgraded alsa-ucm-conf (1.2.13-1 -> 1.2.12-1)
[2024-11-26T06:51:24-0600] [ALPM] downgraded alsa-lib (1.2.13-1 -> 1.2.12-1)
[2024-11-26T06:51:24-0600] [ALPM] downgraded alsa-utils (1.2.13-1 -> 1.2.12-1)
```
Problem fixed. 

Please let me know if I can provide any other info.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/423
Repository URL: https://github.com/alsa-project/alsa-lib
