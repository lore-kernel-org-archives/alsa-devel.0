Return-Path: <SRS0=h1r5=K4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411C0C47083
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 14:26:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7AF610A1
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 14:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7AF610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5960816E5;
	Wed,  2 Jun 2021 16:26:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5960816E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622644013;
	bh=WIdqzWNWXk4L4hyoB4ylnTTeafS8wyPs1URE7QLSYjY=;
	h=Date:Subject:From:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nsPAsss9tcahM5PwphEiCxLQMV6PAI1vHSNsZHS7Xwhsku4JHESlACS/ZKi1ggBvk
	 mv+OMJMid0wJDEjK/8YqNVYV6UV4NnV7ZqZ6KKkJ26iCXrxUB6k2NoAnvjXfXLARN1
	 Q6SH9ktXv0pIart+rrl/4jV9g+/W/JsStBnQo4WY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1D17AF804E2;
	Wed,  2 Jun 2021 16:23:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6540CF80254; Wed,  2 Jun 2021 01:58:30 +0200 (CEST)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6AD03F801DB
 for <alsa-devel@alsa-project.org>; Wed,  2 Jun 2021 01:58:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6AD03F801DB
Received: by mail-io1-f69.google.com with SMTP id
 w5-20020a6bf0050000b029043afd24a1b2so312518ioc.12
 for <alsa-devel@alsa-project.org>; Tue, 01 Jun 2021 16:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
 bh=1bUz8YuEhOiCSOWYoBXJvFGKkMXVnnucD2WG3GR0LaU=;
 b=ZLJ+HFo4/r0i3gEOqONVLcjAXGv6mmGacbTk60LnehiTyaoi79rMyGJjCJ9Mki/tp5
 xRqZUifGFn683/QkPh1Agu3TAEgVVsQVAM/+aAXzxXz+mSVjmpQKl+cWTzFVgBFmziUC
 KzdBAdSjcOc9TXSJ4XgVGHOAkxTZc2oEHhpkbwMK5S4HhNAwbA9KwIflTX/5/3IWYFem
 jlEeL8Um2Eyh4xDz/4BP5KFEd0hHTr8xe1QIuJDIsw7AUcy8jJIObSVj9HedAb/z2l8h
 TmKpT34CpH4a0x+c3tUrdCKwQDDwJs8cLXODpb2zQQ0KVJ4HWlrbi+TwfyQAr72znhdN
 N0+g==
X-Gm-Message-State: AOAM532w3WXH6rzH+MOXW3Rl2HwoEvHTepUWqrJhlxyjNesdIEO67W/Q
 pRKWTLIx+yXcDNhlBlUSgNf10jprkXy9y+7KI3uM0BmtcB7R
X-Google-Smtp-Source: ABdhPJy8hzpSJro6cMl9g+BVdFkchFCz0amXoYys752OUloZyyPj+9iNat4yd78Xphl7/kNH2+p1EE/Xh7QvlbhT0RIRmCi00BYP
MIME-Version: 1.0
X-Received: by 2002:a92:d312:: with SMTP id x18mr1882262ila.90.1622591901356; 
 Tue, 01 Jun 2021 16:58:21 -0700 (PDT)
Date: Tue, 01 Jun 2021 16:58:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5560e05c3bd1d63@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in snd_timer_user_ccallback
From: syzbot <syzbot+d102fa5b35335a7e544e@syzkaller.appspotmail.com>
To: allen.lkml@gmail.com, alsa-devel@alsa-project.org, joe@perches.com, 
 linux-kernel@vger.kernel.org, perex@perex.cz, 
 pierre-louis.bossart@linux.intel.com, romain.perier@gmail.com, 
 syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 02 Jun 2021 16:23:04 +0200
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

Hello,

syzbot found the following issue on:

HEAD commit:    5ff2756a Merge tag 'nfs-for-5.13-2' of git://git.linux-nfs..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17872d5bd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=770708ea7cfd4916
dashboard link: https://syzkaller.appspot.com/bug?extid=d102fa5b35335a7e544e

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d102fa5b35335a7e544e@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in sound/core/timer.c:1376:23
shift exponent 105 is too large for 32-bit type 'int'
CPU: 1 PID: 10368 Comm: syz-executor.1 Not tainted 5.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x141/0x1d7 lib/dump_stack.c:120
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:327
 snd_timer_user_ccallback.cold+0x19/0x1e sound/core/timer.c:1376
 snd_timer_notify1+0x243/0x3b0 sound/core/timer.c:525
 snd_timer_stop1+0x641/0x890 sound/core/timer.c:656
 snd_timer_pause+0x6e/0x90 sound/core/timer.c:738
 seq_timer_stop sound/core/seq/seq_timer.c:331 [inline]
 snd_seq_timer_stop+0x93/0xd0 sound/core/seq/seq_timer.c:341
 queue_delete+0x42/0xa0 sound/core/seq/seq_queue.c:133
 snd_seq_queue_client_leave+0x37/0x1a0 sound/core/seq/seq_queue.c:552
 seq_free_client1.part.0+0x10a/0x260 sound/core/seq/seq_clientmgr.c:280
 seq_free_client1 sound/core/seq/seq_clientmgr.c:273 [inline]
 seq_free_client+0x7b/0xf0 sound/core/seq/seq_clientmgr.c:301
 snd_seq_release+0x4d/0xe0 sound/core/seq/seq_clientmgr.c:382
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 tracehook_notify_resume include/linux/tracehook.h:189 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:174 [inline]
 exit_to_user_mode_prepare+0x272/0x280 kernel/entry/common.c:208
 __syscall_exit_to_user_mode_work kernel/entry/common.c:290 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:301
 do_syscall_64+0x47/0xb0 arch/x86/entry/common.c:57
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x4193eb
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:0000000000a9fb80 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 00000000004193eb
RDX: 0000000000571b58 RSI: ffffffff89166efe RDI: 0000000000000004
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000001b2ea280a8
R10: 00000000000001d1 R11: 0000000000000293 R12: 000000000014d248
R13: 00000000000003e8 R14: 000000000056bf80 R15: 000000000014d1dd
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
