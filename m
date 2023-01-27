Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9B2C38142
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Jan 2023 15:42:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23CA2DE5;
	Fri, 27 Jan 2023 16:41:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23CA2DE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674834168;
	bh=aD1OBZKremSLIPsPBKHDbNEiTmYoH/MrfvnLAF1kfM0=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PWrt518fXPnnWfQn2HFfYI0lhajP6Ykr478aMX71LIOqv2eez5aSnK7nwdLajlqvn
	 DGB5T5Yzgc68s85xMuKKOtZuNdBR6XPVnpyIXu5u8qJkf3u6Yxi3CoZABZ7PmfwKrw
	 NDO848SmkvEeuH/wdzQ+TFfso+9pNEHZIdYWE1MI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA1D8F801F7;
	Fri, 27 Jan 2023 16:41:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0D1FCF801F7; Fri, 27 Jan 2023 16:41:56 +0100 (CET)
Received: from ts201-relay02.ddc.teliasonera.net
 (ts201-relay02.ddc.teliasonera.net [81.236.60.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8D25F80074
 for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2023 16:41:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8D25F80074
X-Amavis-Alert: BAD HEADER SECTION, Improper folded header field made up
 entirely of whitespace (char 20 hex): X-Spam_report: ...t@localhost
 for details.  Content previ[...]
Received: from mail.aio.nu (90-228-210-9-no78.tbcn.telia.com [90.228.210.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ts201-relay02.ddc.teliasonera.net (Postfix) with ESMTPS id B0FFF8075D1
 for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2023 16:41:47 +0100 (CET)
Received: from lwaxana.aio.vpn ([10.1.2.16] helo=lwaxana.aio.nu)
 by mail.aio.nu with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <aio.alsadevel@aio.nu>)
 id 1pLQrJ-000GZi-1y for alsa-devel@alsa-project.org;
 Fri, 27 Jan 2023 16:41:46 +0100
Received: from [10.1.2.20] ([10.1.2.20]) by lwaxana.aio.nu with ESMTPSA
 id tk4EIbbw02MPmAAA88T9bw (envelope-from <aio.alsadevel@aio.nu>)
 for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2023 16:41:45 +0100
Message-ID: <8e1c4dee-7643-807b-737c-276708a3ab8d@aio.nu>
Date: Fri, 27 Jan 2023 16:41:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To: alsa-devel@alsa-project.org
From: AiO <aio.alsadevel@aio.nu>
Subject: Bug? Strange crash with snd_hdspm and RME RayDAT on MIDI-input
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam_score: -1.0
X-Spam_score_int: -9
X-Spam_bar: -
X-Spam_report: Spam detection software,
 running on the system "christine.aio.vpn", 
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 root@localhost for details. Content preview:  Hello there,
 I've tried to find some insights in a weird problem
 I have with snd_hdspm. I guess it is an error-report/bug-posting. Audio-wise
 everything is super-duper, so don't worry. However... MIDI only works outbound
 from the on-board MIDI interface. 
 Content analysis details:   (-1.0 points, 5.0 required)
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

Hello there,

I've tried to find some insights in a weird problem I have with 
snd_hdspm. I guess it is an error-report/bug-posting.

Audio-wise everything is super-duper, so don't worry. However... MIDI 
only works outbound from the on-board MIDI interface.

MIDI-out always works perfectly from the card during normal operations.

Whenever I connect anything to the MIDI-in and start feeding some 
MIDI-data, it seems ALSA crashes on me. here's a more detailed description:

* I'm running linux-rt 6.0.5.14.realtime1-3-rt #1 SMP PREEMPT_RT (Arch)

* When i give it a stream of MIDI data on the MIDI-in while playing
   some audio that application (e.g. mplayer or live inputs) logs:

   ALSA: poll time out, polled for 1999005 usecs, Retrying with a
   recovery, retry cnt = 1 (2, 3, 4, 5, and so on)

   And ALSA seem stuck in looping the last buffer over and over.

* Nothing in journal, nothing in dmesg tells anything more about it

What did I run in to?! :)

Kind regards,
AiO
