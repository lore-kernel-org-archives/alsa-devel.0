Return-Path: <SRS0=QPpS=4H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A95CC34022
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 05:22:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0C021D56
	for <alsa-devel@archiver.kernel.org>; Wed, 19 Feb 2020 05:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JR7BarUW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ryvQl3r1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0C021D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 23F571672;
	Wed, 19 Feb 2020 06:21:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 23F571672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582089720;
	bh=RdUk9Dct/U25tAy8Fa6cGoHZ+g0xASQlsvCnkJLUHZE=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JR7BarUWFQW1wGkv9HjvQicQ5f237RBFPlXL73CJIoKYHiuaom9/r91GCwvqA3BaT
	 If/FWhsBK2V5A9nToQS+9WOTUiVQcBa1mOqfzTi9p9B7F9KJE8f7wFgZecic94LRWc
	 SO+G8tf8wqt7V6yFimQe7ZiRU9+xF8lDYtPdLBCc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 88047F800C4;
	Wed, 19 Feb 2020 06:21:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2B08F80172; Wed, 19 Feb 2020 06:21:07 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD616F800C4
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2020 06:21:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD616F800C4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ryvQl3r1"
Received: by mail-io1-xd33.google.com with SMTP id h8so12601991iob.2
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 21:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=xpWVARWKfo9GZs3SdmD0mCrwRe4nrmHwFjHjicHzd/4=;
 b=ryvQl3r1EVuoVdMHlUhgLsQ4dNfPy8QTDiDH6osEgx7PvjfQGW7LpdAseDOUpH2h26
 7/LZabQXs2QBE+LZIxAsG5j7tv+1pvVMzWrLq84Vh+03i47HLRWy+1aw5VsP4VPI5xrU
 YDAdHpIZA8EXmHid0AeKxrFMC6mlJG3ZiN6iVvuZh0LizKBWqWVqjBZCwFJwQqJyHs+I
 geIYEVrg0Vw/m2Q8WfzBZaCrHmRqACUgzFC5b2NvYLzWQPKkbZzRtKltMTJPoVLYA1u7
 JrlpxBjw/pYb5epS3PN77/171plQichYpr/UzN7wZbeuhTs0VSLHiA38Z701q8p/p3WB
 pd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=xpWVARWKfo9GZs3SdmD0mCrwRe4nrmHwFjHjicHzd/4=;
 b=KvVqupq3nURYW4+veWs7v8djR8XORbJvaIr1knzDtQ10fzvYujlEzEtQT3q0ED8wrG
 p+cbbGIW5325T3935qNnkQ9ij7gt1YsH8o7Xw3T4oJRG844EwlsZ/0qk3YQ8tnJqPDEL
 Boa/pT8prqPEPN88V8tWDrDDXpi10BVKDPSird9+8mRWCWEnGxF3n2GDJCPhnvFNBlUN
 +Ic7Ei/6Izngw/RNsi4JC8aiJ2WfCQu55iXtpRXxYbIGPKxwnUGWPBkUtAwuq/Lh3mJd
 krTGq8g/2BsrvhshulJdrgqeoaLRbvH3f3Mx4xKK7OlQQXQF51H4I1P+ki/3997v6P/o
 JEDw==
X-Gm-Message-State: APjAAAU8GSOMdoXaCDHQQzom0eoIShltD7p5y09anmy95xSOeZXzphDZ
 IkwYiEaS5hPb1woWleqgmvjKIxHrKpdgQJJHPdqh1otu
X-Google-Smtp-Source: APXvYqwEueJanX/yDiI9O4XwmlYNR/c15mHov6FQIqnuGo3MH8DwI5qeE3P8oSq5ArbIKHEmONF9bp4nFvV2Ch8jX4A=
X-Received: by 2002:a02:7fd0:: with SMTP id
 r199mr19889571jac.126.1582089661532; 
 Tue, 18 Feb 2020 21:21:01 -0800 (PST)
MIME-Version: 1.0
From: happy musicmaker <happy.musicmaker@gmail.com>
Date: Wed, 19 Feb 2020 13:20:53 +0800
Message-ID: <CAJDJRCoaLXxNFfS+7EV-2o11x5TrRsV9aKkZu5exedRBCU9QyA@mail.gmail.com>
Subject: ALSA raw MIDI API - client hangup and amidi exits midiC3D0 failed:
 Device or resource busy
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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

While developing a client using the raw MIDI interface, bumped into an
issue that
went away after rebooting Ubuntu 19.10 - 64 bit. Using a MIDISPORT 4x4 one
of the 4 ports could not be opened. The client (written in C) call hang and
the client thus went unresponsive. No timeout, no error, no nothing.
CTRL-BREAK the client and retrying many times gave the exact same result,
no other apps were using the port. The other 3 ports on the interface and
any other MIDI USB device connected could be opened and used without any
problem.

When opening the port with amidi, an error was reported, it seems amidi did
not gracefully exit as well.

amidi -receive -p hw:3,0,1
ALSA lib rawmidi_hw.c:233:(snd_rawmidi_hw_open) open /dev/snd/midiC3D0
failed: Device or resource busy
cannot open port "hw:3,0,1": Device or resource busy

Looking at the rawmidi_hw.c code there is a GOTO and SYSERR statement. Not
sure if those caused this .

   if (fd < 0) {
            snd_ctl_close(ctl);
            SYSERR("open %s failed", filename);
            return -errno;
.
After reboot the problem went away. The problem could have been caused
while fixing some by coding issue. Maybe someone with more understanding of
the code can spot an issue in the code. While  many applications use the
raw MIDI interface. believe Bitwig and most others use the sequencer API to
open ports.

Just wanted to log this just in case anyone else experiences this

Thanks.
