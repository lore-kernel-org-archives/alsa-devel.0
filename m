Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D70C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Mar 2022 13:48:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A817174B;
	Tue, 15 Mar 2022 14:47:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A817174B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647352110;
	bh=fRJlJ2rTlGbHVaOXA3a7TjCvA+HS99/1cpEvFviB4uA=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uc0KgWC5IwW8j52DP+AcDFc44WI+YuBy39MKCnoG+F9D2tu9monmACPtjUfBRnxJs
	 ISn+2zgoF4/pUBzUIzc7HuWSBW12aRE7JYTf7DvgdjRwaoRL9o0aQ3L468IDZB6rya
	 LonEkG0Coydunl9tGuaC1+Rj+0mO2ZoZFopLg20I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EADFF8012C;
	Tue, 15 Mar 2022 14:47:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8345CF80162; Tue, 15 Mar 2022 14:47:38 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 277C6F80095
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2022 14:47:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 277C6F80095
Received: by mail-wm1-f46.google.com with SMTP id
 r190-20020a1c2bc7000000b0038a1013241dso1541571wmr.1
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2022 06:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=cUb7Ym7YiBit1oW7mIGdDtc855Srmaz5LFm1bk92JDs=;
 b=KBGrT2IhqL94/lS+d7VtgcJ9dfofDUizB6vjRLspvmWLz3NF9BI6EE44RvHYVKENpZ
 q6iKMrHymJ5zOjNloGnj8tuogzBdwOWDQY43WuRIyiCFguD/UIeqpxEi/ndWMkpFCXVu
 Wz04nrKJ1Kk7jgM+dDbMMaRFlv8Dsp+usJoPNdgJBHFRK4BxSIujSgnzj6LG4hdMivmp
 DIN/CJX49eToucO2w2qwwj3yQ2XIDjvpgGpEi7dBpXC6qDDNRjyEUabMXzFH2BXENUR3
 n2mLCuhh4ZYELAVzA007oQxmGOXfNcbm3SJCra9cfeC2eckelxVfHw2lt0QWfyuDl4VG
 6f/w==
X-Gm-Message-State: AOAM530JXvJmmaxQZrO/1rzc8pC2Ay0SXes7TEh+cbCMPI0mJjhbnNaB
 bgOuUQfnUM8PrRs5f8ZBDlg=
X-Google-Smtp-Source: ABdhPJytT3AnIUgNmrWcCS6eglCCV+Fc0mjQURGc3W7lyrFTalBhR8Aju7XTZqMSC2tY0lfe/6nBxA==
X-Received: by 2002:a05:600c:4f47:b0:381:6c3e:19dc with SMTP id
 m7-20020a05600c4f4700b003816c3e19dcmr3423857wmq.155.1647352055447; 
 Tue, 15 Mar 2022 06:47:35 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 e2-20020adfe7c2000000b001f04d622e7fsm15562748wrn.39.2022.03.15.06.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 06:47:35 -0700 (PDT)
Message-ID: <90024a31-ea50-74fa-1ad2-db6c1db99fef@grimberg.me>
Date: Tue, 15 Mar 2022 15:47:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] [v2] nvme-pci: disable write zeros support on specific
 SSDs
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>,
 Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
References: <20220315132059.12747-1-mark_hsieh@wistron.corp-partner.google.com>
 <20220315132202.GA12452@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220315132202.GA12452@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Mark_Hsieh@wistron.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 kbusch@kernel.org
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


>> Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
>> Write Zeroes command"), Micron has the same issue:
>> [ 6305.633887] blk_update_request: operation not supported error, dev
>> nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>>
>> So also disable Write Zeroes command on Micron.
> 
> This still ignores all the questions I've asked.

For some reason I cannot find the original patch(es)
