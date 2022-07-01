Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4ACC43334
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Jul 2022 11:30:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45251173E;
	Mon,  4 Jul 2022 13:29:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45251173E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1656934212;
	bh=hAXD7RkyZeY1Z/pzICzBlS71t/sY8Xi0i9Wvmv0JE6Y=;
	h=Date:In-Reply-To:Subject:From:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=tDvzI1HGQRehHcC2hYHTIfJvUOA9gjYa5WB9XGGZPktuxgITK92yThY3V4jE2KCsx
	 JFHGvr5R4kidVvdWIdyOc4baJn+kg7xVf3waLuQitVsAu8g4DqEu3dk3CfZUb0dczB
	 iRrq5rmvCb7w8yCD4JX7E3KA18VVjiFVWotBdLHg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 73087F805E2;
	Mon,  4 Jul 2022 13:23:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2DCB3F80155; Fri,  1 Jul 2022 21:21:26 +0200 (CEST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB0F4F80152
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2022 21:21:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB0F4F80152
Received: by mail-io1-f70.google.com with SMTP id
 o6-20020a5eda46000000b00674f9e7e8b4so1666731iop.1
 for <alsa-devel@alsa-project.org>; Fri, 01 Jul 2022 12:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
 :from:to;
 bh=ye2No0OzZ5T9BoIg9adcKjLovVqO3+HUrByWi9JzHGY=;
 b=hu+H/VgqBEmAJ3Y+6Tw353M8gK6ti1rCjahjUvqwWUT8QUbNRrRcYuqNNOHBgJjP3n
 VeDWbdjaCAuxUv2lHaYF4CFvQsmo+ayPrK+V7foKkWx73ChuTQrBXkeRuq6wvr19Z5Ua
 gq2CKamWmlBma3bBW/RAuw5UXPaDtWoTjNl4X9YVvW5r/nC6VP+mokst21fX+dRC2iZY
 S0qxyHPoBJvpeztyxpFX9Uf+obGDpGezDRKNnHJKlTu980whcWqbGHSIEtdcx+nzjiot
 Ht8RFHbdgFZFleQA1DSmNV4QIwKMsU4MLhuJVBN3cXiWYMhO+JynO0NsZrJu0z4WG2XY
 HM7w==
X-Gm-Message-State: AJIora8yGKXMNUhB+e164OZh1AgbQvi00apEdYAgNZ73b8uyTqMtAu+0
 bnis2yeEJPixZI1yTHhSz3ENXNhQNG5XqOg7krsnK+Y1/4/J
X-Google-Smtp-Source: AGRyM1v9vKew6tY0ycvE0awvKbkgQJImZOd7ba/9x+s/5xRRgM7XtTnjkOL+gSMcufvz8qKWya7foZ01NirGea8Ij4tjilewvOnT
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26c3:b0:66c:f8b2:53c with SMTP id
 g3-20020a05660226c300b0066cf8b2053cmr8270435ioo.50.1656703276391; Fri, 01 Jul
 2022 12:21:16 -0700 (PDT)
Date: Fri, 01 Jul 2022 12:21:16 -0700
In-Reply-To: <000000000000915bd505ddaff576@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049a18105e2c34a0c@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_rawmidi_transmit
From: syzbot <syzbot+39e3268af9968f153591@syzkaller.appspotmail.com>
To: alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org, 
 anthony.l.nguyen@intel.com, clemens@ladisch.de, coding@diwic.se, 
 colin.king@intel.com, hdanton@sina.com, linux-kernel@vger.kernel.org, 
 naamax.meir@linux.intel.com, perex@perex.cz, sasha.neftin@intel.com, 
 syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 04 Jul 2022 13:23:02 +0200
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

syzbot suspects this issue was fixed by commit:

commit 0125de38122f0f66bf61336158d12a1aabfe6425
Author: Takashi Iwai <tiwai@suse.de>
Date:   Wed May 25 13:12:03 2022 +0000

    ALSA: usb-audio: Cancel pending work at closing a MIDI substream

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1180b25c080000
start commit:   2a5699b0de4e Merge tag 'leds-5.19-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f915857c44e13980
dashboard link: https://syzkaller.appspot.com/bug?extid=39e3268af9968f153591
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119d1fcbf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17716bedf00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ALSA: usb-audio: Cancel pending work at closing a MIDI substream

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
