Return-Path: <SRS0=phwE=HF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B0BC433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 07:05:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3520A64F58
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 07:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3520A64F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7CC2E1715;
	Wed,  3 Feb 2021 08:04:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7CC2E1715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612335934;
	bh=LSOf52fYVkRSTBnFd1bzbRQabsHF+Uvth8ycHG9rZjk=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SOY0x+UHQco1xixC8/N12m8aV2U4BxlCWFUojmxmqnAmjdst31OkEqTLq9DlJfllS
	 lJQrPOn/kLNsTkcKuHl0TkJfvGw7Z7oXu6ZLa7k/a93WB8ofmw85foolo4j/fj4HrT
	 fX9NVO0tZlshjdN0YZ7Yi4wk6JAi5LCBoZmnC7ho=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0473F8032C;
	Wed,  3 Feb 2021 08:01:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 24B3FF80153; Mon,  1 Feb 2021 14:50:20 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE051F800E9
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 14:50:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE051F800E9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="eWRTVL2P"
Received: by mail-ej1-x62f.google.com with SMTP id rv9so24415123ejb.13
 for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2021 05:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Y1Df4LH+Y0zoxGq21LHpxb87caJes3LsQhEeQ5x8tjc=;
 b=eWRTVL2PTxrv9ifRtXYVY9KhWlY5z661QDYqwSuBGRR2jvyYJP8WFWkuEsUdFsc5/H
 nZsX47YRnnvbQOObSp+Rq9YxoiABJNQQVgRWiBvFYTPQO8IxjI4wXpJMFrQHvLhhMuuw
 8sseVzDNU0xTpE0ZU2JacXMzI9NQ5R/pyPHAH/zIFsKAAZ2W3LNsqY5Nv/x7h5LHfyYD
 FXeIK195qCVaQejkVP3B+3KCY0GwRyfCtixYuNbkKk+xWYA5c05oRuLZ+jfQeWKYjG0I
 5/8O69ztkRGy0z8VoREh0EAgwhU4Z+DXnRC12ffP8fCvOoL+brCYbjtsXnQ4JWhQ9Jiq
 w4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Y1Df4LH+Y0zoxGq21LHpxb87caJes3LsQhEeQ5x8tjc=;
 b=VTEkEDnjyHJflzV3GtNhIi/qYSRayJQm62TvglBhTeRjBaAFo+6YWQY4JyXZHaw0R9
 BPngrQgJ247czV84dLgakApRB/sfpjGiflBcXA9sleWdwF5iUBEoMMY4jWn08O/pJy4C
 GOYKQP9sDT91n+buIGg2cc2jakJHfi8Scuri4GTwWGUL88C4ZiQRJwqT1PBqQZWmCQXD
 5DlqcdATwa/WodcHHazJEw7XbqyCGX7Pdu8j6dGkYnBAEdWM5eyvo6Ls3QFFAP8ZJkS0
 yoWT3qfpXcUPY0w1+2LtKw9L1x838jIutDFaGtcToXjGjEb0vH8TIBQWnITjwUBFFwqg
 KjVw==
X-Gm-Message-State: AOAM532nkh/r24QDTiBLjoBYARF5zzAtVK1lxjLCSVqFsbYIksCM/rYv
 LwL3+VSX6e6DgPedDjnJCrv0IrQ+xQF8VM0V
X-Google-Smtp-Source: ABdhPJwYSwNS0rkmoEnrEo07Qipp4tKUsRaOc4tDPlCjPgXUTQ2D/Ep85EkSVhhGAwX7Te3gxhGMVQ==
X-Received: by 2002:a17:906:bfcc:: with SMTP id
 us12mr17590331ejb.163.1612187410028; 
 Mon, 01 Feb 2021 05:50:10 -0800 (PST)
Received: from ?IPv6:2a02:8388:1987:9380:198d:5d8b:d8f:7b56?
 (2a02-8388-1987-9380-198d-5d8b-0d8f-7b56.cable.dynamic.v6.surfer.at.
 [2a02:8388:1987:9380:198d:5d8b:d8f:7b56])
 by smtp.gmail.com with ESMTPSA id i90sm845613edi.52.2021.02.01.05.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Feb 2021 05:50:09 -0800 (PST)
Subject: Re: [PATCH] sound: pci/rme9652 - implement and expose controls for
 output
To: Takashi Iwai <tiwai@suse.de>
References: <3cd2889a-e71a-aa3f-e79a-d11a4833c581@gmail.com>
 <s5h35ygji0q.wl-tiwai@suse.de>
From: fassl <superfassl@gmail.com>
Message-ID: <730e7f87-6e6c-77cf-c6cf-2baf23bd1f4c@gmail.com>
Date: Mon, 1 Feb 2021 14:50:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <s5h35ygji0q.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailman-Approved-At: Wed, 03 Feb 2021 08:01:31 +0100
Cc: alsa-devel@alsa-project.org, Allen Pais <allen.lkml@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Colin Ian King <colin.king@canonical.com>,
 Romain Perier <romain.perier@gmail.com>
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

On 01.02.21 09:42, Takashi Iwai wrote:

> snd_ctl_new() can be used for allocating the multiple instances in one
> kcontrol.  If the kctl object is created in this way, you'd just need
> to change your code to retrieve the kctl index via
> snd_ctl_get_ioff() instead of referring to kctl->index directly.
>
Hi, thanks for the response. snd_ctl_new() is static and unexported,
should I provide this patch (below) as well? And if so, together with
this one or separately?

Thanks, best regards


diff --git a/include/sound/control.h b/include/sound/control.h
index 77d9fa10812d..a5920090fdca 100644
--- a/include/sound/control.h
+++ b/include/sound/control.h
@@ -116,6 +116,7 @@ typedef int (*snd_kctl_ioctl_func_t) (struct snd_card * card,
 
 void snd_ctl_notify(struct snd_card * card, unsigned int mask, struct snd_ctl_elem_id * id);
 
+int snd_ctl_new(struct snd_kcontrol **kctl, unsigned int count, unsigned int access, struct snd_ctl_file *file);
 struct snd_kcontrol *snd_ctl_new1(const struct snd_kcontrol_new * kcontrolnew, void * private_data);
 void snd_ctl_free_one(struct snd_kcontrol * kcontrol);
 int snd_ctl_add(struct snd_card * card, struct snd_kcontrol * kcontrol);
diff --git a/sound/core/control.c b/sound/core/control.c
index 3b44378b9dec..066288218b81 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -194,7 +194,7 @@ EXPORT_SYMBOL(snd_ctl_notify);
  *
  * Return: 0 on success, error code on failure
  */
-static int snd_ctl_new(struct snd_kcontrol **kctl, unsigned int count,
+int snd_ctl_new(struct snd_kcontrol **kctl, unsigned int count,
                       unsigned int access, struct snd_ctl_file *file)
 {
        unsigned int idx;
@@ -214,6 +214,7 @@ static int snd_ctl_new(struct snd_kcontrol **kctl, unsigned int count,
 
        return 0;
 }
+EXPORT_SYMBOL(snd_ctl_new);

