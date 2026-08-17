Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB466C5DF70
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:00:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D3FC160288;
	Mon, 17 Aug 2026 19:00:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D3FC160288
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786986038;
	bh=ga5KGyGu15o7XHyaaccHPzu88D3oZ51NGeguwUoAA1k=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=d/uy0+NR1x5wqSLJW1PC1pOLBG6QI/6/DFXQkhexGKGc3xnfAvBdtbYGAUIWeV704
	 uzD9DA8IGOuqhkAZxlcqoBFjsoJ5j7ZXIu9ORW645klKmr+7to0zPvc/hK2jbhRZxX
	 4GIc9uycj+VS2v3P2D61z89PBsCPSbF9n0UUCtTA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 72FE2F80638; Mon, 17 Aug 2026 18:59:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F5A4F80642;
	Mon, 17 Aug 2026 18:59:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D120CF8047D; Mon, 17 Aug 2026 14:40:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1786970428;
	b=PftaCwlgeICpR8iPC6KV+Ajwfn02rG/L0UkTWj5vjBeNttd6feYXDCyt/D3eYGDnapQe
	 ddH2E1X5HXhQXuBmscRL4h/8Keiah2zD1FZgQmpPLyRJZw2Ac2o3z8P+1FI0Zn58NY+lb
	 WUqbG5CESSVaq9OXHrSXzhUJ54xC1s5CUyxWnF2f4wjFvmE/g3nc3yiC7Pch8aFoUyV1D
	 6Sy4n8CeksLnIXPheXuRBQ4V4XEe76MJD2+bOGBjRG5Yr87T41el1R6kNrHxbcewCqsS3
	 /iLdfTTqZSvA0HOG3ifDOjRWLlq68vRIJ33U8ceXJz2pK5mjRBreH5wST6E1rvDE5Bw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786970428;
	h=DKIM-Signature:From:MIME-Version:Date:Message-ID:Subject:To;
	bh=ga5KGyGu15o7XHyaaccHPzu88D3oZ51NGeguwUoAA1k=;
	b=KYTNgFg3usQpsm44udJqHsZdO7z1ePD+87cEIudf0+8GC/kOleS/2s92D8KNOs3wi5A0
	 DhUAjjTJ/A5QcHfqlkoeRoL+CoglFfInsLWnTvsQvbLLmovsVrf4tLBgnfgiApCBNrrBw
	 0aFP0hoE/KoZ4KuCTJmX/ATLQqsMlo25lhZieqGtQ03fO9nQyU/Lwsb9RbmLrHZz/cjX2
	 qiDBvG3gDOZo+NzmVdbBHOBETsJbAk2v9ihpz+BPdlLwH4C+6ETQ2cJUYi/UOHTk5qQMu
	 hnrHKG+0+v1/q7d71QEkBkPRO0cvIKuZZw1G3hp2f4fs7MPTMIMwvNiYssbYZb32SgQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jrUT1pXQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 33357F800FA
	for <alsa-devel@alsa-project.org>; Mon, 17 Aug 2026 14:40:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33357F800FA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jrUT1pXQ
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-66c70d1672cso3351803d50.0
        for <alsa-devel@alsa-project.org>;
 Mon, 17 Aug 2026 05:40:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786970425; cv=none;
        d=google.com; s=arc-20260327;
        b=IeH6jRb2x1GjOg1qZZn0MDI7Ff09HFsRlSc/bKOdyFekXgVED9IBSlYojtGms0F4wH
         J5Gplk7wOqKEFV/MKUD5bWskcxjs4XgtBFs+Itpck7W0OzPyMD44PAAHxqwxiqeVTtE3
         eIKxz78tQWjZzzvTkPcOuHUcSA2GEbDxGqXfKgbX4vfaj8gD8r8mPhzqzbKrygzXVjgp
         Bpv82V5zCa1I6nIIRqAZnrF6ZTwmTP+oD3LMB5amGuZC+D4ZBlgWwY+9qSkKsEqKAbWg
         8PUaHUpzzJvprBXYPSBHG+kwveqRATZPSNG0bo86WL+7QVrSgdlIFr0P2akeKXwM4I/W
         5AUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ga5KGyGu15o7XHyaaccHPzu88D3oZ51NGeguwUoAA1k=;
        fh=cDKQSYPH2+UCdEvD83nAWW3POs3QANwyLPhYBP3zVPo=;
        b=XuuPrkQqLisqj97EBGoCAG1EWCFvicZfdzZrgfMXZ+MhRaiHAKEkLLI+1HOKShEZEN
         +Bnw2reHtB9hEPlBso3OrTD8/7l1yjJqabNWUdc5Y+g4VYYSrr1MvGEFXOfH40mLEjaE
         cr1mi5IfFCcJoMIEJ+xBIQI4+wwVmuBvZ1ofjOWynRQjBDfEDYInfvrRZqEsfmemcLBN
         x/uhjFVuTOjm28YXysY4DakBSQH6eENcRSLMT8gxZSJ9Q0374LSWcyvKmPRLCafcqdVH
         Brhv1kcTUx0/Yfp/Mg7sfizCL7W9sRBE6SK6QjkfH4ydAq/k8eSoWOD6bn+6sxqrP99u
         mUJA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786970425; x=1787575225;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ga5KGyGu15o7XHyaaccHPzu88D3oZ51NGeguwUoAA1k=;
        b=jrUT1pXQ832T0VUlm7dUV1dxfD60UbFpAKRAiHQgxw1P1r8FJJvfiPW5Ugq9Tnsi49
         TXuRRcBB/dH6B0QSfQoq+NtXjNEnavIhzXyZ8vPICAuJJdDwG2cOMb7EQ85PLKaREcA9
         CUaHj79R/tg6bbJ0IbqB5auwBuhhOjwefkamMUyOQLT/beHN74vYDEj638xsJLKS/u5C
         uFykltYYDQeL9zcH+zktvVo3jKy1q+AUBZWQYzD0zcDzp1J0ebmRzAtDTA4hByTtebCe
         SZ8c5UdEETPTjnKT0Ey6fzycpY8P+3ynYhXmu0dYYpuaPZzIR8Ea7m6agiSXJDmhd7jb
         B32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786970425; x=1787575225;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ga5KGyGu15o7XHyaaccHPzu88D3oZ51NGeguwUoAA1k=;
        b=JNTR81XbHDOVDL57fH51rMOJml8RsMHcxx8M440tajvCXxNEX8mpi4wqd86/NCDp6c
         nT4rM1AsAZafVo9hHQj+yeguzegLdSg5efI8LHygcAFDbxToLeJYaouW2XDG+kVwbOhU
         tmCnqzrLlODZ0TdktFFkbNraG8t+TyqQlZ0Nm1lmva8PS12PhLEl3UYXU9hDvpnEDt8E
         2aQ33UJafLgtZo23wgZ/Tx9AaAqvax1Lq84rH8odr7nMvV2wAccwUEs2pKnexcCQl495
         JdOQ35uGiigEEg4ON3sg3cJKl4sLVeF0CyqNGVIK7IyW/4/+YbQ4cnAHq8XYaztvHm1A
         MPbg==
