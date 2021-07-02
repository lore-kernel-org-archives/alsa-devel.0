Return-Path: <SRS0=UIcK=L2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D901BC11F68
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Jul 2021 10:35:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB976141C
	for <alsa-devel@archiver.kernel.org>; Fri,  2 Jul 2021 10:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB976141C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marcan.st
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1BB0850;
	Fri,  2 Jul 2021 12:34:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1BB0850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625222115;
	bh=4svOkiQuNkARoTR/qNTWvaD7AEFcdYMGOdMHAoP2z6U=;
	h=To:From:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Q32ndCBVihoaqcUpAkX1Zb1a0Q1hwBxrZ/n0nZM1vRULLj91WGttM2+/s6Y5gqKGQ
	 qCQRNm1hveFJu00+rlMl/Jm3yncGpundMYpTW2usSjBSgGK0y9FmRxsIBbW2ipRAQ9
	 ry9OzaXR6hdqKsZ3ltETQNqwJhbWAGIWGF04nDms=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 28621F80217;
	Fri,  2 Jul 2021 12:34:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52898F80229; Fri,  2 Jul 2021 12:34:23 +0200 (CEST)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF3ADF800BA
 for <alsa-devel@alsa-project.org>; Fri,  2 Jul 2021 12:34:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF3ADF800BA
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: marcan@marcan.st)
 by mail.marcansoft.com (Postfix) with ESMTPSA id AF1C8419BC;
 Fri,  2 Jul 2021 10:34:08 +0000 (UTC)
To: Takashi Iwai <tiwai@suse.de>
From: Hector Martin <marcan@marcan.st>
Subject: [tiwai/for-next] hard lockups with pipewire and snd-usb-audio
Message-ID: <4e71531f-4535-fd46-040e-506a3c256bbd@marcan.st>
Date: Fri, 2 Jul 2021 19:34:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 LKML <linux-kernel@vger.kernel.org>
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

Hi Takashi,

I've been testing builds from your for-next branch to get the recent 
firewire fixes. All that works fine, but instead I've been getting hard 
lockups with pipewire and snd-usb-audio. I'm currently on 9a7b7ec3c6.

Backtrace:

  do_raw_spin_lock+0x8e/0x90
  _raw_spin_lock_irqsave+0x3e/0x50
  ? snd_pcm_period_elapsed+0x10/0x30 [snd_pcm]
  snd_pcm_period_elapsed+0x10/0x30 [snd_pcm]
  snd_usb_endpoint_start+0xd8/0x270 [snd_usb_audio]
  start_endpoints+0x50/0x70 [snd_usb_audio]
  snd_usb_substream_playback_trigger+0x58/0x100 [snd_usb_audio]
  snd_pcm_action+0x74/0xb0 [snd_pcm]
  snd_pcm_action_lock_irq+0x36/0x80 [snd_pcm]
  snd_pcm_ioctl+0x1e/0x30 [snd_pcm]
  __x64_sys_ioctl+0x7d/0xb0
  do_syscall_64+0x45/0x80
  entry_SYSCALL_64_after_hwframe+0x44/0xae

To me it looks like it's recursively trying to lock the stream spinlock.

I'm not sure what version this is a regression from; I've only triggered 
it with pipewire so far, which I wasn't previously using. It's easy to 
reproduce. Usually, pulling up pavucontrol on pipewire with the USB 
audio device on an active profile will do it.

Just thought you might want to know. Let me know if you need any more info.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
