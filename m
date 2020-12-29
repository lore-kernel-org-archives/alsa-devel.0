Return-Path: <SRS0=cglx=GB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BA4C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Dec 2020 15:23:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B85B207BD
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Dec 2020 15:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B85B207BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bertschiettecatte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D30C31801;
	Tue, 29 Dec 2020 16:22:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D30C31801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1609255410;
	bh=7DP9ndFdMXzKX7MPyIXhct4/rcWJvcZfVW6WfHHdetg=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bNPw5ekNaIeLiqKV4yRo/tBK96OTJ/4HKLyfJr9WpTxi5PsIT3CduD9iN3F2e1iEG
	 Kg4p1TNEmDfb/iYYD1x9vI2m2gB6+7Mj8AjIaweVZek7NkXnvLSv+3xICc0v3U1oH2
	 qoHNC3tKE5OD54ETV9D9LMFzBio7hGDgb5L+TMDk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B96ADF80162;
	Tue, 29 Dec 2020 16:22:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4529BF8022B; Tue, 29 Dec 2020 16:22:38 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A9A7F80162
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2020 16:22:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A9A7F80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=bertschiettecatte-com.20150623.gappssmtp.com
 header.i=@bertschiettecatte-com.20150623.gappssmtp.com header.b="VOqeRLEu"
Received: by mail-yb1-xb35.google.com with SMTP id v67so12590011ybi.1
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2020 07:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bertschiettecatte-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=7DP9ndFdMXzKX7MPyIXhct4/rcWJvcZfVW6WfHHdetg=;
 b=VOqeRLEubY0Mh8BXKS63jQXlL2zY/xYWv1eU4aWTf9CwWh3sYccRqnKX67nLkgLyNM
 17JGdDBIZHQ0TFwDkKihmmVX95aZNsbBKVPEOC2vcx+Pbrh8FGCz3LXbIucv7kBGnZtn
 TsnAFpdSsLbloNTzPzthk12F8CQyOjtaLAg3eR+HARIJ9xqeaXbNSsLxUom4WHCpNowc
 YgF22hmih99Di75usigUU84ZaLTsjuT8gOVEO0IeOzSFdzcJUfZYCd0FmGqtczu3obQE
 aJMmaUWfYG1N9F9lGPP5r0dgfDHNJkW7R42QNo3sFEvPVWEVx2NIxjEhw11rb2guuKSR
 WEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=7DP9ndFdMXzKX7MPyIXhct4/rcWJvcZfVW6WfHHdetg=;
 b=CK4aw3odCFK4CJcrjZ3bk16BNib7fbYng6aDrHCY0Mc7UGDw6Q3k1j9IUq+g3TztKY
 4+HYnQYi1p1j+PEKCCGkO4EIPAmqi+OGgcp13ih0XcdxpRNKQEuqfIKRXeKy8SSxr5Lw
 mVugIFHtq2DJvk0AD7rdwINS5cNY6AAJCunULvAcqesRtmX0ReLe6jJqFincA40tciN1
 8wsN4qiwQBVqaqCTT2HR+UTMFLE1PPtxI/OVzIgHL3D9UbDdw/Mso0JZxiKabdhZSzss
 u1mW4zTsGbU9dtyQj9VRsJMCtDT4iOsIZd6H5E8/KofEJ64KBI8PwqS0kQsrp9XkPZWo
 vmgA==
X-Gm-Message-State: AOAM530WjEb6yS69xIAsiFGWXGsJVqZbasoSqAX/fVewnnrE/cxi/Bjd
 x4X685Pa5OJxP+y+6P4ZSY+P4cXb/Qg5haH76b/iS/Ee8Mfw9A==
X-Google-Smtp-Source: ABdhPJyWEC9YkVMLuZRinUeNqpBFubt97X9cinWGMSeB6uUgls3g0B+OhL4/ZHE2aXYGBRZgYCjyx1rXxK72s1v7DUs=
X-Received: by 2002:a25:ccc9:: with SMTP id l192mr73666154ybf.85.1609255349580; 
 Tue, 29 Dec 2020 07:22:29 -0800 (PST)
MIME-Version: 1.0
From: Bert Schiettecatte <bert@bertschiettecatte.com>
Date: Tue, 29 Dec 2020 07:22:18 -0800
Message-ID: <CALd3UbR-1WHwpw=y-OMM6w6wTpKQ9mkY6J1F3KwLMQKrwWL_Lw@mail.gmail.com>
Subject: configuring usb 2.0 audio gadget correctly via configfs?
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi all

I am using kernel 5.9 stable and I'm trying to configure the usb 2.0
audio gadget correctly so my device shows up as an audio interface
when I plug it into my PC or Mac. I previously was on 4.11 and had a
bunch of hacks I applied to the uac2 driver which worked fine, but a
lot has changed since then and I'm wondering if by now the gadget
works correctly out of the box, so I don't have to apply my hacks
anymore.

I'm configuring the device using configfs and that works fine, but
when I plug it into my Mac I just see zero channels and the device
name is capture or playback inactive.

Anyway, just wanted to know what the current state of things is
regarding the gadget driver and alsa.

Thanks
Bert
