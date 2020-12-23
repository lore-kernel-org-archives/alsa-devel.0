Return-Path: <SRS0=3cEE=F3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73419C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 14:16:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E139B23340
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 14:16:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E139B23340
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6342D171A;
	Wed, 23 Dec 2020 15:15:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6342D171A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608732964;
	bh=EaQ7NKNOQ1DqYf56a04HtUOpjoqnLtP5t+pq9/dWO1k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nAoCPkKdmg+SobiRHu023WgN8zDvE3HvRnbbpm9RI9VoXd77k/ScWP/Y7mA6Y5uC9
	 3s7s21utdG7bfv+nBO3bVl5KHLaO+uUtkbA965I8NAnYG5hS3N2a1SKbZm2Nm+/1F2
	 wvg3zdh05QN6Kp4/Juy8sDQDsDAdE9/4XsfQbTP4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9772F80168;
	Wed, 23 Dec 2020 15:15:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6836F801D5; Wed, 23 Dec 2020 15:15:11 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46387F800BC
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2020 15:15:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46387F800BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qLhu2AfY"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A78552313C;
 Wed, 23 Dec 2020 14:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608732902;
 bh=EaQ7NKNOQ1DqYf56a04HtUOpjoqnLtP5t+pq9/dWO1k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qLhu2AfYQGq3FN+00ITeXrwmDQ3EBqD/yyBe//V4wy7TvoKr+MvCGLlKdIrXuXAF7
 dgJWEn8nBbDY/aFCUu//qH0O99HDCmlbrLkRqGxAH6AhUnAlhwNpPs7wriwRK1Y3hS
 gUKJYI19WvQVl8qhjxBeQtybwkyesn15YCl9JsZz4KfOiQiN52Ir2ZIBKznJF2JKdR
 gl8RULyaEM2aHUoqNQBR5IHJYdM9asfZCtuOffha0CZGON20QdXRTY4oqcY5nxyHYl
 TPp/yXmKSjUlBNkXmQDvlgLgT3uG2ueJhpVgIAWeS2VYAfO9/x1y0/iv26lGaSLfVf
 DCOK9UAh30UGQ==
Date: Wed, 23 Dec 2020 09:15:01 -0500
From: Sasha Levin <sashal@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH AUTOSEL 5.4 057/130] ALSA: usb-audio: Check valid
 altsetting at parsing rates for UAC2/3
Message-ID: <20201223141501.GC2790422@sasha-vm>
References: <20201223021813.2791612-1-sashal@kernel.org>
 <20201223021813.2791612-57-sashal@kernel.org>
 <s5h4kkddmmi.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <s5h4kkddmmi.wl-tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Dylan Robinson <dylan_robinson@motu.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Keith Milner <kamilner@superlative.org>
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

On Wed, Dec 23, 2020 at 08:09:41AM +0100, Takashi Iwai wrote:
>On Wed, 23 Dec 2020 03:17:00 +0100,
>Sasha Levin wrote:
>>
>> From: Takashi Iwai <tiwai@suse.de>
>>
>> [ Upstream commit 93db51d06b32227319dae2ac289029ccf1b33181 ]
>>
>> The current driver code assumes blindly that all found sample rates for
>> the same endpoint from the UAC2 and UAC3 descriptors can be used no
>> matter which altsetting, but actually this was wrong: some devices
>> accept only limited sample rates in each altsetting.  For determining
>> which altsetting supports which rate, we need to verify each sample rate
>> and check the validity via UAC2_AS_VAL_ALT_SETTINGS.  This control
>> reports back the available altsettings as a bitmap.
>>
>> This patch implements the missing piece above, the verification and
>> reconstructs the sample rate tables based on the result.
>>
>> An open question is how to deal with the altsettings that ended up
>> with no valid sample rates after verification.  At least, there is a
>> device that showed this problem although the sample rates did work in
>> the later usage (see bug link).  For now, we accept such an altset as
>> is, assuming that it's a firmware bug.
>>
>> Reported-by: Dylan Robinson <dylan_robinson@motu.com>
>> Tested-by: Keith Milner <kamilner@superlative.org>
>> Tested-by: Dylan Robinson <dylan_robinson@motu.com>
>> BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1178203
>> Link: https://lore.kernel.org/r/20201123085347.19667-4-tiwai@suse.de
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Please drop this for 5.4 or older.  At least this caused some problem
>on 5.3 kernel that confused USB core by some reason while it works
>fine with the recent upstream.

Will do, thanks.

-- 
Thanks,
Sasha
