Return-Path: <SRS0=4IlU=II=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398A4C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 10:25:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F60F64F74
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 10:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F60F64F74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4D571745;
	Wed, 10 Mar 2021 11:24:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4D571745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615371927;
	bh=Rm9c3cBrndV+3wTmWZRDREKPRRTdTIPpj1NY9ISuRFc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VxDk/VBLvUs6B33caTKEb9S/iA2/IRnDshAe5gwAMEq4FX9yZkEXsE1O1WCRGQCU/
	 q1Xe00+8k81PxTvN8T3Fcyy4myQCDBIFSvdBhqNnJQEXD57j4gg+6pmiN7zLKJALfu
	 +LMlFfKp/qpPN5RumFOWrqITTgk3NGf3smdtLJ+Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3EB7BF8016C;
	Wed, 10 Mar 2021 11:24:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4CF9F801D8; Wed, 10 Mar 2021 11:24:35 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54B42F8010D
 for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2021 11:24:21 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id B6274A003F;
 Wed, 10 Mar 2021 11:24:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz B6274A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1615371859; bh=ROgG/PtaxjtZMLqu6lNwnQO9hMpszBD5BRw+ntc12PU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Q5D+fex7/SDz0BoIIo1x3r+VVtqBQT3VcwZt0zOgo1qNBq2NXe8SePHh/MJnqE5Nc
 rhvzY98i4HEyZkDT+dEUsmibrvm1QFptOe/zfGJl1RFfc7ZPN9rYX26XnIwbzn67B5
 7jnLEJJMg3fIZ5MPrFcJJuah2aZ61cNU/VI5rsCU=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 10 Mar 2021 11:24:15 +0100 (CET)
Subject: Re: [PATCH alsa-ucm-conf v2 0/7] codecs/rt5640: Cleanup + HW volume
 control support
To: Hans de Goede <hdegoede@redhat.com>
References: <20210308220554.76111-1-hdegoede@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <8a960a9a-fddb-dff5-42be-ca4ddd54122c@perex.cz>
Date: Wed, 10 Mar 2021 11:24:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210308220554.76111-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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

Dne 08. 03. 21 v 23:05 Hans de Goede napsal(a):
> Hi All,
> 
> Here is v2 of my patch series consisting of some codecs/rt5640 cleanups
> and addition of HW volume control support to the rt5640 .conf snippets.
> 
> This new version has been updated to deal with the
> "[PATCH 3/5] ASoC: rt5640: Add emulated 'DAC1 Playback Switch' control"
> kernel-patch being dropped.
> 
> Note patch 7 depends on a new "aif:%d" part being added to the
> components string, the kernel patches for this are pending upstream
> in the "[PATCH resend 0/2] AsoC: rt5640/rt5651: Volume control fixes"
> patch-series.

Applied all except the 7th patch.

Thank you.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
