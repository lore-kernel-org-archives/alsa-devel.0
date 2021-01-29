Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057F2C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:31:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF5D64E05
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 15:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF5D64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 671AA1693;
	Fri, 29 Jan 2021 16:30:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 671AA1693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611934286;
	bh=DvBI0NrwOKevtmiqJ/sX4MFwkmqIWlbdUU/Ed4ALxIs=;
	h=Date:From:Subject:To:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SldoftlQ7jw22kaLXK1hYHaONGAmdYLFEp3klycCERjpzlPKZSXxDroCq4rBkRqHM
	 +kcWXXt3XgSGe74UVMfy279Nq/isQB8MkA3UA8oy0diZOE89/HYDgb/tFmBNREMe8h
	 tVV4SWa44cVP68I6jt5yeGFu7A6ESirfQIwfs2hk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A8F3CF8025F;
	Fri, 29 Jan 2021 16:30:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B0CC2F80259; Fri, 29 Jan 2021 16:30:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DE039F800E9
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 16:30:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DE039F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="hlbvVHMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611934230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ka2wPgKXomym3nApRAKGMQ8ACUqXI7rn+t9zdTyvT3E=;
 b=hlbvVHMCVa0ksspvHjtJW9ncbMeRdnLjroFHklH5yq6eMbQVuJoDBTPfGaNEnC+ne8zh7g
 SqjEiUXwzYBMcsoUwBQ/7fFgg87X2kXSjpU20Ae3GRPzwngg6Fj6fEbffwXjRqvuQJFleY
 Zoq4g8tZCZaMMTapBYKyiHl3tblI1yM=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-FJdzlh9ZMra200epSvZ1TA-1; Fri, 29 Jan 2021 10:30:28 -0500
X-MC-Unique: FJdzlh9ZMra200epSvZ1TA-1
Received: by mail-il1-f200.google.com with SMTP id n12so7928790ili.15
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 07:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
 :references:mime-version;
 bh=ka2wPgKXomym3nApRAKGMQ8ACUqXI7rn+t9zdTyvT3E=;
 b=ALZx5LXCRgPkAAWZE2t3R4+wQRwAA7WS3odq6R1VUjQ+i8FFSX0My6U/LsdfecM9yf
 XHyu8EDJB3BjaqKbyS+Abe8l61He0RF9bTpA/Rm5QnX5F/YYPIpXZIMkJVeVe1Jy8W/+
 ZWhrkW6QYAjzSsNC8JaXbR5EFvCAMT8H84f3hNeYYy9tecIZPwB4LXzwbZ5o2uD04tq0
 ddnHIVVgI/s87HQNZb3b6epwwTfnRTCnTkzW6668s0p3+WVsNHQTxc8JGFkOdBWOOyAT
 y0ll13ZZ1J6PaO3HFPnAestzRDS+yzIU+76kunjStvvkgQQShzR14KU1ShB0j0jIqDGR
 la8Q==
X-Gm-Message-State: AOAM532YCsij5LARrCfIT/EL3yDe9v8ms4cFhpiuFIDyaj94zVbfKe9g
 YZyp7mPUnI7f0iHBfVpIGcfRf9ugkcBERUYMB302OvaLfe8/NyzEh/kYU1dJCUMIcQ/XpyxYkxk
 +4MObb4dObTmOqtrTTzN98Ks=
X-Received: by 2002:a05:6602:4b:: with SMTP id
 z11mr3879781ioz.47.1611934227456; 
 Fri, 29 Jan 2021 07:30:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzexA6coagxlMzdGZuJFToChiam80G7Oa6y10AmBF4tAw/niRldya+EwE2RFSzK/tg5xZvXRw==
X-Received: by 2002:a05:6602:4b:: with SMTP id
 z11mr3879774ioz.47.1611934227319; 
 Fri, 29 Jan 2021 07:30:27 -0800 (PST)
Received: from chargestone-cave ([2607:9000:0:57::8e])
 by smtp.gmail.com with ESMTPSA id z87sm4754732ilk.40.2021.01.29.07.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jan 2021 07:30:24 -0800 (PST)
Date: Fri, 29 Jan 2021 09:30:18 -0600
From: Michael Catanzaro <mcatanzaro@redhat.com>
Subject: Re: [REGRESSION] "ALSA: HDA: Early Forbid of runtime PM"
 =?UTF-8?Q?broke=0D=0A_my=0D=0A?= laptop's internal audio
To: Takashi Iwai <tiwai@suse.de>
Message-Id: <IECPNQ.0TZXZXWOZX8L2@redhat.com>
In-Reply-To: <9ACPNQ.AF32G3OJNPHA3@redhat.com>
References: <EM1ONQ.OL5CFJTBEBBW@redhat.com>
 <BY5PR11MB430713319F12454CF71A1E73FDB99@BY5PR11MB4307.namprd11.prod.outlook.com>
 <U3BPNQ.P8Q6LYEGXHB5@redhat.com> <s5hsg6jlr4q.wl-tiwai@suse.de>
 <9ACPNQ.AF32G3OJNPHA3@redhat.com>
X-Mailer: geary/3.38.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mcatanzaro@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: alsa-devel@alsa-project.org, "N, Harshapriya" <harshapriya.n@intel.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 kai.vehmanen@intel.com
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


On Fri, Jan 29, 2021 at 9:27 am, Michael Catanzaro 
<mcatanzaro@redhat.com> wrote:
> and the problem is not yet fixed there. If you suspect it's fixed by 
> something merged in the past two days, then I can pull and try again.

OK, I found "ALSA: hda/via: Apply the workaround generically for Clevo 
machines" which was just merged yesterday. So I will test again to find 
out.


