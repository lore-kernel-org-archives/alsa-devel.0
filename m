Return-Path: <SRS0=vsGj=3L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD61C32771
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 21:24:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 097D921835
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jan 2020 21:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OhFA76YZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=essensium.com header.i=@essensium.com header.b="H9XnJlKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097D921835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=essensium.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58CB81683;
	Wed, 22 Jan 2020 22:23:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58CB81683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579728286;
	bh=SS4+jZXRzq6rtF6gMzJuhLEJKeVxmIjcvE9KOTDjLhA=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OhFA76YZoBfSOy0PDeiKLq4BpkhPptk1nHEDwSgKFROUZFS5CldNNnC5zV5h9Ay5i
	 NxUSY3+wKi3Rp4tsmcTXTIVp7hqJqtVql4cEBN57xeUHKyfcl+hj3q1jdwrMukyj6C
	 HTEImhUt/iXRc1hQchzECUhTUOKiOSa87DZpqQSA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D143BF801D8;
	Wed, 22 Jan 2020 22:23:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D17CF800BA; Wed, 22 Jan 2020 22:23:54 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9FFDF800BA
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 22:23:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9FFDF800BA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=essensium.com header.i=@essensium.com
 header.b="H9XnJlKW"
Received: by mail-wm1-x341.google.com with SMTP id p17so249534wma.1
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2020 13:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=essensium.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=IfD2sHXmnb5cZ2BXcNlg3xzWx12/juW/q1PvLrq1TZQ=;
 b=H9XnJlKW4NrgkMp+lXkcd6lO4sOIqVZnBgc2PueEujdvis3tmMnfU2ktFlnj42WlQP
 A8ombJkMpgULZZvwCK/JzWWg1hAt+qNoYm2EFTG7f5nfTf59lEk6pelR4gpKyFMhVpLK
 YDo1iPLOJw9ya3NU0VbLwL/NU4G1ATt96mt/OEqt8MT686s9sP6Ay1E7e+SSr0Oufy/A
 bV3cC5tZcwj9LNEBDU1QpZ8F1IkHzMavNsgq66m4KsJ1YOGESGM9dngO/ewPCl+KCo6F
 VqYm+uyXskyf9Ksqf0kp7xgnyIvbHAMATfXMb+O+C9FUQ/xJUDGA7QRvpnPUWLlZW29u
 /ZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=IfD2sHXmnb5cZ2BXcNlg3xzWx12/juW/q1PvLrq1TZQ=;
 b=fnMOglN/uuY8VKauaECQNqvbtPGUXL4yo/7b/KaVxNGNqULiKFjk1Q2YPbZY0kAed8
 GWcylYwxEL67Iz25cT2TQhCPFLVYdO7YayDUIPGgM+qdZWoBsOt3ziRizIhb9z3rqsqU
 CDTgLFqBZjprTl0IIuUAV73Nnkne//X5A+A92kd0u5mhL9OkI37YDVXZN4fAK6TGfOhk
 W+RCFMQUehXm6HwVYPsHRAuEqLHI9vBVHzLF/0PYVCZiDITms7VoceaTyzLXfejq6RVv
 /Rxo+e876GoL7mc7FYG2yjhMlZI82oWl/2sSB2j6i/K1wUuuCe0CocV7ex+fh+VElYjF
 ZKIQ==
X-Gm-Message-State: APjAAAWObU2ijzp+a8l3qb8UKxY8YAkXC/5djk7rCkuqcmQNDTMNlZ6J
 N5Qtcnladm+JoDwnxZW9aQLDQYS1A5k=
X-Google-Smtp-Source: APXvYqxoggoKrFJNKmAQWnzaQAnuGlTPtEnN1r7uEC5uuzgffZ8D0zbX6WZZNa+0jD+evxM7/mAWxQ==
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr140330wmg.169.1579728230635;
 Wed, 22 Jan 2020 13:23:50 -0800 (PST)
Received: from [192.168.1.37] ([109.129.20.95])
 by smtp.gmail.com with ESMTPSA id q15sm116575wrr.11.2020.01.22.13.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 13:23:50 -0800 (PST)
To: Rob Herring <robh@kernel.org>
References: <20200118092315.10384-1-charles-antoine.couret@essensium.com>
 <20200118092315.10384-2-charles-antoine.couret@essensium.com>
 <20200122161556.GA23997@bogus>
From: Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Message-ID: <6bc84a35-b389-dc83-3e0b-6fae05ce2133@essensium.com>
Date: Wed, 22 Jan 2020 22:23:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200122161556.GA23997@bogus>
Content-Language: en-US
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: tas5756m: Add DT binding document
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

TGUgMjIvMDEvMjAyMCDDoCAxNzoxNSwgUm9iIEhlcnJpbmcgYSDDqWNyaXTCoDoKCj4gQ2FuIHlv
dSBtYWtlIHRoaXMgYSBEVCBzY2hlbWEuCk9rLCB0aGFuayB5b3UgZm9yIHRoZSBub3RpY2UuCj4+
ICtPcHRpb25hbCBwcm9wZXJ0aWVzOgo+PiArCj4+ICsgIC0gbXV0ZS1ncGlvIDogR1BJTyB3aXJl
ZCB0byB0aGUgbXV0ZSBwaW4uCj4gbXV0ZS1ncGlvcyBpcyB0aGUgcHJlZmVycmVkIGZvcm0uCkkg
d2lsbCBmaXggaXQuCj4+ICsgIC0gaHlicmlkZmxvdyA6IGFuIGludGVnZXIgYmV0d2VlbiAxIGFu
ZCA5IHRvIHNlbGVjdCB0aGUgSHlicmlkRmxvdyBwcm9ncmFtLgo+PiArICAgICAgaWYgbm90IHN1
cHBsaWVkIGRlZmF1bHQgRFNQIHByb2dyYW0gaXMgdXNlZC4KPiBOZWVkcyBhIHZlbmRvciBwcmVm
aXguCj4KPiBJcyB0aGlzIHNvbWV0aGluZyBmaXhlZCBmb3IgdGhlIGxpZmUgb2YgYSBib2FyZCBv
ciBzb21ldGhpbmcgdXNlcnMgd291bGQKPiB3YW50IHRvIGNoYW5nZSBhdCBydW50aW1lPwoKVGhp
cyBzaG91bGRuJ3QgYmUgY2hhbmdlZCBvbiBydW50aW1lLiBJdCBpcyBwb3NzaWJsZSBidXQgaXQg
ZG9lcyBub3QgCm1ha2Ugc2Vuc2UgdG8gbWUuCgpGaXJzdGx5IHdlIGhhdmUgdG8gc3RvcCB0aGUg
ZGV2aWNlIGJlZm9yZSBzd2l0Y2hpbmcgdGhlIGh5YnJpZGZsb3cuCgpUaGVuIGl0IGNoYW5nZXMg
dGhlIGF2YWlsYWJsZSBBTFNBIGNvbW1hbmRzIGF0IHJ1bnRpbWUuIFRoZSBoeWJyaWRmbG93IApt
dXN0IGJlIGNob3NlbiB0byBtYXRjaCByZXF1aXJlbWVudHMgb2YgdGhlIHNwZWFrZXIgYmVoaW5k
IChsaWtlIDIuMSwgCndvb2ZlciBvciB0d2VldGVyKS4KCgpUaGFuayB5b3UgZm9yIHlvdXIgYWR2
aWNlcy4KClJlZ2FyZHMsCgpDaGFybGVzLUFudG9pbmUgQ291cmV0CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
