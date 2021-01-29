Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D78C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 16:13:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31E364DFA
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 16:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31E364DFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F041168D;
	Fri, 29 Jan 2021 17:12:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F041168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611936795;
	bh=I0fRoKPWfvderx+NujXuHxtsfE0ddkepDKfLnDptLZs=;
	h=Date:From:Subject:To:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jggsg80l4iT8WjtlQvdplWtzm23D/ibj621wdDytIN1ihGLmH0WX6TNCgQ6QvB+GJ
	 GCn1hxKNXTzAXts4nGVUa5VysclUQ+KORO31MW2T6BBsiP2/vuAoW8rY5m8hspMc1n
	 kanWiX37BtC63KHoQt82CXrOPQcA6yAX51DEigdU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C23F8F80218;
	Fri, 29 Jan 2021 17:12:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 19FE2F80259; Fri, 29 Jan 2021 17:12:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 68ECEF80130
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 17:12:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68ECEF80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="cAT/+gg+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611936738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C73EcF+cPgkR5uyr0CTwjqsZxOonqnQShiZQJcCQUEk=;
 b=cAT/+gg+7Sujcf2YLLrqxS7ICDNnme02La3qnOCbnBnsvAKFXlzD+RdT1oz64EsHHcjztM
 6kKCXw8aO/Fk1iYhwwUwJZQnUEnqgZSsDsUgEc16rzQamxlNOzqGTZDw5AlvsF2bMH28Y8
 rUBYJNFT93SJ3B75EQVpM+1fovIRqis=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-Ozv6HpndO_KjaPeCV-ozkQ-1; Fri, 29 Jan 2021 11:12:17 -0500
X-MC-Unique: Ozv6HpndO_KjaPeCV-ozkQ-1
Received: by mail-il1-f197.google.com with SMTP id q3so8000687ilv.16
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 08:12:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
 :references:mime-version;
 bh=C73EcF+cPgkR5uyr0CTwjqsZxOonqnQShiZQJcCQUEk=;
 b=kmSQap0DnKmxRkroZ9Ubst01Z2n5cHy2Wz8CNgVcuPeS0V2pFO5ZC81mdrC7eMeOlP
 Wr5+b0qasmE9swEYEnz6Drte9OCB8oP0Iun2aDnDayx/6JoKOF8uLJwSmOdyrkxJJDjp
 8ex6PXy2/lKS2GaY0nVISVzjYVg/DunJcCgHe1lnwVz1xAUgSU5Zd3bmalYCCBytBYao
 sIP1/+KdBDr4vt9z0NorzLUGbjR/4dCHzFyuyWAnczRYqZfxdfOXxT/JDGBB/A8qux/8
 fdg0hdqplucPoLNExlt2HcvyjTGrFcRgLYFlIhA7ReHK9k+JN+cDNdXoVmm9uQIRhFNi
 tQyw==
X-Gm-Message-State: AOAM532i0r5B6P2jGyskrAd2xz6YVHVFV1O67BTXpSoNEhMZNXYHJs8V
 ov/vbj4CjQAn0YKp1XAK2GEh26CqgwvXuwcEXjdDZFMgNryvdlrclhtvFiQgbTLZ8r74Gr5Dr5A
 iXTcX5JSTMP8FRQInsO128Oo=
X-Received: by 2002:a02:5148:: with SMTP id s69mr4291156jaa.8.1611936736533;
 Fri, 29 Jan 2021 08:12:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsT8S9p/QXv0Fcqob/nmdlEY5TBGgLu24B/QJNqz178h0gmXk57cqX9W6Vh5Lu0HykKf2vDg==
X-Received: by 2002:a02:5148:: with SMTP id s69mr4291119jaa.8.1611936736230;
 Fri, 29 Jan 2021 08:12:16 -0800 (PST)
Received: from chargestone-cave ([2607:9000:0:57::8e])
 by smtp.gmail.com with ESMTPSA id d13sm4262265ioy.26.2021.01.29.08.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jan 2021 08:12:15 -0800 (PST)
Date: Fri, 29 Jan 2021 10:12:08 -0600
From: Michael Catanzaro <mcatanzaro@redhat.com>
Subject: Re: [REGRESSION] "ALSA: HDA: Early Forbid of runtime
 =?UTF-8?Q?PM=22=0D=0A_broke=0D=0A_my=0D=0A?= laptop's internal audio
To: Takashi Iwai <tiwai@suse.de>
Message-Id: <8CEPNQ.GAG87LR8RI871@redhat.com>
In-Reply-To: <IECPNQ.0TZXZXWOZX8L2@redhat.com>
References: <EM1ONQ.OL5CFJTBEBBW@redhat.com>
 <BY5PR11MB430713319F12454CF71A1E73FDB99@BY5PR11MB4307.namprd11.prod.outlook.com>
 <U3BPNQ.P8Q6LYEGXHB5@redhat.com> <s5hsg6jlr4q.wl-tiwai@suse.de>
 <9ACPNQ.AF32G3OJNPHA3@redhat.com> <IECPNQ.0TZXZXWOZX8L2@redhat.com>
X-Mailer: geary/3.38.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mcatanzaro@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: alsa-devel@alsa-project.org, "N, Harshapriya" <harshapriya.n@intel.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, kai.vehmanen@intel.com
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

On Fri, Jan 29, 2021 at 9:30 am, Michael Catanzaro 
<mcatanzaro@redhat.com> wrote:
> OK, I found "ALSA: hda/via: Apply the workaround generically for 
> Clevo machines" which was just merged yesterday. So I will test again 
> to find out.

Hi Takashi, hi Harsha,

I can confirm that the problem is fixed by this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4961167bf7482944ca09a6f71263b9e47f949851

Michael


