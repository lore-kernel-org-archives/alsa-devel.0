Return-Path: <SRS0=v73L=ZE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44E7C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:18:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3731A206BB
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ey+1VDyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3731A206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 627131684;
	Tue, 12 Nov 2019 11:17:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 627131684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573553928;
	bh=LuTxY3rdFlZCzrsjTYfy0O+lwOx5G2jdkhtfQzGq+YI=;
	h=Date:In-Reply-To:From:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=Ey+1VDyh7sxi/Y+rT5+so+XnLOADp0PP/o6cMoNKoUnOPFTFHv5OTTNgYwXttEr/q
	 REbGjU/pzG4U3bDwt51grZkhqgC24xdUAnS+MY6HPmBqHK4Lev761zR1J0BCuM/Xaq
	 KtYJMxYnuQi08DsIZzYLouJbnZBjFlaIc8MHUyZQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2453CF80639;
	Tue, 12 Nov 2019 11:14:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F2C9F80506; Tue, 12 Nov 2019 00:45:06 +0100 (CET)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 654CEF8015C
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2019 00:45:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 654CEF8015C
Received: by mail-io1-f71.google.com with SMTP id w1so14731092ioj.9
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 15:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
 :from:to;
 bh=upaZmQpBla0D2GJufrH+1eVVJ7+lAzflwX+ckLKLrsg=;
 b=b3ZEHPb7L/e6yVEf7DzKj0NOneGt14ZotfsjqQZa8Zi9cCkQz5VQAEXWZjN8pa6ESZ
 uyFvv0ps69kdX+98Esz5NldI4nB1WnSJVcOVGSjcQ6CoU0uOBkuQQ0Pw+kpWlDl+wnp8
 FE2QlP/M/8J5qZsDXfTwPqshb0rvxWhHn5WEv/2b3Eyf+Vy1j+cAft4jHA3AmwOFQHGL
 hUD09kfRmjoemTA2iUsq/Ervru3TlHjQCB6l91h0CL5HHyEkDfPXJRIRDq4PtS970SL7
 PStids78hhhBTa4mwZMQwQTF+wh42KXY2ErPOry/jTL14Cg91zPdPwmX5uczcJd0K1af
 1i5Q==
X-Gm-Message-State: APjAAAWdLqDMjc68cAv2Rc2pnPgfF40qwXiFmpko4VyyNzk9u29+DP5l
 owxrAZ8Jsb6EmOPsuJVWg6OeWL/J58Rddq35X75zn9KZfnFI
X-Google-Smtp-Source: APXvYqxq9lv/VmQ8ezGOcmCF95BVBz118ALVK0je34s/k1S1HcLJ9P5+EYXmjYbL1lVyXHvAoXlRLBYt7xYeZz2aTy9+bxdsRhud
MIME-Version: 1.0
X-Received: by 2002:a6b:660b:: with SMTP id a11mr15664068ioc.283.1573515901287; 
 Mon, 11 Nov 2019 15:45:01 -0800 (PST)
Date: Mon, 11 Nov 2019 15:45:01 -0800
In-Reply-To: <0000000000007f69a2059714b34d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058443705971ab84d@google.com>
From: syzbot <syzbot+4476917c053f60112c99@syzkaller.appspotmail.com>
To: alexandre.belloni@bootlin.com, allison@lohutok.net, 
 alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org, 
 bhelgaas@google.com, enric.balletbo@collabora.com, gregkh@linuxfoundation.org, 
 kirr@nexedi.com, linux-kernel@vger.kernel.org, lkundrak@v3.sk, 
 logang@deltatee.com, perex@perex.cz, rfontana@redhat.com, 
 syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tiwai@suse.com, 
 tiwai@suse.de
X-Mailman-Approved-At: Tue, 12 Nov 2019 11:14:25 +0100
Subject: Re: [alsa-devel] KASAN: use-after-free Read in snd_timer_open
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

syzbot has bisected this bug to:

commit 6a34367e52caea1413eb0a0dcbb524f0c9b67e82
Author: Takashi Iwai <tiwai@suse.de>
Date:   Thu Nov 7 19:20:08 2019 +0000

     ALSA: timer: Fix possible race at assigning a timer instance

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b5dde6e00000
start commit:   6980b7f6 Add linux-next specific files for 20191111
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15b5dde6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11b5dde6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2af7db1972ec750e
dashboard link: https://syzkaller.appspot.com/bug?extid=4476917c053f60112c99
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108fbfece00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1055d5aae00000

Reported-by: syzbot+4476917c053f60112c99@syzkaller.appspotmail.com
Fixes: 6a34367e52ca ("ALSA: timer: Fix possible race at assigning a timer  
instance")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
