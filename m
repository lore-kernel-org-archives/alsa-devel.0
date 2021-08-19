Return-Path: <SRS0=W9hU=NK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788ABC4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 18:05:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81D2610A0
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Aug 2021 18:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D81D2610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79628167C;
	Thu, 19 Aug 2021 20:04:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79628167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629396325;
	bh=6IS2xSlIFJuzjsHqgXzTbagwQV4EfbdfEDtZ8/Od+vM=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Zf6N8xxGwK+HQtio/x5DCPkNWU6aJvzNh9MWSrqbxIYbIABIr1sD33ZewcuyPqKfQ
	 Pzsb3oXKRyMgeuReN3NPzARA5gi6Khi2Zc1fSbaOVu0T5jCcLmWAFxa5MKiUzhIoF0
	 48txz36x6ZJjSh+2ITI+DmDu+CALReDfC0icxdhk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 11F34F800EC;
	Thu, 19 Aug 2021 20:04:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0FE2EF8026D; Thu, 19 Aug 2021 20:04:34 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DF69F800EC
 for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2021 20:04:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DF69F800EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="n3o+FtRk"
Received: by mail-lf1-x12e.google.com with SMTP id x27so14756218lfu.5
 for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2021 11:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=kxRLPRc2S+FZKMnA8l0MNExE3ds4OVfqQsFu+JUWEkY=;
 b=n3o+FtRkKH7hLDjlf2bGorUq5nSuwjQmZ4vsVlLEtcrrTvNdAqgCWlhwbM6m1zyGTF
 wcB09ME+z6WgpTElL0uh3ZR5ADundS0TmUoa6IrlPK45xvl6WbeizEOovTeUGJTUsBtk
 SEiq/R+pu4EYWgfONULQskPGdxddV+PuW1e5uE6P8Y07xICbh0D0SV7/3PDrYyQyL6Ax
 uK+RI/ee6QTXrG+PG7LIt9Ww3/2xs2qUpNwlNd2kLsL0eLynitwz+K6T9mWkHEfoH2yO
 3lJfKbZn8v4/6b1qb4PvemCmYF/RC4kgUHkXvweosrSQ3ZRfMt3PQyhJcer4VUvJf5CF
 bgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=kxRLPRc2S+FZKMnA8l0MNExE3ds4OVfqQsFu+JUWEkY=;
 b=eIASgfENxlgUZwOLQhke89TZixsOXFeRu2PfXBcq3JAd1WZbRckJg+XE13MK0dQ7Kv
 F6ZAAC/2l8c0XSaE5/oxYGLaOVFLd4ld30klnJ+mJn+ULzBqro299FgJfwMsCvY9quZd
 SRrnctJKNMHxKP5MeGEh2O8GiFqbW1iJ53Mr/X03nYpftdlfIQiZng4QPI8Xga3/dt9z
 Xd0gJIxa5BS60qL9aveTEFlIVpq3E1PHxft7Tki4O1a8G2LsVX7UMbFy4X2uz4GTpc+Q
 kT3WhKfLrQbnKxZblqldvjKAycw2Cuq/CPhMAjiLywXngJ4rU0kqDZjXMhKLGfIfMySW
 o69g==
X-Gm-Message-State: AOAM532aL473Cm8c4km5SK74+Y+kJgVVpd6UHw/w2PAkDgd2q/caXoB9
 kKsjShyClNdAO/yCCtmsJ20bU75d/JgEA/BNn09eVrfjmpc=
X-Google-Smtp-Source: ABdhPJylOZdoEX2+gou4/9bcn4dh1EcU0TtZ3uss4rM2pctRWlVBPYHWoor9loRLWMpu6JtjZO6cOHUTUnXhvwRJ8Rc=
X-Received: by 2002:a19:f20a:: with SMTP id q10mr11393340lfh.513.1629396263499; 
 Thu, 19 Aug 2021 11:04:23 -0700 (PDT)
MIME-Version: 1.0
From: sujith kumar reddy <sujithreddy6192@gmail.com>
Date: Thu, 19 Aug 2021 23:34:11 +0530
Message-ID: <CAAd2w=btf3DZLbPuovAC9xo3rizmFeT4iAxJs6zNZwKxOnKT6A@mail.gmail.com>
Subject: arecord is failing with -V stereo
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

Hi All,

arecord is  failing vumeter option -V stereo only.

localhost ~ # arecord -Dhw:1,2 -r48000 -c2 -fS32_LE /tmp/test_record.wav -M
-d 1 -V stereo
Recording WAVE '/tmp/test_record.wav' : Signed 32 bit Little Endian, Rate
48000 Hz, Stereo
*** buffer overflow detected ***: terminated
Aborted by signal Aborted...

Please provide pointers to debug this option.

Thanks
Sujith
