Return-Path: <SRS0=ZrTp=W5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8479EC3A59E
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 15:23:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6762087E
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 15:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pC3nUCXw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFFi1AKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6762087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3554616DE;
	Mon,  2 Sep 2019 17:22:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3554616DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567437817;
	bh=cw8AfC4jRz9JzyPxodmOCmLfwbDnp0IT1grpuJd9v1k=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pC3nUCXwzXgOl1PAoaYoOi/GnVXYPSHC8OLvqMmlTU6WG8oefR4k+xMzIs2aG6pAq
	 8Wsprom35JIQW1uWSfsNfzceuwGrfvgf7BOSvffLOo91S9d8io4SK5yiOv/Lp7Bh+P
	 ibhbxJRvKpnTqRpT14pCQjQviz51xf6f63zoxfl8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3289EF805FC;
	Mon,  2 Sep 2019 17:20:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F06FCF803D7; Sun,  1 Sep 2019 14:58:14 +0200 (CEST)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 221EAF80306
 for <alsa-devel@alsa-project.org>; Sun,  1 Sep 2019 14:58:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 221EAF80306
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="mFFi1AKP"
Received: by mail-wm1-x343.google.com with SMTP id q19so2993236wmc.3
 for <alsa-devel@alsa-project.org>; Sun, 01 Sep 2019 05:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=UxrLHy0xZer5ID4RHyuCqHzVGteGB4HlcmZdUjqBSL4=;
 b=mFFi1AKPSaWngSR9jtj9CgHSiMvJGrF/gJcubSZhAcKoIP8k1Tn8h0Xb2H4MMpoY98
 ATkbzsIdx1azRsSUQ70wuqo1zjiARoeps830lySXrbXba0w/4YFfdVhXcwZWkp0fwtZ6
 4WglBbXxLbyMehj5WsfIYCts15phqU9Ikqg/BP4/TfHTzcM2JNPQJypm7uNUOziVH0sZ
 fXFLOcK+r3mR7aLL1ySTmKoDMh11++IJL8l6Zqo6fsPJK95dJqStyWxcu8GDibJGBIRl
 JWlw3CgAMpfVSNAYHeq22BCm/95o+gxuBq72xJamkbYhxobYL6BUwc31VcC7CDbf30pO
 kV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=UxrLHy0xZer5ID4RHyuCqHzVGteGB4HlcmZdUjqBSL4=;
 b=LiyBjhJo5nZfj6CBoFIgeDvbzgjZbuG7U7fQz3a+tlW1rpbvw4dUYHSw5kVyRHSDtL
 wbDoSSD7JO30tpP4w9odBF6eMv3G+y/lxo1E1CP9DZFJZrwZ9HwlHOib4fCjE5JifJIg
 xVxQp6kDFVJ6DOFVXPdMxV5m/yxM0zoa5BnPeMa45cFJ0PAyY6P/SyUie6SJZF732+Fx
 3+Pazk/cORewIo003teQsOBDiEWxOnY5G/8G8zaZqrx3YpkENPZ/fe0Jdy4u2R5EDRGB
 xQ/Iwu+wwjqirnT4y9yjjpqRQkR8H9V5U7+4UHZsXMhjof5l9bZdeFhDTE8tRb9s0Zx8
 cvBg==
X-Gm-Message-State: APjAAAWltcSsvAhBipVSeO8nDEZL7Fp5o/SsLyuWuasOkqWZ3qCm6m3B
 OXkfDsHFbVmtkwyor/CWoyw=
X-Google-Smtp-Source: APXvYqwpCH+B/lBvHkPsK4oranhfJRg2I6GN/bqGm9Vi9ZAArUYI1ZCHKIDT0o2hYlbk+wWuHH2+QQ==
X-Received: by 2002:a7b:cb8e:: with SMTP id m14mr30808692wmi.10.1567342691150; 
 Sun, 01 Sep 2019 05:58:11 -0700 (PDT)
Received: from eldamar (host85-134-dynamic.30-79-r.retail.telecomitalia.it.
 [79.30.134.85])
 by smtp.gmail.com with ESMTPSA id r190sm15294524wmf.0.2019.09.01.05.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2019 05:58:09 -0700 (PDT)
Date: Sun, 1 Sep 2019 14:58:09 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Hui Peng <benquike@gmail.com>
Message-ID: <20190901125809.GA23334@eldamar.local>
References: <20190830214649.27761-1-benquike@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190830214649.27761-1-benquike@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Mon, 02 Sep 2019 17:20:12 +0200
Cc: Mathias Payer <mathias.payer@nebelwelt.net>, alsa-devel@alsa-project.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Wenwen Wang <wang6495@umn.edu>, Takashi Iwai <tiwai@suse.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH 1/2] Fix an OOB bug in
	parse_audio_mixer_unit
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190901125809.ZycIIK7i7z-DgPFdNdaKZVjqIuuU2WcWeYph8k-zfBU@z>

On Fri, Aug 30, 2019 at 05:46:49PM -0400, Hui Peng wrote:
> The `uac_mixer_unit_descriptor` shown as below is read from the
> device side. In `parse_audio_mixer_unit`, `baSourceID` field is
> accessed from index 0 to `bNrInPins` - 1, the current implementation
> assumes that descriptor is always valid (the length  of descriptor
> is no shorter than 5 + `bNrInPins`). If a descriptor read from
> the device side is invalid, it may trigger out-of-bound memory
> access.
> 
> ```
> struct uac_mixer_unit_descriptor {
> 	__u8 bLength;
> 	__u8 bDescriptorType;
> 	__u8 bDescriptorSubtype;
> 	__u8 bUnitID;
> 	__u8 bNrInPins;
> 	__u8 baSourceID[];
> }
> ```
> 
> This patch fixes the bug by add a sanity check on the length of
> the descriptor.
> 
> CVE: CVE-2018-15117

FWIW, the correct CVE id should be probably CVE-2019-15117 here.

But there was already a patch queued and released in 5.2.10 and
4.19.68 for this issue (as far I can see; is this correct?)

Regards,
Salvatore
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
