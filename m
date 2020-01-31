Return-Path: <SRS0=zdUo=3U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB850C33CB2
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jan 2020 03:13:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434D720CC7
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jan 2020 03:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Yj66Lh8b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JXWuQhzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434D720CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B0C0166C;
	Fri, 31 Jan 2020 04:12:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B0C0166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580440415;
	bh=4Szi5LucJWC5d5S3Xn2XpkqR0rD0/9Rz9g4eqwbeu2A=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yj66Lh8bRoKyxR955iUuzFb9xojfHWx6NqaF5mZaC9295Ras8IWm8j8PWV4eRwHkh
	 OT50WhfzTijcqwc2ZxtnkqWFTFNdJiyXgpIEu+GDV0V2Zu9jHDvnUEDH+ZuNwDrAtl
	 cJ9SKU1bRqL3/2GE/fJ2SVTzKMq+pZLZJl6hkf5s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D1ADFF80143;
	Fri, 31 Jan 2020 04:12:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBE60F8021E; Fri, 31 Jan 2020 04:12:42 +0100 (CET)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC8AAF80143
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2020 04:12:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC8AAF80143
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="JXWuQhzY"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e339aef0000>; Thu, 30 Jan 2020 19:11:43 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Thu, 30 Jan 2020 19:12:36 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Thu, 30 Jan 2020 19:12:36 -0800
Received: from [10.25.73.84] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jan
 2020 03:12:31 +0000
To: Dmitry Osipenko <digetx@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
 <robh+dt@kernel.org>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-6-git-send-email-spujar@nvidia.com>
 <160bb2ca-89bb-0ecf-a334-0fac591b439a@gmail.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <00ce0f46-4401-c1da-5513-4aa38d224a44@nvidia.com>
Date: Fri, 31 Jan 2020 08:42:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <160bb2ca-89bb-0ecf-a334-0fac591b439a@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1580440304; bh=pOv0j2LC/b/wPjHJax5N8sojDpZ23UrGRdvxHFuGJS4=;
 h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
 Content-Language;
 b=JXWuQhzY18eWXms0wSacXtCMzZKzJXcryJ0/IFA82s/qshH4SKD4koZBJMt7zjDPS
 Dl34fHgTC9mVA1mENlCbL4HHogea11m+shE/gxpbSTEu+JFKMuxx2CuszQnC+b3CDc
 /+VFo8N/sNXeK3SOCkHizNwBiXaG8nXspXCp4j8f9d8eho3tcWKq3lRrmtGqHXv4sA
 kk4tLGOfgPO15MHiT/iWuwlCddL4+hbWxdTNz7yhQ8NHL4rZ1HubFrsh3Ztf2+PxsF
 Uhxk1Jj7ux8d+3oIDAUqWZW0mPiYr82sFdqw9kuwUcB1PpuBqxKRRLHDe28nGgKt2a
 WdFfbrR9bg9Rg==
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 atalambedu@nvidia.com, linux-kernel@vger.kernel.org, spujar@nvidia.com,
 lgirdwood@gmail.com, jonathanh@nvidia.com, viswanathl@nvidia.com,
 sharadg@nvidia.com, broonie@kernel.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, rlokhande@nvidia.com, mkumard@nvidia.com,
 dramesh@nvidia.com
Subject: Re: [alsa-devel] [PATCH v2 5/9] ASoC: tegra: add Tegra210 based
	AHUB driver
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

CgpPbiAxLzMwLzIwMjAgMTA6NTUgUE0sIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPiBFeHRlcm5h
bCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+Cj4KPiAz
MC4wMS4yMDIwIDEzOjMzLCBTYW1lZXIgUHVqYXIg0L/QuNGI0LXRgjoKPiAuLi4KPj4gKyNpbmNs
dWRlIDxsaW51eC9jbGsuaD4KPj4gKyNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KPj4gKyNpbmNs
dWRlIDxsaW51eC9tb2R1bGUuaD4KPj4gKyNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPgo+
PiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgo+PiArI2luY2x1ZGUgPGxpbnV4
L3BtX3J1bnRpbWUuaD4KPj4gKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4KPj4gKyNpbmNsdWRl
IDxzb3VuZC9zb2MuaD4KPj4gKyNpbmNsdWRlICJ0ZWdyYTIxMF9haHViLmgiCj4gTml0OiBJJ2Qg
c2VwYXJhdGUgdGhlIHBlci1kaXJlY3RvcnkgaW5jbHVkZXMgd2l0aCBhIGJsYW5rIGxpbmUsIGxp
a2UgaXQKPiBkb25lIGJ5IHRoZSBtb3N0IG9mIGV4aXN0aW5nIGRyaXZlcnMsIGZvciBjb25zaXN0
ZW5jeS4KCkhpIERtaXRyeSwKCkknZCBhc3N1bWUgdGhlc2UgYXJlIHRoZSBvbmx5IHJldmlldyBj
b21tZW50cyAod2hpY2ggaW5jbHVkZXMgeW91ciBvdGhlciAKcmVwbGllcyBmb3IgdjIgNS85KSBm
b3IgdGhlIHNlcmllcy4KTGV0IG1lIGtub3cgb3RoZXJ3aXNlLgoKSXQgd291bGQgaGVscCBtZSB0
byBkaXNjdXNzIGFsbCB0aGUgaXNzdWVzIGF0IG9uY2UsIGZpbmFsaXplIGNoYW5nZXMgZm9yIAp2
MyBhbmQgc28gdGhhdCB3ZSBjYW4gYXZvaWQgbXVsdGlwbGUgaXRlcmF0aW9ucy4KClRoYW5rcywK
U2FtZWVyLgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpodHRw
czovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2ZWwK
