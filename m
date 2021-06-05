Return-Path: <SRS0=3aMq=K7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3ABC47082
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Jun 2021 23:37:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBD16140F
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Jun 2021 23:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBD16140F
Authentication-Results: mail.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D631C16DC;
	Sun,  6 Jun 2021 01:36:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D631C16DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622936231;
	bh=A1K4rNAL/wzTuxA7WDjt0409MVEZzfpbrFdaTcIr9Mw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V34DPMolbYW3SEBByUQHR7Zftyi7EusMajJ6NcFzmUIenHgvIp5NQtjCV/Aqxcn14
	 vhHyz94OwUsy/yBLjK4GFQmdrmT5DCkGFW/F9k/TJNTaZuWEyk7pwkBTOXGY8K9COO
	 HUk5NOl8/7vgtDgxYKmva509RCQyuxSYSzdmaH50=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77ACAF8016D;
	Sun,  6 Jun 2021 01:36:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9DE63F80253; Sun,  6 Jun 2021 01:36:18 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7EBEDF80155
 for <alsa-devel@alsa-project.org>; Sun,  6 Jun 2021 01:36:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7EBEDF80155
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1622936168697413921-webhooks-bot@alsa-project.org>
References: <1622936168697413921-webhooks-bot@alsa-project.org>
Subject: amixer and alsamixer unaware of controls for ThinkPad T14's 'acp' card
Message-Id: <20210605233618.9DE63F80253@alsa1.perex.cz>
Date: Sun,  6 Jun 2021 01:36:18 +0200 (CEST)
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

alsa-project/alsa-lib issue #146 was opened from jwatt:

I have the AMD Ryzen 7 Pro 4750U version of the [ThinkPad T14 gen 1 type 20UD](https://pcsupport.lenovo.com/gb/en/products/laptops-and-netbooks/thinkpad-t-series-laptops/thinkpad-t14-type-20ud-20ue/20ud/?linkTrack=Homepage%3ABody_Search%20Products&searchType=4&keyWordSearch=T14%20%20Gen%201%20%28type%2020UD,%2020UE%29%20Laptop%20%28ThinkPad%29%20-%20Type%2020UD) ([tech specs](https://www.lenovo.com/gb/en/laptops/thinkpad/t-series/ThinkPad-T14-AMD-G1/p/22TPT14T4A2?notPassDisplayRuleRedirectFlag=notPassDisplayRuleRedirectFlag)) with Fedora 34 installed. I am unable to control the built-in microphone using `amixer`/`alsamixer`.

```
$ cat /proc/asound/modules
   0 snd_hda_intel
   1 snd_hda_intel
   2 snd_acp3x_rn
```

As best I can tell (I could be mistaken!), 0 is the HDMI port, 1 is the build-in speakers and headphones jack, and 2 is the Ryzen "Audio Co-Processor" (i.e. "acp" / "AMD TrueAudio") which is (or includes) the built-in microphone. To be specific, I only get microphone input if I select 'acp' as the input.

For the 'acp' card, AlsaMixer v1.2.4 reports "This sound device does not have any controls."

It appears support for the Ryzen 4000 mobile series Audio Co-Processor was added in kernel 5.8 (see the section "Add Renoir ACP driver" on the [5.8 release notes](https://kernelnewbies.org/Linux_5.8#Audio)). If the kernel supports it, it's unclear to me why the ALSA tools wouldn't allow me to control it. Is this currently expected?

I'm happy to provide any other information that would be helpful - just let me know what you need.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/146
Repository URL: https://github.com/alsa-project/alsa-lib
