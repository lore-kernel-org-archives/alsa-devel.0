Return-Path: <SRS0=4IlU=II=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C235C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 10:02:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8096C64FBF
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 10:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8096C64FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3CE6176A;
	Wed, 10 Mar 2021 11:01:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3CE6176A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615370530;
	bh=lAezj/n6gFW+bN+iuOHZgUjYXrh7bvv8Ch+rZZ1Zafw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vP+4USkAke0nKCKpnkj8d1+AdclqXNMIUgYYSJBhfgaHXj5/0xigiMt40llEC/CN9
	 tAJ2h7yT3kFRYH+s15uwpMwSxNrcGrXMreKx2sqP/T9wXa4l06CzmyyeXNl5B4XLPM
	 BAafA2xn089lcHIfIoLzGt3Mp5640KH+XK1DfktU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 400F9F8016C;
	Wed, 10 Mar 2021 11:01:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A636EF801D8; Wed, 10 Mar 2021 11:01:18 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B729FF8010D
 for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2021 11:01:01 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 107A8A003F;
 Wed, 10 Mar 2021 11:01:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 107A8A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1615370460; bh=+YH2ei/T3ADqd0LRkkjdwqcVgYlwpDeTQMEvaIyKFaI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Fxs0f5obhYz8qKFn+PaLspq0y7+dG81l8dq/prnJank1dhnXUKWrRiZuwSGEzOcn5
 HpodznK6fmZWQ7I58RVDDyALAxD1SpnS11X/WwIux6tfBjlcvqYwz7muWwDBRWaBoF
 nY1lRDnzAQ4DQNzw/iRKptTRHI4mWwDf9q5Yhxl0=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 10 Mar 2021 11:00:55 +0100 (CET)
Subject: Re: [PATCH alsa-ucm-conf 1/3] codecs/es8316: Fix capture settings
To: Hans de Goede <hdegoede@redhat.com>
References: <20210307200308.136385-1-hdegoede@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <a065659c-c701-fca9-cb79-f70b9d5acd43@perex.cz>
Date: Wed, 10 Mar 2021 11:00:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210307200308.136385-1-hdegoede@redhat.com>
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

Dne 07. 03. 21 v 21:03 Hans de Goede napsal(a):
> Fix the following issues with the capture settings:
> 
> 1. Disable ALC / Auto Level Control, it tries to always get an
>    input signal even when the user is not talking into the mic
>    leading to it cranking up the volume till there is noise at
>    the same level as the user talking.
> 
> 2. The 'ADC PGA Gain Volume' volume control is not the main
>    'ADC vol' control, it is the mic amplifier control and
>    setting it to 10 sets it to 24dB not 0dB.
>    Adjust the comment and set it to 7 which is 16dB which
>    gives a good microphone signal strength without introducing
>    too much noise (with 'ADC Capture Volume' set to 0dB).
> 
> 3. There actually is a main 'ADC vol' control which goes from -96 to 0dB
>    which is simply called the 'ADC Capture Volume' and when disabling ALC
>    it defaults to -96 dB. Add a line setting it to 0dB.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thank you. I applied all three patches from the set.

Note that it may be better to move the static control presets to the
BootSequence, so the user can eventually fine tune them.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
