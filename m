Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8269CC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 19:00:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA8E822A84
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 19:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA8E822A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A3B6B170B;
	Mon, 11 Jan 2021 20:00:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A3B6B170B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610391655;
	bh=mMSUITB5hAdiia5ZhEO9xlIZguamzMiWk+q3BOcqL4g=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r/Fxw3ap99YfUdFoKDyioFW8CPhPfWsGrzbPF1trrDKeINIe7PNvT2ussNj0/i3co
	 lwZv7dE7eUem0lz+mfoVdL8TkvXNmXZU0StH5kguZkqewMUnDbcIbD8OzfQj4izaNx
	 2wp8NxI+IGmblgdAmSLAmXS7wo4jptOEvndkjBBQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5ACB6F800BE;
	Mon, 11 Jan 2021 20:00:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3629FF8016D; Mon, 11 Jan 2021 20:00:01 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85467F8013D
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 19:59:50 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 21F95A003F;
 Mon, 11 Jan 2021 19:59:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 21F95A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1610391585; bh=X2AeqByBYug1dqKCnGUT6OVwP97/6rGRZcmkFH18sik=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=cH2EplvObz6fMU44mDOa1jyZih3IYzwogGoRNyhh07Nn9AhVeZp+cvLgij849y9j8
 xxHvl5smxGv6t5fpka4ujR9aA31qlLm6WxMYMz2kFBc2ZGvCRGTLeO/i6EsxOIq5Wz
 +2Ls1DoDylcEcObcW11ZnKv/e3id4IwLuPPi/tx0=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 11 Jan 2021 19:59:41 +0100 (CET)
Subject: Re: [PATCH alsa-ucm-conf 1/2] bytcr-rt5640: Add support for devices
 without speakers and/or an internal mic
To: Hans de Goede <hdegoede@redhat.com>
References: <20210109210252.159162-1-hdegoede@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <d5d4d125-c838-0ef9-e8be-2adb77688904@perex.cz>
Date: Mon, 11 Jan 2021 19:59:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210109210252.159162-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Rasmus Porsager <rasmus@beat.dk>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Dne 09. 01. 21 v 22:02 Hans de Goede napsal(a):
> There are kernel patches pending upstream for the bytcr-rt5640 machine-driver
> to support devices without speakers and/or an internal mic.
> 
> Since the UCM profile already conditionally loads the speaker and
> internal-mic codec include files, these will simply get skipped in this
> case, so this almost works with the current UCM profile without changes.
> 
> The only troublesome part is the ConflictingDevice sections in the codec
> HeadPhones.conf and HeadsetMic.conf files, which refer to resp. a "Speaker"
> and a "Mic" device. Without any of the speaker or mic codec conf files
> being included there will not by any "Speaker" / "Mic" devices leading
> to an error while parsing the HeadPhones.conf / HeadsetMic.conf files.
> 
> This commit makes the ConflictingDevice section conditional, fixing this.

Applied to the ucm repo. Thank you.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
