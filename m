Return-Path: <SRS0=RrJr=FN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E27C433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 09:31:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B2823B7B
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 09:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B2823B7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDBD9167D;
	Wed,  9 Dec 2020 10:30:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDBD9167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607506303;
	bh=eyQovcG0AQj0yOyWJEU00KPsyZ6dqo+L+jsH4XdLdJw=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fjmifdf9ymtmUBYzkWfNoGU0u5i54la9Y1s3PDkkVQU1k9klCrS8lnSlFIooy7jet
	 hkxMUsIUXyWXN2py48s5y7QsndI3ug6nQl5BeGzncenuzF4zGJJG3DhYz1Bp7bqlnz
	 7egzV+KQr2CqA1ZA9XaqebXrAz7ExCeuQ+cvvTxo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E458F801D8;
	Wed,  9 Dec 2020 10:30:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0D05F8020D; Wed,  9 Dec 2020 10:30:51 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8672F8012C
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2020 10:30:47 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id BD8D8A0040;
 Wed,  9 Dec 2020 10:30:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz BD8D8A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1607506246; bh=9GTDhoswd8Q/CdEMrU1q6dHbJBYC2QPDhcgl7fOL53k=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ArUF5ZmGoiik+JL616ihE8vdsYZRRR04AwkpYVhA4c5FCGP3zJq1xSARrMe+g72Gx
 Jnbwfbzqfncp+0dHrNRhmmXKDSW7tJ6v4ufL4W3n4wtYha/kkw+a8L5qK87PiiBkrw
 q17x3inO5qKDSMimxYMUGHztaFCovZ9lzTGECD6Y=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  9 Dec 2020 10:30:43 +0100 (CET)
Subject: Re: [PATCH] ASoC: rt1015p: delay 300ms after SDB pulling high for
 calibration
To: Tzung-Bi Shih <tzungbi@google.com>, broonie@kernel.org
References: <20201209033742.3825973-1-tzungbi@google.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <fd713bbf-2983-8803-1ac3-3d9a59efaf6a@perex.cz>
Date: Wed, 9 Dec 2020 10:30:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201209033742.3825973-1-tzungbi@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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

Dne 09. 12. 20 v 4:37 Tzung-Bi Shih napsal(a):
> RT1015p needs 300ms delay after SDB pulling high for internal
> calibration during the power on sequence.
> 
> Delays 300ms right before data sends out to avoid data truncated.

I think that this codec driver should be redesigned to add this power-up delay
the the correct sequence like in rt1015.c - rt1015_amp_drv_event().

Those huge delays in the trigger callbacks looks and are messy.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
