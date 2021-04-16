Return-Path: <SRS0=6+tk=JN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EEBC433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 08:48:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6561C6117A
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Apr 2021 08:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6561C6117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4DD6D1681;
	Fri, 16 Apr 2021 10:47:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4DD6D1681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618562917;
	bh=JZg8f1F8a1Md02zLDIzbIBcKzxpYIzzDRdypdi8TYp8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iCNI/Uvux3FpJs/YDD2eLi6HPdH8fBQR/BFXOptULQ3OzhaFpIvtOKwBWg4PyGutJ
	 dl6YjSk44O+iTLLaYpdXKk1CbdQlM9V8dPk6CgqykBIr3k8Vm2Fo0aW2ciCYWhiNHP
	 bC09JA3Lm8n3b1y3y8tlmegFdX1M7o4hP8NO4ZMA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CABC2F80128;
	Fri, 16 Apr 2021 10:47:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C46D6F8025B; Fri, 16 Apr 2021 10:47:45 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5AEE8F800FF
 for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2021 10:47:37 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 987D9A003F;
 Fri, 16 Apr 2021 10:47:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 987D9A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1618562856; bh=AmkbujIfNOg+DUFfhVYfHM3AWLfYLcTKSlg8oG5GToI=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=076RpVrInGoiB9nCKAsul3vEmQyUnufLNRJqH/595JkmWpHzf75lOF64rOIEDZlYH
 eZ2Y+sBKCFIZxW95aVL8mpr/M5CQjxASHZJjLdy1d+fdRUsemL7Wjk/plwoFwIvQ7/
 ERgH0zYOQTjiNm3RwuRy6aQS+aUN6ug5sU34ZS1c=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 16 Apr 2021 10:47:32 +0200 (CEST)
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Lenovo Ideapad S740
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Kailang Yang <kailang@realtek.com>
References: <20210416081211.20059-1-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <be178038-8e42-34db-3804-f27240b2d488@perex.cz>
Date: Fri, 16 Apr 2021 10:47:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210416081211.20059-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Ryan Prescott <ryan@cousinscomputers.net>
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

Dne 16. 04. 21 v 10:12 Takashi Iwai napsal(a):
> Lenovo Ideapad S740 requires quite a few COEF setups to make its
> speakers working.  The verb table was provided from Ryan Prescott as
> the result of investigation via qemu:
>   https://github.com/ryanprescott/realtek-verb-tools/wiki/How-to-sniff-verbs-from-a-Windows-sound-driver

[Cc: to Kailang / Realtek]

I believe that this sequence contains I2C writes to amplifier chips. It would
be really helpful, if Realtek can provide more information for the I2C master
interface for their codecs (describe basic I2C I/O).

				Thank you,
						Jaroslav
						

> 
> BugLink: https://github.com/thesofproject/linux/issues/2748
> Tested-by: Ryan Prescott <ryan@cousinscomputers.net>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/ideapad_s740_helper.c | 492 ++++++++++++++++++++++++++++
>  sound/pci/hda/patch_realtek.c       |  11 +
>  2 files changed, 503 insertions(+)
>  create mode 100644 sound/pci/hda/ideapad_s740_helper.c
> 
> diff --git a/sound/pci/hda/ideapad_s740_helper.c b/sound/pci/hda/ideapad_s740_helper.c
> new file mode 100644
> index 000000000000..564b9086e52d
> --- /dev/null
> +++ b/sound/pci/hda/ideapad_s740_helper.c
> @@ -0,0 +1,492 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Fixes for Lenovo Ideapad S740, to be included from codec driver */
> +
> +static const struct hda_verb alc285_ideapad_s740_coefs[] = {
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x10 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0320 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x24 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0041 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x24 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0041 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x007f },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x007f },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x003c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0011 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x003c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0011 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x000c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001a },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x000c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001a },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x000f },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0042 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x000f },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0042 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0010 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0040 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0010 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0040 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0003 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0009 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0003 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0009 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x004c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x004c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001d },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x004e },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001d },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x004e },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001b },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001b },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0019 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0025 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0019 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0025 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0018 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0037 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0018 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0037 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001a },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0040 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001a },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0040 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0016 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0076 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0016 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0076 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0017 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0010 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0017 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0010 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0015 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0015 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0015 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0015 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0007 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0086 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0007 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0086 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0002 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0002 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0002 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0002 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x24 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0042 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x24 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0042 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x007f },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x007f },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x003c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0011 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x003c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0011 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x000c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x002a },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x000c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x002a },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x000f },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0046 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x000f },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0046 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0010 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0044 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0010 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0044 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0003 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0009 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0003 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0009 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x004c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x004c },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001b },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001b },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0019 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0025 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0019 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0025 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0018 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0037 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0018 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0037 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001a },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0040 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x001a },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0040 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0016 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0076 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0016 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0076 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0017 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0010 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0017 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0010 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0015 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0015 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0015 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0015 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0007 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0086 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0007 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0086 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0002 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0002 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0001 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x29 },
> +{ 0x20, AC_VERB_SET_COEF_INDEX, 0x26 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0002 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0x0000 },
> +{ 0x20, AC_VERB_SET_PROC_COEF, 0xb020 },
> +{}
> +};
> +
> +static void alc285_fixup_ideapad_s740_coef(struct hda_codec *codec,
> +					   const struct hda_fixup *fix,
> +					   int action)
> +{
> +	switch (action) {
> +	case HDA_FIXUP_ACT_PRE_PROBE:
> +		snd_hda_add_verbs(codec, alc285_ideapad_s740_coefs);
> +		break;
> +	}
> +}
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 50437ec1b9af..1ef40f3ca259 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -6239,6 +6239,9 @@ static void alc_fixup_thinkpad_acpi(struct hda_codec *codec,
>  /* for alc295_fixup_hp_top_speakers */
>  #include "hp_x360_helper.c"
>  
> +/* for alc285_fixup_ideapad_s740_coef() */
> +#include "ideapad_s740_helper.c"
> +
>  enum {
>  	ALC269_FIXUP_GPIO2,
>  	ALC269_FIXUP_SONY_VAIO,
> @@ -6436,6 +6439,7 @@ enum {
>  	ALC282_FIXUP_ACER_DISABLE_LINEOUT,
>  	ALC255_FIXUP_ACER_LIMIT_INT_MIC_BOOST,
>  	ALC256_FIXUP_ACER_HEADSET_MIC,
> +	ALC285_FIXUP_IDEAPAD_S740_COEF,
>  };
>  
>  static const struct hda_fixup alc269_fixups[] = {
> @@ -7920,6 +7924,12 @@ static const struct hda_fixup alc269_fixups[] = {
>  		.chained = true,
>  		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
>  	},
> +	[ALC285_FIXUP_IDEAPAD_S740_COEF] = {
> +		.type = HDA_FIXUP_FUNC,
> +		.v.func = alc285_fixup_ideapad_s740_coef,
> +		.chained = true,
> +		.chain_id = ALC269_FIXUP_THINKPAD_ACPI,
> +	},
>  };
>  
>  static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> @@ -8263,6 +8273,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x17aa, 0x3176, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),
>  	SND_PCI_QUIRK(0x17aa, 0x3178, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),
>  	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940", ALC298_FIXUP_LENOVO_SPK_VOLUME),
> +	SND_PCI_QUIRK(0x17aa, 0x3827, "Ideapad S740", ALC285_FIXUP_IDEAPAD_S740_COEF),
>  	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
>  	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
>  	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
> 


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
