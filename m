Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B050C46467
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Jan 2023 09:08:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EC977BA7;
	Tue,  3 Jan 2023 10:07:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EC977BA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672736918;
	bh=q00U9RqLgpUCNmnt+oXctgDHb9Mzc53/vjzLslYvqZY=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=HSk7rFTK655NIvurOKUbHRwqKDUoVv2+yeu578zts/Fz+WP2oAPZLB6JHx9hO7RtY
	 kiGmA5Iibf2oj42QgMI3foorUmdAiBhTOYCphL3CUE9naPDMAfniqAIPvDg4dzvQBH
	 urHMLacC5OARpvJYuh7PmJ/kpklcmv8gtLJiJCCI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EDEA7F803DC;
	Tue,  3 Jan 2023 10:07:47 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55B72F804CB; Tue,  3 Jan 2023 10:07:46 +0100 (CET)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6EF4F800C0
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2023 10:07:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6EF4F800C0
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1pCdGo-0004iD-ON; Tue, 03 Jan 2023 10:07:42 +0100
Message-ID: <bf646395-1231-92f6-7c5a-5b7765596358@leemhuis.info>
Date: Tue, 3 Jan 2023 10:07:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: USB-Audio regression on behringer UMC404HD
Content-Language: en-US, de-DE
To: Michael Ralston <michael@ralston.id.au>, alsa-devel@alsa-project.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <CAC2975JXkS1A5Tj9b02G_sy25ZWN-ys+tc9wmkoS=qPgKCogSg@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CAC2975JXkS1A5Tj9b02G_sy25ZWN-ys+tc9wmkoS=qPgKCogSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1672736865;
 d4298c71; 
X-HE-SMSGID: 1pCdGo-0004iD-ON
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
Cc: Takashi Iwai <tiwai@suse.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; all text you find below is based on a few templates
paragraphs you might have encountered already already in similar form.
See link in footer if these mails annoy you.]

[CCing alsa maintainers]

On 02.01.23 18:29, Michael Ralston wrote:
> I'm currently experiencing a regression with the audio on my Behringer
> U-Phoria UMC404HD.
> 
> Alsa info is at:
> http://alsa-project.org/db/?f=f453b8cd0248fb5fdfa38e1b770e774102f66135
> 
> I get no audio in or out for this device with kernel versions 6.1.1 and 6.1.2.
> 
> The versions I have tried that work correctly include 5.15.86 LTS,
> 5.19.12, and 6.0.13–16.
> 
> When I run this on 6.1.1, it will just hang until I ctrl+c:
> aplay -D plughw:1,0 /usr/share/sounds/alsa/Front_Center.wav
> 
> I've run strace on that command, and its output is at:
> https://pastebin.com/WaxJpTMe
> 
> Nothing out of the ordinary occurs when aplay is run, according to the
> kernel logs.
> 
> Please let me know how I can provide additional debugging information
> if necessary.

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced v6.0..v6.1
#regzbot title alsa: usb: audio stopped working
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (see page linked in footer for details).

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
