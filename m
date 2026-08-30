Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE699C61DB9
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Aug 2026 18:26:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BA016020B;
	Sun, 30 Aug 2026 20:26:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BA016020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788114408;
	bh=LP3UF63e6XUYrf48ULXKPB40fONzkw42BwUAzwY+Lj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Vvq0t4agf463xXtJpTBNLgLtjUcb+twgC2rF2MCm4Y2uRAK0zJNFSZX1Cxe9Su0aZ
	 Kshu/f1lnh35c6qfNcir3YwMji6lyC0QkBxssb7oLxFcHMWaLIDaK/ZmSwgNiS+qL+
	 Ox+fLL7e4GJGCRzfNHa36hxZc1NXfeDgJKW/qVoE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80673F805FF; Sun, 30 Aug 2026 20:26:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 064D8F805FD;
	Sun, 30 Aug 2026 20:26:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 248E1F80549; Sun, 30 Aug 2026 20:26:07 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=77.48.224.245
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788114362;
	b=QSBLuGldNzhrAGIgrC6eaG0783UY22Mj5nnL+i3AggQcMVKH+bmsl1Tn3iqbAgTmQhn+
	 iaQbMqFubrGcbn8t5G9INiP00H9we5Np4UV6EBBxdfCB8Av/cXch2Y+RQBxIynfmwbp3l
	 Vv7EFtYMFRvrE27FScQkd/Z6ZeM4T1WOHcyMzcXMooKwQ7dYFBN5kDbkCzfVooDNQxGo9
	 OLZB/MySRvNYYxo7vSKS1tFRRFEdxhC//lY2yqaJOvf46w1hrRDviDcV1WklE0VSAxELM
	 NpghJh+4AOdJCT1FUWbH4abePv9joesDlVXqWaKLr5GoU3bT+Ez9ZiYrlsYBuLrK7fw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788114362;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=LP3UF63e6XUYrf48ULXKPB40fONzkw42BwUAzwY+Lj8=;
	b=kcAItwKA3B2HtMerWa+o9NoyxA1YQ9jQ+OkXBf4guYRZlvEBXRVpGx7YhdRlHW0gHKfQ
	 rQGBhkkX0uNDYUoNgV0OlWH9k+3cWFezIsLEEVQN8MO64DUwCZ46MwNTdGRJVWXRhmElY
	 eGAcqUT4V/pRZpZ92DMW3NYKBImOIaULVtz60/m/0OObqMZwbWo3uiTHpJmf/kVAfXR85
	 wan2+CVqJrjNDOZNbtTXh0mwurmj8x8P1l+bhc3Ohlv12tJd1QgUwNDV4k75rCv00gbmH
	 XRWnmi8UspEsc3k3eGDs2t7HweIQpOgLur5B+to+Q539Ape8Y7vhCrGa7h/RV+GJLLg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=77.48.224.245
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DBC03F80448
	for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2026 20:26:01 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id A20B03D95C;
	Sun, 30 Aug 2026 20:25:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz A20B03D95C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1788114358; bh=/CgJQb9HcrAYgU6y4BtEvjw+/VBgrvfiG1soznR1nME=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JvRzqxog2SpGvmEUCtkhGF9+8UWURig3NTPdAoKzFGirvarLi2zmNvN9wNC/1assA
	 UujblfBNTqK7y16sMZIF9RDKa+V8taqFdKwx4bIMcXxpEOpNNTlmzAiSGpfpW4xdWm
	 6e27wLoOrFaOVkLK4ZrIJUmhlXJki01prSWHu1H4=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Sun, 30 Aug 2026 20:25:56 +0200 (CEST)
Message-ID: <06d6f631-6b93-4110-83cf-e61617f883ac@perex.cz>
Date: Sun, 30 Aug 2026 20:25:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_Security=3A_Missed-sibling_stack_buffer_overflow_in?=
 =?UTF-8?B?IF9fc25kX2N0bF9hc2NpaV9lbGVtX2lkX3BhcnNlKCkg4oCUIG5hbWU9IGZpZWxk?=
 =?UTF-8?Q?_not_fixed_by_PR_=23509?=
To: Harsh Raj Singhania <raj.harshraut@gmail.com>
Cc: alsa-devel@alsa-project.org
References: 
 <CACBQ=P2FhO3M6dkv3cWuKb6Qhs92ouV+FJ3SJZ_PVBSSdJWRAQ@mail.gmail.com>
From: Jaroslav Kysela <perex@perex.cz>
Content-Language: en-US
Autocrypt: addr=perex@perex.cz; keydata=
 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
In-Reply-To: 
 <CACBQ=P2FhO3M6dkv3cWuKb6Qhs92ouV+FJ3SJZ_PVBSSdJWRAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: JHU6O5AHCRIZQJZ2JEMACBG24W6V2NBZ
X-Message-ID-Hash: JHU6O5AHCRIZQJZ2JEMACBG24W6V2NBZ
X-MailFrom: perex@perex.cz
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JHU6O5AHCRIZQJZ2JEMACBG24W6V2NBZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 8/29/26 05:56, Harsh Raj Singhania wrote:
> Hello Jaroslav,
> 
> I am Harsh Raj Singhania, a second-year BTech cybersecurity student and 
> independent security researcher (GitHub: https://www.google.com/url?q=https:// 
> github.com/HarshRajSinghania&source=gmail&ust=1788062190641000&sa=E <https:// 
> www.google.com/url?q=https://github.com/ 
> HarshRajSinghania&source=gmail&ust=1788062190641000&sa=E>). I am writing to 
> report a missed-sibling stack buffer overflow in alsa-lib that was not 
> addressed by the fix in commit 1e27d63 (PR #509, "Fix theoretical one-byte 
> buffer overrun").
> 
> --- SUMMARY ---
> 
> PR #509 fixed an off-by-one in the numid= field parsing loop inside 
> __snd_ctl_ascii_elem_id_parse() in src/control/ctlparse.c, changing the loop 
> guard from:
> 
> if (size < (int)sizeof(buf))
> 
> to:
> 
> if (size < (int)sizeof(buf) - 1)

Thanks. Fixed in commit f84cd4ced7b36fddb8e4ee24404cf7c091d27020 [1].

Jaroslav

[1] 
https://github.com/alsa-project/alsa-lib/commit/f84cd4ced7b36fddb8e4ee24404cf7c091d27020

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat

