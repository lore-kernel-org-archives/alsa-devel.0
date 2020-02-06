Return-Path: <SRS0=zIiJ=32=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5312C33CAC
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:50:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF1120720
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ntcFxbxN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHh9IMna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF1120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9BCD16A3;
	Thu,  6 Feb 2020 17:50:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9BCD16A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581007856;
	bh=s1nemEx2YLG7cQx++dtwRpfF5eOUhnkiQ4UapZ1c93M=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ntcFxbxNmGdq26bn/rtYzEvo7Gz7unk98hLj6C6nTgUR+fswZkVT/6MJ2NF1EcaUo
	 sqCfon6Def8VkpTyEVmDG1a1iDyD+cX2lcF9P0tDiES9bdX1Wa7TQazGEiwLoyDs07
	 wDbLOq8MbLVNO+eKglh5wu1UhfhKz3dJaUsh2OdA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 368ADF8015B;
	Thu,  6 Feb 2020 17:50:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0C53F80162; Thu,  6 Feb 2020 17:50:04 +0100 (CET)
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com
 [IPv6:2a00:1450:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67C2BF800AB
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 17:49:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67C2BF800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="PHh9IMna"
Received: by mail-lj1-x243.google.com with SMTP id h23so6830595ljc.8
 for <alsa-devel@alsa-project.org>; Thu, 06 Feb 2020 08:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rz0LRSNwEyC05fPXK6mf1Cdt7QThOLZZfr/HLHN5E7g=;
 b=PHh9IMnal7LVehy5NVdPWmSIXmBATvpNMGAAbJVB/LYFbsVpkutCxV7HTdv01UfUM2
 Tgqcr0tnHuPygnsjZxSUIKEhJPqMZlTMHKKlXV5yRr2c4PFe3FRnZ/m4kG5a9oksWZyX
 KcJ6RmKmk1wROM0LupA5vznlEhk7xKx/Tv5NzWBGlh5DkeVDYgQqnKpGH+Bd+tYai0go
 uYaQKOf0sTX+rPzllBIZPWlV9O90AoagdsiSeQwm4FVG5+sGuATmSsKDTGS7ReaEtcee
 jUHwezctnurbVLRlEd2PXktH1LzRGSupSzSpw5HqHh0ok9FR3+JtZQ3ICWK0PhXC4K5c
 GDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rz0LRSNwEyC05fPXK6mf1Cdt7QThOLZZfr/HLHN5E7g=;
 b=LrypK8xrP6b1g6zDQhzwdYRI31Uxi4rXWsbpRzl7f7UWBiHRKKGfIjDSdPjzAbEh7t
 sD5ISnY8lPeU6JHXzo3U8DULzUGlvTbMqBv5idlrcffRxAI3kurEFYt6ABRm67ThouxP
 q51fk50PvF8WQV3lBFnzCQKpSA1aAsVOqy62H46oZfe/G9YxdMdUNBei+Wo02l6WE2sN
 KSjFxCUa/qd79dYnsIphOvh4TmKupKVOsFAqCBmZsL3Af8c+qtWpBHp7hRyTob2l1CKF
 u6yFyfQm7QcowE1Hhiohbj7PmMZF3r8BZHlgFrXrc/ROSxQYED+/3yQvPUsx5AsedPRo
 ouIQ==
X-Gm-Message-State: APjAAAUjH20V272871eb5apPIHoKnhYOVQu7gDX6yblzjB7nE/XfxdQN
 u+K37l2b9A/G8a1Ipqj49h4=
X-Google-Smtp-Source: APXvYqylplfy+0XtZ/0fP3I86GFfK9ygbsHF33Fl6eXd5pn7p64WdygUib4gE2B5b9AxF0UhvOHYUg==
X-Received: by 2002:a2e:9a51:: with SMTP id k17mr2481251ljj.206.1581007799031; 
 Thu, 06 Feb 2020 08:49:59 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru.
 [79.139.233.37])
 by smtp.googlemail.com with ESMTPSA id s22sm1669570ljm.41.2020.02.06.08.49.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 08:49:58 -0800 (PST)
To: Sameer Pujar <spujar@nvidia.com>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-3-git-send-email-spujar@nvidia.com>
 <7239e858-16b7-609f-c4e3-8135bee8450b@gmail.com>
 <1305a6db-a492-eec2-111e-ddc801d58d86@nvidia.com>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fb0a96bd-ac3c-0916-0337-0c86de196527@gmail.com>
Date: Thu, 6 Feb 2020 19:49:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1305a6db-a492-eec2-111e-ddc801d58d86@nvidia.com>
Content-Language: en-US
Cc: jonathanh@nvidia.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, atalambedu@nvidia.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh+dt@kernel.org,
 tiwai@suse.com, viswanathl@nvidia.com, sharadg@nvidia.com, broonie@kernel.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rlokhande@nvidia.com,
 mkumard@nvidia.com, dramesh@nvidia.com
Subject: Re: [alsa-devel] [PATCH v2 2/9] ASoC: tegra: add support for CIF
	programming
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

