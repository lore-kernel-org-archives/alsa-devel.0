Return-Path: <SRS0=zIiJ=32=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15F8C33CAC
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:54:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1E620838
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ADANIusZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe19er23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1E620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7FAB316B6;
	Thu,  6 Feb 2020 17:54:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7FAB316B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581008096;
	bh=q1LRmvmU3X76p6PuzjGj8Nb6/+nD8lW5uQBgldpPiok=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ADANIusZIF9OS8NtMNQHo/7JAXYb3Rc7qAjcpjnjgC8F4pUV0O1lk3z6kBn5DlOdT
	 v6Qnc2h8ngNZBE91+6V0up6X+YwxT5z1RlmlfvD1rLwkAeAhzxpCwbXaV3qdbmdEe4
	 R8pMQ/zUPa6EMQiBdCULwhaBVEY2czv1NvR04uk4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3131F8015B;
	Thu,  6 Feb 2020 17:54:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CCFA2F80162; Thu,  6 Feb 2020 17:54:03 +0100 (CET)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 502A1F80059
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 17:53:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 502A1F80059
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="Oe19er23"
Received: by mail-lj1-x241.google.com with SMTP id q8so6816179ljj.11
 for <alsa-devel@alsa-project.org>; Thu, 06 Feb 2020 08:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aYjPID+86AwFTbXgWpB4ZDC6SCfeqfl8MOuO71FjWTc=;
 b=Oe19er23o00T0c4K/YdRf6LayjLgkdOVvy2wtLnqQzWAXAfyTipZh+ox7V2UmKx6uP
 v0O+9GwYp6MaPZ4fG8bbVJKzfq5tQaAotTOLA7S7x3zLRwQW7IfOJEunjOuYlghcSFzZ
 vE46F9MJMajetQcMCYySEqElf+1oto5+pquM9b9ZJSIdta4OgPfE5ru6PdJ6v1dOVNTO
 xvUsVYpHfBIL9iVPUfDOAXEawcjRnYqfts+UBmW68uj08B+vQido5r868WqCADKNy8aA
 yE3E/VyYyltjpCdgHdppLbXEIGK6aHLIdAmUOdydd+Cz/AwnesEX5xISEFKM9j3TT/Ks
 h6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aYjPID+86AwFTbXgWpB4ZDC6SCfeqfl8MOuO71FjWTc=;
 b=nUGdlqsbhT0A6zl+aTXJOVmnV79D64BmV5cUTmG8COtOgPO2TyDFKqNi006TXudAc3
 5lSg4vSHn4qsMehuRMPBW1+wKs7Umvr0SoJOS+dcoOT6K2JOzF6k3XAUjXraMb74SEJp
 kvC4loh1mOugMTmcjRwZqyAj8Mq2dZSOsCMmfjFuKHPlequtZ3kPGjTCYaZjMNwlIg61
 CCEE1uR0fxTO5fR+U8dmQJyajSzpVBJ2TYSiN/GLd+LJK7tfCl98FuZK5wCVvzmpZ2ZN
 SYyK1iM/hZekG2DTCaUX9amvqz2L+KvWTAkysKmK7PIB84xmHm0FJzp1hCPIWQW7VTcl
 YvJg==
X-Gm-Message-State: APjAAAWNkS0izfRwbd+/mP+4/REDyBj9ISWqYwqAUuXU6Jg9WLNvfLaO
 znbqtdyyFS9yCT8Bac6jJK4=
X-Google-Smtp-Source: APXvYqx0LdMbwbSEVNhUV1hE5Xi3kfdxfUnR07rFEeIfYMgYE+cPOQLkO0RNLi/10WFfpWxsuIWmLA==
X-Received: by 2002:a2e:8699:: with SMTP id l25mr2509962lji.137.1581008039144; 
 Thu, 06 Feb 2020 08:53:59 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru.
 [79.139.233.37])
 by smtp.googlemail.com with ESMTPSA id y7sm1649358ljy.92.2020.02.06.08.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 08:53:58 -0800 (PST)
