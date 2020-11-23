Return-Path: <SRS0=WmXX=E5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CA5C2D0E4
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:47:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8CB206F7
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2020 09:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BUYQGg7i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="KT+O73CF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ivitera.com header.i=@ivitera.com header.b="phbX3w8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8CB206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ivitera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 509081687;
	Mon, 23 Nov 2020 10:47:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 509081687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606124872;
	bh=3WeLx8mvBBO/pZgZ4BKiRFRlyykGBzrTqSWoGUp/JMg=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BUYQGg7ic0Ar1GdOH9Grezq6ciaO0tAC56eMTKu2WmrcquJz/thrdBnVLA2DcBxNy
	 bGuzj0ucIpjBFaKIQ0zjNp3Tu4OPa8/Tbl3sFA/pnesSB2MTkMIJeU2pgWYhc4YXRo
	 6WSErcZ3XtWh5FVVUfodnoLRi81jGCn24Lg0/Rcc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D3219F8015F;
	Mon, 23 Nov 2020 10:47:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E26EEF80113; Mon, 23 Nov 2020 10:46:59 +0100 (CET)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7F839F80113
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2020 10:46:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7F839F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="KT+O73CF"; 
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="phbX3w8s"
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id 5CCA9A9ACCF14;
 Mon, 23 Nov 2020 10:46:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1606124811; bh=3WeLx8mvBBO/pZgZ4BKiRFRlyykGBzrTqSWoGUp/JMg=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=KT+O73CF2RVrcAtLzgWqeoOsLG9FGagVBduiWPqaYfrA9j36fRcoNaE8rQEfMaa7s
 xpOVMgsyt4EJJAVEPFupWU9XnyQc54VE4OtYEAxtncKUzjwZEqIL8yjTZYxnR6n+Ke
 ZZuthRv2RzPeOUQC2O7SyiBFdnk75d6at7dUkMpM=
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n-9PPCPF7-o8; Mon, 23 Nov 2020 10:46:46 +0100 (CET)
Received: from [192.168.105.22] (ip28.insite.cz [81.0.237.28])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id E50BFA9ACCFD1;
 Mon, 23 Nov 2020 10:46:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1606124806; bh=3WeLx8mvBBO/pZgZ4BKiRFRlyykGBzrTqSWoGUp/JMg=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=phbX3w8sEHKxIA6xF8wR9pVK5tuAlUQI07pdQxTuyfvnWEbWxTg77MPwel9UqvM0Z
 lm2cq/n6FWepaOTEOQngwcaZINdmNaZdAcnwkfpkKEzBk4/7WKsfrsMms4vyMaiE+b
 VIkSkBQW27IxuBvcCyd00HLPoOMTyFu5Ry9isBJ0=
Subject: Re: [PATCH 39/41] ALSA: usb-audio: Add implicit_fb module option
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20201123085347.19667-1-tiwai@suse.de>
 <20201123085347.19667-40-tiwai@suse.de>
From: Pavel Hofman <pavel.hofman@ivitera.com>
Message-ID: <1bbcb89c-0a85-4493-85e2-2bee42580c7b@ivitera.com>
Date: Mon, 23 Nov 2020 10:46:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201123085347.19667-40-tiwai@suse.de>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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


Dne 23. 11. 20 v 9:53 Takashi Iwai napsal(a):
> A new module option, implicit_fb, is added to specify the driver
> looking for the implicit feedback sync.  This can be useful for a
> device that could be working better in the implicit feed back mode and
> user wants to test it quickly.  When this works, we can add the quirk
> entry easily.

Hi Takashi, thanks a lot for this extremely practical feature, along
with all the very useful patches.

With regards,

Pavel.
