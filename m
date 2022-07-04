Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88BA3C43334
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jul 2022 07:52:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 90B3916D5;
	Mon,  4 Jul 2022 09:51:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 90B3916D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656921147;
	bh=raPJ0HltWJiQR1XJH+KNJh6e17udYDMeFXu00szNN+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=feslvXpCS2k1/8+X9kv2DiOAkhbDAGKRhkJnJ72ZkV8jkyZw9XPhvqkshgoqbi2/b
	 Tm0sKwIdz3o5S7VRO6iMxdN3GfTQGrJB5PMYG5ZOzpJ4Uztk2+m/QBhNTSVCwzCJTz
	 j5Kwt+fucPgxVt3G8121HmMESYTnCzWX1xemJH/A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36FBBF8014E;
	Mon,  4 Jul 2022 09:51:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35A96F8014E; Mon,  4 Jul 2022 09:51:35 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 198E3F80139
 for <alsa-devel@alsa-project.org>; Mon,  4 Jul 2022 09:51:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 198E3F80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="HuoSzlhW"
Received: by mail-lj1-x233.google.com with SMTP id o23so10010019ljg.13
 for <alsa-devel@alsa-project.org>; Mon, 04 Jul 2022 00:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+ULobm+VCN9QC0SiaWvcA/Mc/bgYryB1cayxPAIAM4E=;
 b=HuoSzlhWy/Sd+i86BsF1pudkVOgoNR4N+zJTiPoUiG1MqSW6eFjBf0mGa/8WcxBqZm
 2nGkpI4+j3aFejxTDspWTvVnGgl9OeZ/lRpLHYoyjlb4luahZ0J+VnwRDld7aVXs5j8F
 CAWCxtKlbdUASc3awyVKx7Wop4TNXb68axwZ+HAN6+fm5ZVUadBP8eQDrjLZSICkAxWt
 ZzzMn5ivdnEZC/wzUVdhbhnpi1BNB6qrdkyKjoJO7LFor45ACKW6R1UHk4cqDgOos6Ht
 CbSmUsO6yI2JoqLH5OBLWRyYQjjTwDb7f1IM+++HdXoZz5z4/1WdGylE6tHewGfPAour
 9cCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+ULobm+VCN9QC0SiaWvcA/Mc/bgYryB1cayxPAIAM4E=;
 b=KxgnJl1SiB75MODDcMr/6X6Xl6dcJdxkK1s8MC0nNYoup8kkxjk6PY9P9SOBbmetzE
 byRN+Hw8S/+B+PUmGGN2fi+vVsBRu2RVWsT0u8ovk8Q1RW2m3rGYqQG3f40YRsZuImAJ
 /PMmds4lDa+8QyWijrvfUq89vpsl+RqBIKEfULQm62fuvQAuwlXpFfRUxC0BevXo5t1+
 RZ7TzeD1QbDrPRYpvlZH7rahltBIVsurmaCy0aJGNEs5SrVTYipIcpEVfyvbMzf8Xlkn
 uPnzzM8T7Lcei8Dgx44vpJL34yrQrzDCdz7l07+xeK9roEyM9IAYVY+h0+fgjN2KzW5l
 BU1Q==
X-Gm-Message-State: AJIora9zUghkUMMbXstO3UhJsA5+MPoArbX9ybp1TQEDgk+jMYaw+CSp
 8/tlUOR1JakBPCosUXAX8TSeRgDNp+qBV7cHEYv1eA==
X-Google-Smtp-Source: AGRyM1sOWXkKniRiwLYzPvdXTy9IWV92rClhT6o0h8bt5CdVK8rEkWmvzY6hbqakopbii3/XQhmGjz/CFprgefSP43U=
X-Received: by 2002:a2e:924b:0:b0:25d:1e72:acf1 with SMTP id
 v11-20020a2e924b000000b0025d1e72acf1mr2669714ljg.92.1656921086661; Mon, 04
 Jul 2022 00:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000915bd505ddaff576@google.com>
 <00000000000049a18105e2c34a0c@google.com>
In-Reply-To: <00000000000049a18105e2c34a0c@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 4 Jul 2022 09:51:15 +0200
Message-ID: <CACT4Y+bZPUDMR50mYSG5s=ABw54_JpHEWSgNDm8TSAQkpyJryg@mail.gmail.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_rawmidi_transmit
To: syzbot <syzbot+39e3268af9968f153591@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, coding@diwic.se, naamax.meir@linux.intel.com,
 tiwai@suse.de, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
 clemens@ladisch.de, hdanton@sina.com, alsa-devel-owner@alsa-project.org,
 linux-kernel@vger.kernel.org, sasha.neftin@intel.com,
 anthony.l.nguyen@intel.com, colin.king@intel.com
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

On Fri, 1 Jul 2022 at 21:21, syzbot
<syzbot+39e3268af9968f153591@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 0125de38122f0f66bf61336158d12a1aabfe6425
> Author: Takashi Iwai <tiwai@suse.de>
> Date:   Wed May 25 13:12:03 2022 +0000
>
>     ALSA: usb-audio: Cancel pending work at closing a MIDI substream
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1180b25c080000
> start commit:   2a5699b0de4e Merge tag 'leds-5.19-rc1' of git://git.kernel..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f915857c44e13980
> dashboard link: https://syzkaller.appspot.com/bug?extid=39e3268af9968f153591
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119d1fcbf00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17716bedf00000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: ALSA: usb-audio: Cancel pending work at closing a MIDI substream
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Looks reasonable:

#syz fix: ALSA: usb-audio: Cancel pending work at closing a MIDI substream
