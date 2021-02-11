Return-Path: <SRS0=wAKr=HN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7212BC433DB
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 13:04:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A85C64E79
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 13:04:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A85C64E79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA1AF16F0;
	Thu, 11 Feb 2021 14:04:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA1AF16F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613048695;
	bh=cAWkMR8r2DJJGc7nfYkrzxeXooUKMo1hVrcZWX/4Wao=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D34gM2gwuCpqPc7+Acq4GZ+4VKrYr9ZCqGruDZCCDctROWYDcfYsKHAmpGQBXyJAc
	 xbrirScbKE6U14IJrImf92sa/pz7eNiDZzLWs8HEWbweEE1apJ97rmXsD6AHLN+l+H
	 dcrPxgl6Y78DgoC+Xoo+5XNO09yRlNXGNzzNkYZ0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3FF5DF801D5;
	Thu, 11 Feb 2021 14:04:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2575EF801D5; Thu, 11 Feb 2021 14:04:03 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7205F80165
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2021 14:03:55 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5F24AA0046;
 Thu, 11 Feb 2021 14:03:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 5F24AA0046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1613048635; bh=0ppsEZXppjarjW6n2oNCED1zT7otCQ5c9H0otT7qtAg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=EZvdZHsuXXIvciOzMeTle6dm2Ni3OAbEjX/LX2jTXggFCk4YOAKEw/MaCcaq8xznd
 7XbA4th3CInaBfZCISsB3spbst1NLXtOeNbs9m5djMPYS1pa0WKKDMTV2VplQb++s4
 4rktLZPy3gXVxPjBWYtfU/GG2cbwc4WkOdDHSbxE=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Thu, 11 Feb 2021 14:03:48 +0100 (CET)
Subject: Re: [PATCH 4/5] ALSA: HDA - remove the custom implementation for the
 audio LED trigger
To: kernel test robot <lkp@intel.com>,
 ALSA development <alsa-devel@alsa-project.org>
References: <20210211111400.1131020-5-perex@perex.cz>
 <202102112042.XrBbhUg0-lkp@intel.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <9c2bced1-54a2-4cb3-24f2-dfa278a5e88f@perex.cz>
Date: Thu, 11 Feb 2021 14:03:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <202102112042.XrBbhUg0-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>,
 Perry Yuan <Perry.Yuan@dell.com>, kbuild-all@lists.01.org
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

Dne 11. 02. 21 v 13:19 kernel test robot napsal(a):
> Hi Jaroslav,
> 
> I love your patch! Perhaps something to improve:

> All warnings (new ones prefixed by >>):
> 
>    sound/core/control_led.c:49:19: warning: no previous prototype for 'snd_ctl_led_controls_by_access' [-Wmissing-prototypes]
>       49 | struct list_head *snd_ctl_led_controls_by_access(unsigned int access)
>          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> sound/core/control_led.c:244:6: warning: no previous prototype for 'snd_ctl_led_hello' [-Wmissing-prototypes]
>      244 | void snd_ctl_led_hello(void)
>          |      ^~~~~~~~~~~~~~~~~

I'll address both issues in v2 of the patchset (snd_ctl_led_controls_by_access
function should be static and the snd_ctl_led_hello() is obsolete and it
should be removed - a piece from an internal version of my code)

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
