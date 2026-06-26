Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDE0C43458
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:55:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 742C360202;
	Tue, 30 Jun 2026 13:55:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 742C360202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782820512;
	bh=y/3aiDG0I2yWv2dHo1vQoTcKiO7WhyoDK9Hsn4/5Mk4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=o8GA5vzKBcttKYZvl+PpxhsPpB5TLlYWS5P3IG5ZLOIBlXkt1bqTDwjK6tpGygcT+
	 KQLfZbG1Ngu4ugiSQecVRW9AEg5gQ+cgMg3pNmF52hWioZ4ALrDY623x5lCZiLaCWK
	 uq27rmArWzCYnvFlDbqtKFPgrzVfSj/j0+oVAueE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 82DD8F805EF; Tue, 30 Jun 2026 13:54:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AECFBF805BE;
	Tue, 30 Jun 2026 13:54:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 849ECF80527; Fri, 26 Jun 2026 15:48:03 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782481682;
	b=eplmIbTBb+Jp8jiGWIOiZaWO2SeKS1/8sT6eu6Xs08unMSQtXAZtIcHrppyvKV60t+xL
	 F+/Of8M0pKikFoePI24IuljArlkE35osjzlU5zmTZvxuyb5Mvdyu0fglN4ZwfcvahDC28
	 03E8MOng3Ng7zCixIebt9XAnIUSHPLqV9iatYIOUMtq6AHnHBvcomoZxgPK18Wr4ZoBoH
	 KfIni9gXpBs00XdmpryR+homcILwVGsMK6gqzPXIQiH6z0EgyrDILgWHIlGeOj8SFk8xD
	 1qIYKf40r+qLW3BN0NuCzVhnVowY2EzApwJr/tSilV9gpfci2BMgIEDMrJOE0HW59qQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782481682;
	h=DKIM-Signature:From:To:Subject:Date:Message-Id:MIME-Version;
	bh=y/3aiDG0I2yWv2dHo1vQoTcKiO7WhyoDK9Hsn4/5Mk4=;
	b=rqgQDx3KJFj9+J3mQqQawlLdnj8dHbczJKKA687OFTGGk3TLppgMU3iO5RYjeE8KGSot
	 UsAY0/4QR6gizzn1MgNu8oluMGuCjm9aPiyDPmEJ0mt7LqrJRzgRNl6BflLgUNozHtE1Z
	 sWCieG4PWlsOidswKHGNidP0fQn5u3xSxRgBsj+y3dT8GPDvNW9gYq0gLi5FU5LfQL4eh
	 UvzzoxbKUreMeugvk8ia7qTJDd0z/oM6GRQjZEzjxZvUu9nRhJkkvh1XT/ec+WDzqYaiJ
	 xIocjgJ8ngeKnL27rd6nGzuUBsWdq4VzNa6HZ5LLGVpltn56XV/vulTubk8xKSKFRFA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SzMUESms;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E1C5EF8025A
	for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2026 15:48:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1C5EF8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SzMUESms
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-463f1165e16so981299f8f.0
        for <alsa-devel@alsa-project.org>;
 Fri, 26 Jun 2026 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481680; x=1783086480;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VN8ldnrGTGRk9CKEssTXW/x67yzARtvbN51eu/71mMc=;
        b=SzMUESms91k0zddWdMFTD62KJ2E/lK1huA/IX23KOJPByHhaD8mJqc+EOufT6LARIj
         +g95nskW/IK2+6Ikia1fpIn71wTQx9jetdGiZHpvmg327D4zi6oxx/L0wH3bvbMFtj00
         ZLLpFtNICoq+fzdcmk3jO6F4lOEY8cQh2S5dQ8AYPx5rGKLJBBjxRJmNztiVSRmm8LEs
         CtzxJv9/7NceVmdZl+sLC9SDNYPh6ZfUaDoTp66CHzhqdQBE/uuqgYfM7svPdORa72sm
         TvOT+hrbsLzoE5mlNCPew3fPqX12X2Nih0ZAWTSBz42xLateSNEd/jZmzehPVJiQbbTu
         Oteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481680; x=1783086480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VN8ldnrGTGRk9CKEssTXW/x67yzARtvbN51eu/71mMc=;
        b=qP7LvCVYSD8gmsNCE/unGbW+ilRWbhoVOFn2iNPm41ak6G6cZr5EeW+NrpUC0j4wfZ
         6028Dtwx/WkRmT22rmdt8kg3pSOvMmr9V1cDqKn0NQ1oJ+ekYMUFWtSCjNiUDNDzWag7
         E5z4EzeyI04MkPu2i12vTgd5WEo2IwFxv0Rz9KW80zV5wFvHxPwI7fqEqtACaDGmMIzy
         fJIH0ObK2dzvx75P7j4rdfN0KhhQeNwGojuxuAjiwF73Ad/WSI9PQ85nf6P6nAURw2wQ
         Bw9PqTidLi6WT/Jn+i1uIo63Ywd/sSMCDZ53YC1a1fMbMVESau6S0w/eEkMjSHRLTZ5t
         Bpfg==
X-Gm-Message-State: AOJu0YwOQbGnEZUQiH4QHCVm9spIX7KeVydPZ9uq2SEQ5YKVcPk/kLDK
	WmkAQg4DAAxEZOkrXNH3X851hDiN70wgJMfeAKhv6UIcBbMdaLcX2Y5W
