Return-Path: <SRS0=Xern=5A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE78C10DCE
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Mar 2020 08:36:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57EF920737
	for <alsa-devel@archiver.kernel.org>; Sun, 15 Mar 2020 08:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="nIHlE2SV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBcHKtXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EF920737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B3A851869;
	Sun, 15 Mar 2020 09:35:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B3A851869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584261387;
	bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nIHlE2SVStv+5mwQeSEaB9c6P7I5aCpXz2hJqk06bHjpn7piu7PYxTzbkAVMmlyOn
	 oO4ieYIgCXQL7+WqsHk3eTv+CXV7CIMRSGJZOzUL32mvhD/J2VmWe7+OA8hnvDHmyX
	 7ZtjXMgWHU+YnZ+odjMHyP5a4w9P1oao4J/AUauI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB01FF80292;
	Sun, 15 Mar 2020 09:33:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 65ED3F801D9; Sat, 14 Mar 2020 13:27:24 +0100 (CET)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF013F8013C
 for <alsa-devel@alsa-project.org>; Sat, 14 Mar 2020 13:27:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF013F8013C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="hBcHKtXE"
Received: by mail-lj1-x241.google.com with SMTP id o10so13509402ljc.8
 for <alsa-devel@alsa-project.org>; Sat, 14 Mar 2020 05:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=aD4cpDKpd4yHjF7FyPfDtJiJuoOQywL6BBbaB8QBvho=;
 b=hBcHKtXEYTWAHKK0Fi0YNfW+T6SpImTYM/XKKOcB4gBeW8o3Nl9uVs/z+taKpCYAo6
 RsLN1neZA2GJnBH7+hOiJHe/oJkWY+m/5rIKwDSDMIv3ghG4vePZv8SBZ9YsTq+lhAYb
 dLFpKyOy0UaBsCg/Ik3peHGYbAM+bPWDdh1E5PV2mPyOFuxe+9AxRw01nYFkrm6NaWZB
 7jwcAdQqKU8z47xjg9QiER4lJFn82oo1I5YNGuX7KsHDWK+2YRGg/HLTS1hDd76C1wSb
 +ZCGM83CxQDwptmL6MuV/+xER0xS/Ibbq+KkSUsxnIJp9nOaVnEGKCmdJmYFRHsVpnMT
 3emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=aD4cpDKpd4yHjF7FyPfDtJiJuoOQywL6BBbaB8QBvho=;
 b=VeuNjCK559vpbFT4YP562ZRnqLSSBJmyDxuR0AlHDkrG2PQQAB8kViBYEWgcjKH8Ih
 FM/0X9RhdzsT6yUVZ6Xna312wpgF9prHpEJq2aa9mFN6Jx4QXBpnfA4srbcba3CoSbr/
 BSUYcSnkvlmizoWtukN7G908ligrW2a0/M46WODyibcPgCSj0gOFq8Sc4TfUhNe/8Ro/
 Q9bNQa0i04P3pTLhLMDohbYXRuyRs3VApxPegWpW+4PEEpjEVtmnZO4iKnEbJ+e17DZe
 I9zNQyc2iG+4HpzHb+o5zQMNTflvBt/fr5UjJ5yLQgaQIJw1QQGe/zjIIaZb2e0B+Q0b
 v3fw==
X-Gm-Message-State: ANhLgQ3DS0I98gnEilN7nBxErfw5FdaLZXD5W5dUbqOtK2UAXS4sRQbV
 VC1s0t7OfMDBXxEPlUrq0XC+FmS8Z+aZ35RUqGZeZHk=
X-Google-Smtp-Source: ADFU+vtAfKJ7D4+HxSawNtWzFXYaY81iLOhi/xVmWUqY15Xipx45j4FnyXmyx3ao38HrjWgkpw/aY6azvU5SFBTShVM=
X-Received: by 2002:a2e:8991:: with SMTP id c17mr9939903lji.278.1584188840063; 
 Sat, 14 Mar 2020 05:27:20 -0700 (PDT)
MIME-Version: 1.0
From: sandra luna <sandraluna1945@gmail.com>
Date: Sat, 14 Mar 2020 07:27:09 -0500
Message-ID: <CAKnm+F-tzQ1PM5ZZJNyCBrTcZcKoQ8BcTMt829CF9NPtzpX77g@mail.gmail.com>
Subject: Re: Re: [alsa-devel] [PATCH 4/7] ALSA: intel8x0: constify snd_pcm_ops
 structures
To: alsa-devel@alsa-project.org
X-Mailman-Approved-At: Sun, 15 Mar 2020 09:32:59 +0100
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


