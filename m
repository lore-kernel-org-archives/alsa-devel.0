Return-Path: <SRS0=rQAG=33=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F667C2BA83
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:24:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F730222C2
	for <alsa-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="VATTBi8N";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVFjTA0m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F730222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C05D31699;
	Fri,  7 Feb 2020 19:23:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C05D31699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581099839;
	bh=pP6/E2LygpLJPSqMsebavobWtiMEc8+a/h+yvRYKo5Q=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VATTBi8N6jJPLXsfmsebaT81K9sTBmJgIElg5LKDR79pNsIqkFeGc5H8X5tTphlbA
	 Rg7r0jKtHs2uMzvyMN4C+qlZG/gpMXtNphwpUld/MpO7niKzWyWSZ0OOpJ50ZWvS61
	 6WR5oayhYNztpUrZMOo4Dgv+RCifqdvlK4zJzAfg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AFF3F80142;
	Fri,  7 Feb 2020 19:23:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AFE1BF80148; Fri,  7 Feb 2020 19:23:07 +0100 (CET)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17466F800B2
 for <alsa-devel@alsa-project.org>; Fri,  7 Feb 2020 19:23:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17466F800B2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="CVFjTA0m"
Received: by mail-ed1-x543.google.com with SMTP id e10so504628edv.9
 for <alsa-devel@alsa-project.org>; Fri, 07 Feb 2020 10:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2rEL+fZ+atRGcdqc0v6HR9KvKwcDJaTmCDh9SEZyi2k=;
 b=CVFjTA0mdflE33CmzdBoRt7RrT5W9DMHFpCIEmHOUSFpJQJ0oxYa4sqdU+jFJDlinh
 NYDIAkS58ouzX5NyhERarOe6g5KVJ3pqwSnAB9Fvt+cTTNKawK+enONTCTutSRTu0SWq
 M/Pz51Yte9XeHMccGnIfpPvQwFFgPoqU+x55OkyXSRbhLEVtlfSj+VZXd1WDa2PuS0Kc
 5p9bYFmcE6Obyp5xw3Ui+SKIWfZRLtJraYc60ZALpB1sO9DTousQznQiU/b9GXrJ5b/y
 Xw65cQWZDyb+9j6KjPIzC4oUhz9L9/1Rx04gvj9CAYPoFLmKmXK0yfS7FFp7esFWMSSk
 2IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2rEL+fZ+atRGcdqc0v6HR9KvKwcDJaTmCDh9SEZyi2k=;
 b=CXGoW0c/iWxM+wuA9vN35yW3vJMdbqNsfFPsLzqHNkQbsHLqaBSOtNZFgLTjOoVnpa
 AXY/Jwq7GtfM9Z788NKCAoEw58Zl75x9chA24ymFof05RIxrBL63AtwWAzGONhvtw282
 VOxnRfTjPlmCbUJRp5qzC+xqXjh2uaPx0mkXJhUN3C+9R3Phjh5DUdDQqYKnaVGkotQv
 UVHGGT7KBeF5NCex9PmynrmEtQvI+ZzQjsVgkuu2t9tCQTAdRbyJ5Oz/Xk5ZTOm+t6ql
 k3td8YtWxTKszo6GWhjKmN68a/3OFM3NaO21RMn0OGwAATfk1HY5bhM6ErpLJcQutph1
 jpOQ==
X-Gm-Message-State: APjAAAWoTCbuazaxUs3xBarF7VB7PSlIh625b/xMfXvA1fwy3yC/wqC8
 biyqh6hp48BJ7iIzXNFZL5qCZQ8X
X-Google-Smtp-Source: APXvYqwwT93CRJa4E1zobDD7odgAbkjWITZXCmyEkFHpgxyLmhB3dllkCjhnWXfogkZpMI/yf2i94A==
X-Received: by 2002:a17:906:4ecc:: with SMTP id
 i12mr501758ejv.227.1581099783984; 
 Fri, 07 Feb 2020 10:23:03 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru.
 [79.139.233.37])
 by smtp.googlemail.com with ESMTPSA id i26sm452051ejx.8.2020.02.07.10.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 10:23:03 -0800 (PST)
To: Sameer Pujar <spujar@nvidia.com>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-7-git-send-email-spujar@nvidia.com>
 <f8ed8c4a-af40-44b2-b720-4d3a9b660fda@gmail.com>
 <75a63cb3-7d79-7216-6791-3cec57464cd9@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <847f4512-7118-e087-1004-685e476e11d8@gmail.com>
Date: Fri, 7 Feb 2020 21:22:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <75a63cb3-7d79-7216-6791-3cec57464cd9@nvidia.com>
Content-Language: en-US
Cc: jonathanh@nvidia.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, atalambedu@nvidia.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
 tiwai@suse.com, viswanathl@nvidia.com, sharadg@nvidia.com, broonie@kernel.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rlokhande@nvidia.com,
 mkumard@nvidia.com, dramesh@nvidia.com
Subject: Re: [alsa-devel] [PATCH v2 6/9] ASoC: tegra: add Tegra186 based
	DSPK driver
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

MDcuMDIuMjAyMCAxNDoyNiwgU2FtZWVyIFB1amFyINC/0LjRiNC10YI6Cj4gCj4gCj4gT24gMi82
LzIwMjAgMTA6NDUgUE0sIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPj4gRXh0ZXJuYWwgZW1haWw6
IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMKPj4KPj4KPj4gMzAuMDEu
MjAyMCAxMzozMywgU2FtZWVyIFB1amFyINC/0LjRiNC10YI6Cj4+PiArc3RhdGljIGNvbnN0IHN0
cnVjdCBkZXZfcG1fb3BzIHRlZ3JhMTg2X2RzcGtfcG1fb3BzID0gewo+Pj4gK8KgwqDCoMKgIFNF
VF9SVU5USU1FX1BNX09QUyh0ZWdyYTE4Nl9kc3BrX3J1bnRpbWVfc3VzcGVuZCwKPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRlZ3JhMTg2X2RzcGtf
cnVudGltZV9yZXN1bWUsIE5VTEwpCj4+PiArwqDCoMKgwqAgU0VUX0xBVEVfU1lTVEVNX1NMRUVQ
X1BNX09QUyhwbV9ydW50aW1lX2ZvcmNlX3N1c3BlbmQsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBtX3J1bnRp
bWVfZm9yY2VfcmVzdW1lKQo+Pj4gK307Cj4+IENvdWxkIHlvdSBwbGVhc2UgZXhwbGFpbiB3aHkg
ZHJpdmVycyBuZWVkIHRoZSAibGF0ZSIgc3lzdGVtIHNsZWVwPwo+IAo+IEl0IHdhcyBkb25lIHRv
IGVuc3VyZSBjb3JlIGRyaXZlcnMgYXJlIHN1c3BlbmRlZCBmaXJzdCBhbmQgZGVmZXIgdGhlCj4g
Y29kZWMgZHJpdmVyIHN1c3BlbmQKClN1c3BlbmQgb3JkZXIgaXMgb3Bwb3NpdGUgdG8gdGhlIGRy
aXZlcnMgcmVnaXN0cmF0aW9uIG9yZGVyLiBJZiB0aGVyZSBpcwpubyByZWFsIHByb2JsZW0gd2l0
aCB0aGF0LCB0aGVuIHlvdSBzaG91bGQgdXNlIHRoZSBkZWZhdWx0IHN1c3BlbmQKbGV2ZWwuIFBs
ZWFzZSBkb24ndCB0cnkgdG8gZml4IGEgbm9uLWV4aXN0ZW50IHByb2JsZW1zLgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcg
bGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJv
amVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