MDYuMDIuMjAyMCAxNDo1NiwgU2FtZWVyIFB1amFyINC/0LjRiNC10YI6Cj4gCj4gCj4gT24gMi81
LzIwMjAgMTA6MzIgUE0sIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPj4gRXh0ZXJuYWwgZW1haWw6
IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMKPj4KPj4KPj4gMzAuMDEu
MjAyMCAxMzozMywgU2FtZWVyIFB1amFyINC/0LjRiNC10YI6Cj4+IC4uLgo+Pj4gKyNpbmNsdWRl
IDxsaW51eC9tb2R1bGUuaD4KPj4+ICsjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+Cj4+PiArI2lu
Y2x1ZGUgInRlZ3JhX2NpZi5oIgo+Pj4gKwo+Pj4gK3ZvaWQgdGVncmFfc2V0X2NpZihzdHJ1Y3Qg
cmVnbWFwICpyZWdtYXAsIHVuc2lnbmVkIGludCByZWcsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0cnVjdCB0ZWdyYV9jaWZfY29uZiAqY29uZikKPj4+ICt7Cj4+PiArwqDC
oMKgwqAgdW5zaWduZWQgaW50IHZhbHVlOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgIHZhbHVlID0gKGNv
bmYtPnRocmVzaG9sZCA8PCBURUdSQV9BQ0lGX0NUUkxfRklGT19USF9TSElGVCkgfAo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoKGNvbmYtPmF1ZGlvX2NoIC0gMSkgPDwgVEVHUkFfQUNJ
Rl9DVFJMX0FVRElPX0NIX1NISUZUKSB8Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgo
Y29uZi0+Y2xpZW50X2NoIC0gMSkgPDwKPj4+IFRFR1JBX0FDSUZfQ1RSTF9DTElFTlRfQ0hfU0hJ
RlQpIHwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGNvbmYtPmF1ZGlvX2JpdHMgPDwg
VEVHUkFfQUNJRl9DVFJMX0FVRElPX0JJVFNfU0hJRlQpIHwKPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKGNvbmYtPmNsaWVudF9iaXRzIDw8IFRFR1JBX0FDSUZfQ1RSTF9DTElFTlRfQklU
U19TSElGVCkgfAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoY29uZi0+ZXhwYW5kIDw8
IFRFR1JBX0FDSUZfQ1RSTF9FWFBBTkRfU0hJRlQpIHwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKGNvbmYtPnN0ZXJlb19jb252IDw8IFRFR1JBX0FDSUZfQ1RSTF9TVEVSRU9fQ09OVl9T
SElGVCkgfAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoY29uZi0+cmVwbGljYXRlIDw8
IFRFR1JBX0FDSUZfQ1RSTF9SRVBMSUNBVEVfU0hJRlQpIHwKPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKGNvbmYtPnRydW5jYXRlIDw8IFRFR1JBX0FDSUZfQ1RSTF9UUlVOQ0FURV9TSElG
VCkgfAo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoY29uZi0+bW9ub19jb252IDw8IFRF
R1JBX0FDSUZfQ1RSTF9NT05PX0NPTlZfU0hJRlQpOwo+Pj4gKwo+Pj4gK8KgwqDCoMKgIHJlZ21h
cF91cGRhdGVfYml0cyhyZWdtYXAsIHJlZywgVEVHUkFfQUNJRl9VUERBVEVfTUFTSywgdmFsdWUp
Owo+Pj4gK30KPj4+ICtFWFBPUlRfU1lNQk9MX0dQTCh0ZWdyYV9zZXRfY2lmKTsKPj4gQXJlIHlv
dSBnb2luZyB0byBhZGQgbW9yZSBzdHVmZiBpbnRvIHRoaXMgc291cmNlIGZpbGUgbGF0ZXIgb24/
Cj4gCj4gWWVzIEkgcGxhbiB0byBhZGQgVGVncmEzMCBhbmQgVGVncmExMjQgQ0lGIGZ1bmN0aW9u
cyBpbiB0aGlzLiBBbnl0aGluZwo+IHJlbGF0ZWQgdG8gQ0lGIGNhbiBiZSBtb3ZlZCBoZXJlLgo+
Pgo+PiBJZiBub3QsIHRoZW4gaXQncyB0b28gbXVjaCB0byBoYXZlIGEgc2VwYXJhdGUgZHJpdmVy
IG1vZHVsZSBqdXN0IGZvciBhCj4+IHNpbmdsZSB0aW55IGZ1bmN0aW9uLCB5b3Ugc2hvdWxkIG1v
dmUgaXQgaW50byB0aGUgaGVhZGVyIGZpbGUgKG1ha2UgaXQKPj4gaW5saW5lKS4KPiAKCllvdSBz
aG91bGQgY29uc2lkZXIgd2hldGhlciBpdCdzIHdvcnRoIHRvIG1vdmUgYW55dGhpbmcgZWxzZSB0
byB0aGlzCm1vZHVsZSBmaXJzdCwgYmVjYXVzZSBpZiB0aGUgZnVuY3Rpb25zIGFyZSBub3QgcmV1
c2FibGUgYnkgdGhlIGRyaXZlcnMsCnRoZW4gdGhlIG1vdmVtZW50IHdvbid0IGJyaW5nIGFueSBi
ZW5lZml0cyBhbmQgZmluYWwgcmVzdWx0IGNvdWxkIGJlCm5lZ2F0aXZlIGluIHJlZ2FyZHMgdG8g
dGhlIGNvZGUncyBvcmdhbml6YXRpb24uCgpJIHN1Z2dlc3QgdG8gc3RhcnQgY2xlYW4gYW5kIGVh
c3ksIHdpdGhvdXQgdGhlIGRyaXZlciBtb2R1bGUuIFlvdSB3aWxsCmJlIGFibGUgdG8gZmFjdG9y
IGNvZGUgaW50byBtb2R1bGUgbGF0ZXIgb24sIG9uY2UgdGhlcmUgd2lsbCBhIHJlYWwgbmVlZAp0
byBkbyB0aGF0LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0
cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVs
Cg==