To: Sameer Pujar <spujar@nvidia.com>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-4-git-send-email-spujar@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <9ada4090-169e-0767-db5d-739f6e621812@gmail.com>
Date: Thu, 6 Feb 2020 19:53:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1580380422-3431-4-git-send-email-spujar@nvidia.com>
Content-Language: en-US
Cc: jonathanh@nvidia.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, atalambedu@nvidia.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
 tiwai@suse.com, viswanathl@nvidia.com, sharadg@nvidia.com, broonie@kernel.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rlokhande@nvidia.com,
 mkumard@nvidia.com, dramesh@nvidia.com
Subject: Re: [alsa-devel] [PATCH v2 3/9] ASoC: tegra: add Tegra210 based
	DMIC driver
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

MzAuMDEuMjAyMCAxMzozMywgU2FtZWVyIFB1amFyINC/0LjRiNC10YI6Ci4uLgo+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IHJlZ19kZWZhdWx0IHRlZ3JhMjEwX2RtaWNfcmVnX2RlZmF1bHRzW10gPSB7
Cj4gKwl7IFRFR1JBMjEwX0RNSUNfVFhfSU5UX01BU0ssIDB4MDAwMDAwMDF9LAo+ICsJeyBURUdS
QTIxMF9ETUlDX1RYX0NJRl9DVFJMLCAweDAwMDA3NzAwfSwKPiArCXsgVEVHUkEyMTBfRE1JQ19D
RywgMHgxfSwKPiArCXsgVEVHUkEyMTBfRE1JQ19DVFJMLCAweDAwMDAwMzAxfSwKPiArCS8qIEJl
bG93IGVuYWJsZXMgYWxsIGZpbHRlcnMgLSBEQ1IsIExQIGFuZCBTQyAqLwo+ICsJeyBURUdSQTIx
MF9ETUlDX0RCR19DVFJMLCAweGUgfSwKPiArCS8qIEJlbG93IGFzIHBlciBsYXRlc3QgUE9SIHZh
bHVlICovCj4gKwl7IFRFR1JBMjEwX0RNSUNfRENSX0JJUVVBRF8wX0NPRUZfNCwgMHgwfSwKPiAr
CS8qIExQIGZpbHRlciBpcyBjb25maWd1cmVkIGZvciBwYXNzIHRocm91Z2ggYW5kIHVzZWQgdG8g
YXBwbHkgZ2FpbiAqLwo+ICsJeyBURUdSQTIxMF9ETUlDX0xQX0JJUVVBRF8wX0NPRUZfMCwgMHgw
MDgwMDAwMH0sCj4gKwl7IFRFR1JBMjEwX0RNSUNfTFBfQklRVUFEXzBfQ09FRl8xLCAweDB9LAo+
ICsJeyBURUdSQTIxMF9ETUlDX0xQX0JJUVVBRF8wX0NPRUZfMiwgMHgwfSwKPiArCXsgVEVHUkEy
MTBfRE1JQ19MUF9CSVFVQURfMF9DT0VGXzMsIDB4MH0sCj4gKwl7IFRFR1JBMjEwX0RNSUNfTFBf
QklRVUFEXzBfQ09FRl80LCAweDB9LAo+ICsJeyBURUdSQTIxMF9ETUlDX0xQX0JJUVVBRF8xX0NP
RUZfMCwgMHgwMDgwMDAwMH0sCj4gKwl7IFRFR1JBMjEwX0RNSUNfTFBfQklRVUFEXzFfQ09FRl8x
LCAweDB9LAo+ICsJeyBURUdSQTIxMF9ETUlDX0xQX0JJUVVBRF8xX0NPRUZfMiwgMHgwfSwKPiAr
CXsgVEVHUkEyMTBfRE1JQ19MUF9CSVFVQURfMV9DT0VGXzMsIDB4MH0sCj4gKwl7IFRFR1JBMjEw
X0RNSUNfTFBfQklRVUFEXzFfQ09FRl80LCAweDB9LAo+ICt9OwoKSSdkIGFkZCBhIHNwYWNlIG9u
IHRoZSByaWdodCBzaWRlIG9mIGB9YCwgZm9yIGNvbnNpc3RlbmN5IHdpdGggdGhlIGxlZnQuCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkFsc2EtZGV2ZWwg
bWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRwczovL21haWxtYW4u
YWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