X-Gm-Message-State: AOJu0Yw8oNwrCg45bBKU7hV7FDOuqFrSd24ghZ9WtH5oTJlKdJBCkoCf
	WSWm5qDKAFDNxqv7vFhVwIITvGCmKZgfguRWX77pG1EA+PnKii2CcnYbIjg7jpmyj+ZKiaERwxk
	g3m7RIDxdwnLBzZL9cqVT+NRwVN4iKm0=
X-Gm-Gg: AR+sD12Iv8rE/yUQxBdYRZBaLaML9NwkRrcFMPVTt6/t5ATJyvUwHaGT1LqEXJ7xdZ0
	KI1ayMrceUGdEHOSRVBaYbnE55zGe4/8EZIf5ZiPoRB2ZyY3FZJC1qmIqEruJ1o57O+rX5g9pn3
	pl2VGI1JmXmMJhCytv5JZS45tTApc1IWG0zr/vr8IPfCaA+rF9aztc+iZneOOYn2x1hDKuY7iGq
	8Bjqt6KVWZEPvAu7RpBDpgjv9V07ZS24lf4qRcEVamQj0kg2AUBC4G0GlbFfWSYI4VMapyPHlTZ
	SyKYtyRcdVKlWBwHrosBT67/JbTP7WRMnwm2ua6aymnbgutu++kUkBwUttEIiA4A8lex5rPpTxa
	gKP2aIAAncb7mMRvEa6zunGkE2lMebwcKBF+7EbAhgjYt
X-Received: by 2002:a05:690e:406:b0:667:ba5f:e326 with SMTP id
 956f58d0204a3-66cb9ea72e6mr53659d50.38.1786970425296; Mon, 17 Aug 2026
 05:40:25 -0700 (PDT)
Received: from 595171893313 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Aug 2026 07:40:24 -0500
Received: from 595171893313 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Aug 2026 07:40:24 -0500
From: Gemayel Lira <gemayellira@gmail.com>
In-Reply-To: <000301dd2e36$f0cc5ea0$d2651be0$@opensource.cirrus.com>
References: 
 <CAD96ZT+SnRnGr4Xd+NJkkVNpj8XrzL3Ete=pRgz05mqxAzbU2w@mail.gmail.com>
 <178683053096.110591.14424183767747622650@gmail.com>
 <000301dd2e36$f0cc5ea0$d2651be0$@opensource.cirrus.com>
MIME-Version: 1.0
Date: Mon, 17 Aug 2026 07:40:24 -0500
X-Gm-Features: AcwNN1VMjJIKO_UGNk4KhjJd_ZRYdUgtnYv9wV6a2Ak7CubS90k4IUJq2E9cHbQ
Message-ID: 
 <CAD96ZTJFVXau-4o7gs=LbKzF3UKduzenqhV1Pv6Tnjf3KwCvZA@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda: cs35l41: Enable VSPK on UX3405CA when ACPI
 leaves GPIO1 unused
To: Stefan Binding <sbinding@opensource.cirrus.com>,
 linux-sound@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: gemayellira@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: TNEAVHU3UAWMGNNJWGVLUKNZU6556YLP
X-Message-ID-Hash: TNEAVHU3UAWMGNNJWGVLUKNZU6556YLP
X-Mailman-Approved-At: Mon, 17 Aug 2026 16:59:40 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TNEAVHU3UAWMGNNJWGVLUKNZU6556YLP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Mon, 17 Aug 2026, Stefan Binding wrote:
> Please create a bugzilla ticket at the below address and CC Cirrus
> Patches (patches@opensource.cirrus.com) to it
> Please attach an acpi dump and dmesg of the issue to the ticket.

https://bugzilla.kernel.org/show_bug.cgi?id=221896

Thanks,
Gemayel Lira
