Return-Path: <SRS0=uPGH=3Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DE4C35253
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Feb 2020 04:36:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71ABD2086A
	for <alsa-devel@archiver.kernel.org>; Tue,  4 Feb 2020 04:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EFrZ++/B";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="joInkOn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71ABD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C89F71699;
	Tue,  4 Feb 2020 05:35:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C89F71699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580791006;
	bh=XGe8BO1DY/+BPQImm8iWXpmHPVTdeeD9W3xyONkHsCw=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EFrZ++/BItH/5HVA5DIwxMRQ9wcuHs/Ucb5ZtEy47g9Azi5ofMwD5fgdo1Tp4DY71
	 OnpATL6ZDgEfK5lC0FRD4zsELLCT2bNuZ3YvMaj+QflfnjspL8XEMpBO689Rgmx6j4
	 LqTaD52H5G7ISNuepUot3q9xPC+iK/Mfil/yqhNQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90999F80276;
	Tue,  4 Feb 2020 05:35:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AC1C0F80277; Tue,  4 Feb 2020 05:35:29 +0100 (CET)
Received: from hqnvemgate24.nvidia.com (hqnvemgate24.nvidia.com
 [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5AE4FF80274
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2020 05:35:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AE4FF80274
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="joInkOn0"
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5e38f44f0000>; Mon, 03 Feb 2020 20:34:23 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Mon, 03 Feb 2020 20:35:19 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Mon, 03 Feb 2020 20:35:19 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Feb
 2020 04:35:14 +0000
To: Dmitry Osipenko <digetx@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
 <robh+dt@kernel.org>
References: <1580380422-3431-1-git-send-email-spujar@nvidia.com>
 <1580380422-3431-6-git-send-email-spujar@nvidia.com>
 <bd802f93-dd03-f39d-86e1-39f8571bbbb0@gmail.com>
 <f8c04460-f2ea-3102-4723-a5a75ba535ba@gmail.com>
From: Sameer Pujar <spujar@nvidia.com>
Message-ID: <feea1f97-72fd-1746-3483-4a18fe8f5b32@nvidia.com>
Date: Tue, 4 Feb 2020 10:05:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <f8c04460-f2ea-3102-4723-a5a75ba535ba@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1580790863; bh=3oBPJ/AUZca843m18B8WtIQPG8BRCfQUcXnYum59kQQ=;
 h=X-PGP-Universal:CC:Subject:To:References:From:Message-ID:Date:
 User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
 X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
 Content-Language;
 b=joInkOn0g+tkk/12jcZcONJOaVc+UjxiD6zLWWC1+izD2CemNeRLyRwsOsyzO4sBj
 2vBwK3oLvWZC7rUj4eokm2brZMDodeyeTi+8WHHqUYZ40BOnqI+NgoSzbsPCUELEUD
 AyPrm5KG/zO29dUiDLa6e4gz7Zorj2nH8RSueAcvI6kbLuQIyivfxd2yNPq1OWz6Hw
 MHxwazxPvV7EDe/a8bInVBFcx6CA6g+yJdLcMnRxcp0hQw4Qr1LyjgKhhitZ49t7Rt
 y8Oi/1js173RQOc5LnUve2on90+nISus48zLe+jQPhzNE9fNPh+ju/koapMbCOgIx8
 rTQQxUJoFdqlA==
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

CgpPbiAxLzMwLzIwMjAgMTA6NDggUE0sIERtaXRyeSBPc2lwZW5rbyB3cm90ZToKPiBFeHRlcm5h
bCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cwo+Cj4KPiAz
MC4wMS4yMDIwIDIwOjA5LCBEbWl0cnkgT3NpcGVua28g0L/QuNGI0LXRgjoKPj4gMzAuMDEuMjAy
MCAxMzozMywgU2FtZWVyIFB1amFyINC/0LjRiNC10YI6Cj4+IC4uLgo+Pj4gKyAgICAgICAgICAg
IGRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0byByZWdpc3RlciBjb21wb25lbnQsIGVycjog
JWRcbiIsCj4+ICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiY2FuJ3QgcmVnaXN0ZXIgSTJT
IGNvbXBvbmVudCwgZXJyOiAlZFxuIiwgcmV0KTsKPgo+IEFsc28sIHdpbGwgYmUgbmljZSB0byBo
YXZlIHdvcmRpbmcgb2YgdGhlIHRleHQgbWVzc2FnZXMgdG8gYmUgY29uc2lzdGVudAo+IGV2ZXJ5
d2hlcmUuCgpPSy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkFsc2EtZGV2ZWwgbWFpbGluZyBsaXN0CkFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZwpo
dHRwczovL21haWxtYW4uYWxzYS1wcm9qZWN0Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Fsc2EtZGV2
ZWwK
