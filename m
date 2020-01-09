Return-Path: <SRS0=ks7i=26=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADC7C32771
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jan 2020 05:12:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA21E20678
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jan 2020 05:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H2/wjrbz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="VBLEGYkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA21E20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30831174D;
	Thu,  9 Jan 2020 06:11:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30831174D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578546768;
	bh=w8M5T2aYflG4nPkxPefenu9zg5ILPGU/tLmxe3miFKM=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H2/wjrbzlz1fxWHsa4V5Rwh5A9ErovKb/SMX6a/CjJxXor+CStkLhItTSNq0NuF7/
	 SdTV6/O/TT4mFSRqEihAYprz/U9EKzxerNzaDgNcvNb/f5jVzQoMSD3O+3jbUsRJJK
	 F+zk0HHvyAd4+ZWdRi75JL65BNR95hU9cBMZM+O4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 870CEF8014E;
	Thu,  9 Jan 2020 06:11:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3DFAF8015B; Thu,  9 Jan 2020 06:11:54 +0100 (CET)
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96C2AF80101
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2020 06:11:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96C2AF80101
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="VBLEGYkd"
Received: by mail-il1-x142.google.com with SMTP id p8so4633898iln.12
 for <alsa-devel@alsa-project.org>; Wed, 08 Jan 2020 21:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UfHlaQy6US7aBw4wjE4YMzRfD8j4wvVn9C/uKXknGvE=;
 b=VBLEGYkdTZtdqR94sj6Tjf0h7XJq62AIYsTyd021wihafB/YFnQabl26zlE6suDM3b
 YDoyoxxzX/u6qN8yuTxaZE7sLz5INyP7B2NVAKQbaOU7p3+SRqtKHOLSel8BnW4EvEmL
 HJVwLSrnwsWoy2OT6r+FzNg3Hb7kHcxo6X5QyujDVSPzL+TMS6UJ0D+23U6qH8FJ+O6X
 D2Mqip21qT/RzMp6BncnERjzOwUsWoS9AjuWBmAr5AhrAiQONi/7eUzgjF8PkTH1JsCg
 P+6CaXE7Ir4pSrKnQRBuCewXmK+CuwIUj8SkT9sHuobdiK8s38RXGkToOdIhZeygll+8
 ZIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UfHlaQy6US7aBw4wjE4YMzRfD8j4wvVn9C/uKXknGvE=;
 b=byQuVjdqQ/NqXtNYfV5p20aDWalOSsYHtB/VrsA/RJ5ZE5x9eUPZmwppAN09NpJlQQ
 qzlxX4G5um1KbtFcORjbMcqM5Jp6+eflIia/Z4VOmV7nqdpf6rYNikekn3jGo5Z4MAXa
 aEYogbbyCcR+6ZsV6x+pb9h0F67EmVFJw4RniG9A0ryXYw7OkSK8/j2RQjZp/3Wopx1Q
 pYyLBKjEeIQrkEl1SCD9ReUDXouIKiG+qIs4Yq/pWORVW83s0pNFrNAjZiIp0fATVVhH
 Q9G8jFYRHRUO46uqP/6o3ktgladiFxXIVsshV/wW4jp++yLXM1hvYgotWwci7gTsf3hf
 UDTA==
X-Gm-Message-State: APjAAAVGps4nbCEzVu9J7DFGT5voISS0bS6wFsK3Tdty7vU1GVBywUi4
 W7E16S9WC/WYRwcCqG2JzBISfgCVsejgvj3CDfInYg==
X-Google-Smtp-Source: APXvYqy6jhW/BWgmeQryfExSbB5ZZCHIWOH5y455b2gRqd8d/+uz2PUeTmV3LSSnzW9mzk+cRkzMj2Q25Jj/hNuJe7U=
X-Received: by 2002:a92:2907:: with SMTP id l7mr7102602ilg.140.1578546709305; 
 Wed, 08 Jan 2020 21:11:49 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200108115027eucas1p2abcd40e359e993e5b471229b02b69fc3@eucas1p2.samsung.com>
 <20200108115007.31095-1-m.szyprowski@samsung.com>
In-Reply-To: <20200108115007.31095-1-m.szyprowski@samsung.com>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Thu, 9 Jan 2020 13:11:38 +0800
Message-ID: <CA+Px+wUo7i331kEuc2mjE9uqSna7Lxnua=hvgPc+0T2YdeCgMg@mail.gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: ALSA development <alsa-devel@alsa-project.org>,
 Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>, Dylan Reid <dgreid@google.com>
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: max98090: fix incorrect helper
	in max98090_dapm_put_enum_double()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, Jan 8, 2020 at 7:50 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Fixes: 62d5ae4cafb7 ("ASoC: max98090: save and restore SHDN when changing sensitive registers")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>

Thanks for finding and fixing the bug.

The fix also reminded me: there are two possible "context" to call
max98090_dapm_put_enum_double( ): DAPM and userspace mixer control.
- max98090_shdn_save( ) is designed for mixer control because it
acquires dapm_mutex.
- max98090_shdn_save_locked( ) is designed for DAPM without acquiring lock.

Current code:
> +static int max98090_dapm_put_enum_double(struct snd_kcontrol *kcontrol,
[snip]
> + max98090_shdn_save(max98090);
> + ret = snd_soc_dapm_put_enum_double(kcontrol, ucontrol);
> + max98090_shdn_restore(max98090);

Should it cause a deadlock if DAPM calls the
max98090_dapm_put_enum_double( )?  I didn't see a deadlock last time I
tested the series.  Will do further analysis on this.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
