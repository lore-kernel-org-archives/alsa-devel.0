Return-Path: <SRS0=73/o=GS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B92C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 17:46:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39F3A23A5E
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jan 2021 17:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F3A23A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3B241833;
	Fri, 15 Jan 2021 18:45:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3B241833
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610732780;
	bh=uL/3sPldJ83uzUiGAqu8Kj7MEj2vf1ich6I7TgLH2BE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sCWhr3bTC/5W98lyQNGkHuTHjzcMy/QGQbxTcVE51bbG+6WCCe3kfx60XhKf+E3EE
	 iAnXgMEHr9sNk8sSsPYKAz2cxuAlzJ9t/9bFsQ+yKJj4MJxkzZ0kwLlvvp538eGShV
	 PETz0BWzt5DX72okR2qi+J3JO9u1wb6rJSzESsBE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44251F8016D;
	Fri, 15 Jan 2021 18:45:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5BD6F801ED; Fri, 15 Jan 2021 18:45:28 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 869ECF80132
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2021 18:45:17 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 72575A003F;
 Fri, 15 Jan 2021 18:45:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 72575A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1610732717; bh=ScepwTnzXXA7OggAxElJWtydVnAyli2McfhGPWFsFM8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=BW9m+nVu6vswkSK5x6EJFf6KyJE7oSUp5kov5JWiKhVAciz+Vtc/Vao5PwVvuGFT0
 l6B2GLLWvD2ptRKERqBZLhpOPaFaIv88sBD3X+S+IfeNYGf/AtSiIf7u+XZMN5MSC3
 92jmrxF6Gi1aZKe2WS4nOGcMGMHoQJxE6X0glcZs=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 15 Jan 2021 18:45:08 +0100 (CET)
Subject: Re: [PATCH v3 3/3] ASoC: rt715:add micmute led state control supports
To: Perry Yuan <Perry.Yuan@dell.com>, oder_chiou@realtek.com, tiwai@suse.com, 
 hdegoede@redhat.com, mgross@linux.intel.com
References: <20210112171814.5404-1-Perry_Yuan@Dell.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <1765b000-ac56-7373-b544-b5d9daa1565b@perex.cz>
Date: Fri, 15 Jan 2021 18:45:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112171814.5404-1-Perry_Yuan@Dell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com,
 Mario.Limonciello@dell.com
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

Dne 12. 01. 21 v 18:18 Perry Yuan napsal(a):

> +#if IS_ENABLED(CONFIG_DELL_PRIVACY)
> +	/* dell privacy LED trigger state changed by muted/unmute switch */
> +	if (mc->invert) {
> +		if (ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1]) {
> +			rt715->micmute_led = LED_OFF;
> +		} else {
> +			rt715->micmute_led = LED_ON;
> +		}
> +		ledtrig_audio_set(LED_AUDIO_MICMUTE, rt715->micmute_led);
> +	}
> +#endif

[removing lkml and x86-platform lists]

Looking to this code, perhaps, it may be a good idea to move the LED trigger
handling from the low-level drivers and do it in the top-level control code
(sound/core/control.c). Adding a new flag SNDRV_CTL_ELEM_ACCESS_MIC_LED may be
an option and we can nicely handle the situation for multiple microphones (OR
operation). The motivation is to remove the duplicated code.

The same situation is for the playback LED.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
