Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F2CC2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:51:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8214206D5
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BuvLAiDe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CL8dalZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8214206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 167B61695;
	Tue, 14 Apr 2020 09:50:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 167B61695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586850699;
	bh=ZxmgDJQCYvN5UDrL1T5SEa/OomP0wN7bxg+1duIt/Lg=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BuvLAiDePEXRW50v83t1b+irUiqC8VwmUQEy92H1QbP9FC5/oBEatnG0zBI+tCQCZ
	 JKALDZ2qf+EiF34dY4GqrmZO/RgFGcqIOr9xkqZCODTWKp8G0xjtK4bQGc2MCmVgC/
	 ch9NCcM7n2KtyzRT0dPrIKq5NYLLNEUBzJpr+19M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01AB5F80316;
	Tue, 14 Apr 2020 09:42:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0881BF8013D; Sun, 12 Apr 2020 13:43:08 +0200 (CEST)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D917F800B6
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2020 13:42:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D917F800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="CL8dalZj"
Received: by mail-yb1-xb42.google.com with SMTP id t10so3761963ybk.8
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2020 04:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=DlNubOsGgG9UnvRSmJsP6nkFgf/TGrRpd6lbJPBtZIM=;
 b=CL8dalZjC7YzahQHAtKyld4xUc2hrOr3Ikd5KbThOImr8svFvepVXg7wCBKwP4Ue4b
 4a7V0jzah0cSLx7lIzNof3N2I3j/PEB/UmYfIFeOACpDTF/7lon4fKCBRmS4C8+WCFAO
 4QlAoXJBg2Ily8OZE1eNzHu1uEkpR50vKgWvl3r3LOmywrR/R5Eu8GhlvEZMsqZHr5fd
 JkvTQicK3mmE+OTjgiifbv6I3QzySU1IdP3I3MOfKqN8M8HVoHnVBFYYckYuYiPPby9U
 0L9lSK0GjjaNH7C3XV5xeHnj9O6GC4N6WXcEPyzcjy1BpjfeHcR1G5Sdc755Jw2CI6zt
 HTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=DlNubOsGgG9UnvRSmJsP6nkFgf/TGrRpd6lbJPBtZIM=;
 b=MNQzC5DOrcOGKL1Pu+DF+sKChF76k4122B9YB6sgPmic33EUKqCYN3z+NGHIdFkJ7w
 X8aAAIRTmVOpGTtafVIIk9QYbBn2tnxcad0/9clQW5Hi4q7JEWloFLyNf7ImjuuU/GDg
 pDi5C9ZXHvmQo0uyMm97cL3EJMltRWhmELATisvSar+NS6csJwNse23KTIcl+o39v4t7
 ilQCBUSIgCHADHjAv/qP43lOl0E4JLk6addjiMLrcr78e890tQOaTYP/+ExF9nKMXkxY
 lrcqnqhb2AY4jPTqoqGFcUdOoUl7gBO8pvxr8MWE+z5bajh13jZbKuS3928GIO63RTgO
 x7mA==
X-Gm-Message-State: AGi0Pub/QyI960Wh+zj6AoAdCsviUpFAezML7NLqDUZNMSyG6EEkHWhO
 G5waE6iUse4DD/6Rc4iMZhjEZPQjBHq/1w1V9QX7LkdfUDdywR57HLg=
X-Google-Smtp-Source: APiQypK3PGCfgg/NCGRNGvVh3jwQ6opk3PigVFaJTEkkyk/f0ZabcJk1UxbXQ5DeL338fsFqAe/+ls5KgraTjouXFMw=
X-Received: by 2002:a25:800f:: with SMTP id m15mr18976982ybk.320.1586691777525; 
 Sun, 12 Apr 2020 04:42:57 -0700 (PDT)
MIME-Version: 1.0
From: n c <ironincoder@gmail.com>
Date: Sun, 12 Apr 2020 11:42:46 +0000
Message-ID: <CAHTAdq1bmbjHu9fuK-TV-wG2aVCgGTYdhorQjV7LE+Myv1W0xQ@mail.gmail.com>
Subject: desperate to find a fix for ALC298
To: alsa-devel@alsa-project.org
X-Mailman-Approved-At: Tue, 14 Apr 2020 09:41:56 +0200
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

Kernel: linux5.6 (source here
<https://github.com/torvalds/linux/releases/tag/v5.6>)
Distro: Tried most for months since linux5.4 (currently on manjaro)
Desktop: gnome
Alsa-info: (pastebin here <https://pastebin.com/w35JGdGu>)
Any configs: No just the defaults (no alsa/.asound, pulse/client.conf
etc...)
Cards: Single on-board Realtek ALC298

*Issue*
On-board sound does not work at all. Neither on speakers or headphones, no
matter which distro or kernel I tried (since 5.4+ of course).

*Have I asked the community?*
I have a SO question here
<https://unix.stackexchange.com/questions/579486/alsa-pulseaudio-and-intel-hda-pch-with-no-sound>
and a manjaro topic here
<https://forum.manjaro.org/t/alsa-pulseaudio-and-intel-hda-pch-with-no-sound>
.

*Have I tried fixing it myself?*
Yes, a lot. The threads above both have a lot of information in them.
Highlight of my debugging so far is that the codec pin "0x1a" has an
incorrect VREF assigned to it (HIZ). Found this by accident when using
hda-analyzer. Changing it to VREF 50, 80 or 100 fixes the headphones. Have
no idea how to persist it using init_verbs (don't know how to package the
new value 0x05), so wrote a systemd file to hack it using hda-verb utility
at startup. It stopped working eventually or sometimes had to stop/restart
the service to reissue the change. I read somewhere that the incorrect VREF
is a sign of UEFI/BIOS chip assigning incorrect speaker pins. Although I
could not get the speakers working at all using any utilities mentioned
above.

Thank you for reading,