X-Gm-Gg: AfdE7cnM4pZbgpPCSCoWk7qYffIBGusIlPZ19uje2JcQRoCjNJRYlWsL308atLWtNWH
	nxgej1Vm+Kdh2Il54jQ7+0vEz1H5lgd0GU9xi3xz/KZwV6ViVgpay1Ye77Q8kQVWZyDW5HBVgZr
	0MG00NClZSJaq3JZXBvhyqMeOJcWXrRbFmv1i94m9Bbz1aSxzv0QJO9lVQpLc6g+Op/ByBNMVQJ
	ZrjjVs8gtcHgAbhkNORyX6RENjwGCQSPY6idVo4wWN8t4UTitMoQ4k7uq+EU16mqX0ofP06eXBY
	1a2FsIvXxw3Dw8tYHRNbBHxJZorMZLJIX2/Wu7PdU0OF9wt2rhL+4jhrLLZz3xcE/S8zlMcKt8/
	z4VAnMIGID+SEEMu8C0sxCdaCxDCCpA7Bgtkl/TU3/3uEj+xd7ium4CZ7ZanyDX98qKefWbvn84
	AAGAOhFH68Oq7mT8YvX/3KrnoGFK3O7JZ7FVhrJLKlCDoSRXRZO88Toe7nhThX6jRa
X-Received: by 2002:a05:600c:b96:b0:492:6447:7a7f with SMTP id
 5b1f17b1804b1-4926686b3f3mr101143375e9.6.1782481679497;
        Fri, 26 Jun 2026 06:47:59 -0700 (PDT)
Received: from localhost.localdomain (IGLD-80-230-60-93.inter.net.il.
 [80.230.60.93])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm7987878f8f.14.2026.06.26.06.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:47:58 -0700 (PDT)
From: Omer Cohen <nevergfx1@gmail.com>
To: tiwai@suse.de,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	security@kernel.org,
	Omer Cohen <nevergfx1@gmail.com>
Subject: [PATCH 0/6] ALSA: sound/core: fix multiple data races and bugs
Date: Fri, 26 Jun 2026 16:47:03 +0300
Message-Id: <20260626134709.27883-1-nevergfx1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: nevergfx1@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: ZVCVDZYFBMVWNHUY34XUKBY6PFCI2AJ2
X-Message-ID-Hash: ZVCVDZYFBMVWNHUY34XUKBY6PFCI2AJ2
X-Mailman-Approved-At: Tue, 30 Jun 2026 11:54:02 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZVCVDZYFBMVWNHUY34XUKBY6PFCI2AJ2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Cc: security@kernel.org

Hi Takashi, Mark,

This is my first patch series to the Linux kernel.  I am CCing the
security team as recommended by the docs for initial reports.

This series fixes 6 bugs found via code review and KCSAN dynamic
analysis in the ALSA sound/core subsystem.  All patches are against
current HEAD (4edcdefd4083).

Patch 1 is confirmed with KCSAN.  The remaining patches address bugs
found during analysis of the same code paths.

This work was AI-assisted.  Per the kernel documentation on reporting
security bugs, it is sent to the public mailing list.  All
reproducers have been tested on arm64 QEMU.

Summary:

  [1/6] ALSA: compress: remove illegal state mutation in poll()
    snd_compr_poll() writes runtime->state = SETUP when it sees
    DRAINING.  This races with snd_compress_wait_for_drain() which
    reads runtime->state concurrently.  KCSAN confirms:

      BUG: KCSAN: data-race in snd_compr_poll / snd_compress_wait_for_drain

      write to 0xffff0000c75c8200 of 4 bytes by task 282 on cpu 3:
       snd_compr_poll+0x29c/0x2c8
       do_sys_poll+0x2b0/0x628

      read to 0xffff0000c75c8200 of 4 bytes by task 279 on cpu 1:
       snd_compress_wait_for_drain+0xa4/0x270
       snd_compr_ioctl+0x1ba0/0x1bc8

      value changed: 0x00000005 -> 0x00000001

    poll() is a query operation and must not mutate state.  The
    DRAINING->SETUP transition is already handled by drivers via
    snd_compr_drain_notify().

  [2/6] ALSA: compress: fix buffer leak on set_params driver failure
    If ops->set_params() fails after buffer allocation, the buffer
    leaks on retry because runtime->buffer was already overwritten.

  [3/6] ALSA: timer: fix lockless tu->tread read in read()
    snd_timer_user_read() reads tu->tread without ioctl_lock to
    determine entry size, then re-reads it under lock for the copy
    format.  A concurrent TREAD ioctl can change the format between
    reads, causing a size/format mismatch.

  [4/6] ALSA: timer: copy queue entries under lock before copy_to_user
    After dequeuing under qlock, read() drops the lock and calls
    copy_to_user() directly from the queue slot.  Timer callbacks
    can overwrite that slot via queue wraparound during the copy.
    Same bug class as CVE-2017-1000380.

  [5/6] ALSA: pcm: use locked state read in snd_pcm_drop()
    snd_pcm_drop() reads runtime->state without the stream lock.
    Commit 7bc02ab446d3 fixed this pattern in read/write paths
    but missed drop().

  [6/6] ALSA: rawmidi: propagate resize_runtime_buffer() error
    snd_rawmidi_input_params() ignores the return value from
    resize_runtime_buffer() and unconditionally returns 0.

KCSAN reproducer for patch 1:

  The race is triggered by concurrent poll() and DRAIN ioctl on a
  compress offload stream.  A minimal reproducer uses four threads:

    Thread 1: DRAIN ioctl loop
    Thread 2: PARTIAL_DRAIN ioctl loop
    Thread 3: STOP ioctl loop (random delay)
    Thread 4: poll() loop

  The main thread repeatedly sets up and starts the stream.  With
  CONFIG_KCSAN=y and CONFIG_KCSAN_STRICT=y, the race is flagged
  within ~2000 iterations.

  Any compress offload driver (hardware or virtual) exposes the
  race since the bug is in the framework, not driver code.

  Tested on arm64 QEMU, kernel 7.1.0-rc7+ (4edcdefd4083).

Thanks,
Omer
