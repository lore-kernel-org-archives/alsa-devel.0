Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1803ECAAA1
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Sep 2022 21:25:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD234829;
	Mon, 19 Sep 2022 23:24:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD234829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663622714;
	bh=mTiFigv/JZpWDshV7ji9WU4jNfeA8aOADy+LLrcdldk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MLsuMG7D230hA8WMShK5eu7Ur3E2LlFmWuHlxYgy+kb+gJfEN53VoPpG+TQtKBf4k
	 w/2jcLbYbqWr+Il7Y5ymBZ1FDnz6DT3nDnLUo9Ul6eoIjQ8HjPYK1HRcJpUqj1pQve
	 cyCAh1EkxGWkEBY3k7v4o+Ho40fz55FDIxF4wxQA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29979F8016D;
	Mon, 19 Sep 2022 23:24:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A834AF8023A; Mon, 19 Sep 2022 23:24:16 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 662AEF800E5
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2022 23:23:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 662AEF800E5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1663622629266396046-webhooks-bot@alsa-project.org>
References: <1663622629266396046-webhooks-bot@alsa-project.org>
Subject: Alsa - has invalid interface number
Message-Id: <20220919212416.A834AF8023A@alsa1.perex.cz>
Date: Mon, 19 Sep 2022 23:24:16 +0200 (CEST)
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

alsa-project/alsa-lib issue #271 was opened from smangels:

hi,
I'm running the latest ArchLinux installation using a Behringer Flow8 as my main audio interface. Today I'm running into an issue where the USB audio hardware can not be loaded successfully.

```
[ 1690.797522] usb 1-3.1.1.4: new high-speed USB device number 14 using xhci_hcd
[ 1690.891936] usb 1-3.1.1.4: config 1 has an invalid interface number: 7 but max is 5
[ 1690.891940] usb 1-3.1.1.4: config 1 has no interface number 5
[ 1690.892620] usb 1-3.1.1.4: New USB device found, idVendor=1397, idProduct=050d, bcdDevice= 2.10
[ 1690.892624] usb 1-3.1.1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[ 1690.892627] usb 1-3.1.1.4: Product: FLOW 8
[ 1690.892628] usb 1-3.1.1.4: Manufacturer: Behringer
[ 1690.892630] usb 1-3.1.1.4: SerialNumber: 18-04-ED-FB-BE-A0
```

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/271
Repository URL: https://github.com/alsa-project/alsa-lib
