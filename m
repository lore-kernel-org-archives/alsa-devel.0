Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8E5C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 20:06:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7424F20890
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 20:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NuqH6InK";
	dkim=pass (1024-bit key) header.d=cccmz.de header.i=@cccmz.de header.b="UuA6dOY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7424F20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cccmz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E788316D9;
	Thu,  2 Jul 2020 22:05:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E788316D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593720360;
	bh=5u91dwaaOFLbQ8pq5j51tBSdCcyDi962mmKf12Dj6TQ=;
	h=To:From:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NuqH6InKFK+lcD9uN07HPIMRT+g2m8VIgXsAqxnZTqudYRFQYQVjxBDY3GT+FGN2H
	 hLoG13trfry7Bnb+cT+y5TVwBeWx8MQ5zFLKWZSZLDMQWaRVtPYmqeCqMB2Mw7Xpfi
	 PxFtNxV2+sbrn3Q8TCcKmFjWGkISDaoOdJd1SY7Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 531D2F8022B;
	Thu,  2 Jul 2020 22:05:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 225B8F8022D; Thu,  2 Jul 2020 22:05:07 +0200 (CEST)
Received: from mail.cccmz.de (mail.cccmz.de [IPv6:2a01:4f8:161:4283:1000::108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 147DDF80134
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 22:05:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 147DDF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=cccmz.de header.i=@cccmz.de
 header.b="UuA6dOY4"
Received: from [192.168.178.45] (x4dbdd1d6.dyn.telefonica.de [77.189.209.214])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 (Authenticated sender: tanjeff@cccmz.de)
 by mail.cccmz.de (Postfix) with ESMTPSA id D11D617A0AF0
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 22:05:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cccmz.de; s=2019;
 t=1593720301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d/9Jje8WBwd+iU+3+fdc1VGl5HOySMO+pZADWB74EdU=;
 b=UuA6dOY4gkd3NQghbIXeWAZXoYHeGrrjlIcgBskCH1oA89db2mUQvoMHdajdZinzBhlxuL
 KhbEt4H+hFa2fvfUVc3bcgcdq+7jFNuZ39BZv/GqY8RnCxMt+Z1xjenXINCLx/f53XjegX
 4z9STobeZCxpOV0Q+eSt+xLmAzqiIY4=
To: alsa-devel@alsa-project.org
From: Tanjeff Moos <tanjeff@cccmz.de>
Subject: How to identify Alsa eLements?
Message-ID: <3e46d988-d2f7-b06d-76e8-c8def2e870d1@cccmz.de>
Date: Thu, 2 Jul 2020 22:05:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi alsa-devel,

I'm programming a GUI for the mixer in my Focusrite Scarlett 6i6 
interface. The Alsa driver supports that functionality, i.e. I can 
control the mixer using alsamixer, for example. Now I'm writing a Qt GUI 
for it.

I wonder how I can reliably identify a mixer control element (e.g. the 
master volume control). Each element has an ID (struct snd_ctl_elem_id), 
consisting of multiple elements:
- numid (seems to change at each boot)
- iface
- device
- subdevice
- name (is always constant)
- index
The docs says I can identify an element by the combination of name and 
index.

My questions:
1) Are name and index enough to identify an element?
2) How can I obtain the index? The name and numid are shown by 'amixer
    contents', for example.

Kind regards, Tanjeff

