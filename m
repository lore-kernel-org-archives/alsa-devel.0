Return-Path: <SRS0=vr1N=NB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3BAC4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 15:11:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15E260C51
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Aug 2021 15:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C15E260C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2A6A84A;
	Tue, 10 Aug 2021 17:10:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2A6A84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628608261;
	bh=gtIOF0vg8Qh1j3Jq/ciBXoumlyrgqhsCiCBSlHEamfc=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RRolvLW1t8aXliLUN7Hrx0ruuTCmN4/nlP9AmDoOfUWOdYD7N5bDe0biLScuNIORU
	 7gQYc8LjNVvlry6jWU4L4DbYLQ00mSQuVP1D89BP446K2NJoDLaW9vXVFPnbfJc/DK
	 fLYsORRs+j/AWca35EH02xCI03Q3LrMSP4oijDxc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A6DBF800C8;
	Tue, 10 Aug 2021 17:10:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A17B1F8025D; Tue, 10 Aug 2021 17:10:06 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3902BF800C8
 for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2021 17:10:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3902BF800C8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="G2FTdSoH"
Received: by mail-oo1-xc2e.google.com with SMTP id
 z3-20020a4a98430000b029025f4693434bso5418161ooi.3
 for <alsa-devel@alsa-project.org>; Tue, 10 Aug 2021 08:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=g0I9IMGbZ0SJcY7Jg/RCs/PLaYfCHkgjx/KEvzXupe0=;
 b=G2FTdSoHCshVXI9EbAtPQDtCbPILnchvSE3uXzXiIg9EPCXL5goRBz518+ibZB19Mp
 K5QKWtDDuojbx2RxhQ5SHJCPqENrLJEbxkLH6l8cL/hibe3WJKo2/LRnYRmVXI8n+OiE
 pR9HI6tWKHNZb76+4hEG/G4UiP5/Hwpw8hLOqZoVIeTUOnVMo6VaKkZbI9KXyWzAWgJA
 cXb7wOhlzzIq07e2nr+mcluuz8YZqX0H5v8mjeVZU5pteziU5uMYhJpLjMHztlOqiBqy
 tv5zVqrdHvXrHWOauJKNO1HkZ9nUIsX1g6p/avF9VWcKXMyIdyxAnWwpoW4JnrDo+YHY
 ZTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=g0I9IMGbZ0SJcY7Jg/RCs/PLaYfCHkgjx/KEvzXupe0=;
 b=k/WLdPa7myHb7XKwHF06So+XX3Fgj22j8BvDF2k9zrHiYtdXTzjs8YrN7xDa/rxKhN
 cnLPPXop+oLX5ifJUExK62i7vnwNDLJ56wrA2W3JU/cXmFbNBsUpKIIBWlDKpdJ5MZ9I
 EWfDImuf8WtQ8Kq0PQuSOIRQbwFYw4OXOnPpUP56iqAo7Ssh/8DjIdF2ZH6vDy7iTHwJ
 NkR8oNGM2z+ETl+JqD6ORdnP0PDu0hbOrUv9/aGox1ts3mSKIpgcaneObOFe7Jdc9gNz
 Y6TIPE79rVaMBhRvfXpZsZKRKVLx507lfWRJ4u7OiZD4OAy4+SjG+5nen2UK/HBO2Mgz
 zfyA==
X-Gm-Message-State: AOAM530R0ZvRkhE6UWMtiY88qQ1jLF8q0evvEmfqmLZ2PGwuSy7gK8EX
 fRXOQfc2zCOYjbsKHCteBuOwLM2BOBvpp62/eZA=
X-Google-Smtp-Source: ABdhPJxP/RVz2hQQZZPWL9Z3NRvn08BFeLaliK0VVBpI0fnEkXlNivlCCCc4LQqq4DeF+45dM/IPf3R0qpuFVdoQfig=
X-Received: by 2002:a4a:41d2:: with SMTP id x201mr7281522ooa.71.1628608195140; 
 Tue, 10 Aug 2021 08:09:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:7d93:0:0:0:0:0 with HTTP; Tue, 10 Aug 2021 08:09:54
 -0700 (PDT)
In-Reply-To: <20210810145018.24001-1-youling257@gmail.com>
References: <20210623134601.2128663-1-imre.deak@intel.com>
 <20210810145018.24001-1-youling257@gmail.com>
From: youling 257 <youling257@gmail.com>
Date: Tue, 10 Aug 2021 23:09:54 +0800
Message-ID: <CAOzgRdY6cYCyezHZD-GQptgN2-1CNeNm8PSGtjN7mSEb8kQ7Pg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ALSA: hda: Release controller display power during
 shutdown/reboot
To: imre.deak@intel.com
Content-Type: text/plain; charset="UTF-8"
Cc: tiwai@suse.de, tv@lio96.de, alsa-devel@alsa-project.org,
 intel-gfx@lists.freedesktop.org
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

my 7820hk sound card is alc662

android_x86:/ # aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC662 rev3 Analog [ALC662 rev3 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 7: HDMI 1 [HDMI 1]
  Subdevices: 0/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 8: HDMI 2 [HDMI 2]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 9: HDMI 3 [HDMI 3]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 10: HDMI 4 [HDMI 4]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
android_x86:/ #

2021-08-10 22:50 GMT+08:00, youling257 <youling257@gmail.com>:
> it cause my intel 7820hk cpu failed shutdown.
>
