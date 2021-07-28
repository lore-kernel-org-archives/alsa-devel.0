Return-Path: <SRS0=/xSo=MU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC37C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 15:20:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA96C60FED
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 15:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BA96C60FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 666481FD2;
	Wed, 28 Jul 2021 17:19:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 666481FD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627485649;
	bh=jnRyJ9VVV8zW8ivzWYwmpPGuITEqvuAd30I2S1vB1wQ=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FbK5/F6RydBA0FsSowbUHG6mVf6gs6UB6TDA8Gr3a+tgsezwsH3eoyuNQK0P+rnuz
	 /1PFOKT/BwkuRH2xDBxJfZPxjTAWnALxVdDOr0vn/F1PsL96bhtter/UHrBIxUBCwS
	 E/aGz+CrUqfeuoUCyyFR1hRyeGucTJSwYvwb00FU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F0A1FF80253;
	Wed, 28 Jul 2021 17:19:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E443F8025A; Wed, 28 Jul 2021 17:19:58 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC465F8020D
 for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2021 17:19:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC465F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="OflOGbhp"
Received: by mail-lf1-x12d.google.com with SMTP id m13so4601504lfg.13
 for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2021 08:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=67TFO83mj06tzb4Glva8rqA1nXw+TKoHT4mJVyltUtA=;
 b=OflOGbhp7Tqbq6eY0BqWa2EgxyKm3IQstZhFO5m67PYBoNfeIgqyxt3Bc5hTew9Pju
 I74o07gt1y3alDqOw/M7ZQGv5rNGJb/SPMrYaJtQooat/TQkB1DktmEEu/CmM83ACN6p
 7fuClqvRhAxkWTZwh5JkZDifNK2Y3xKzB2MCDnh8LncayjqZH7hUXLuNDIqLzcb/ojc5
 GwfRfnFE6Kx1aKby1iwyKRnLhQPEzdoLwEZgo9ddGM671YlKIwnOPr9/oOLoGZOGVj0f
 Yw/ti1Incur+zQwjQO1JjHOSExDFem0XlZO/QGvX2uextjNxqp6S1YLPD8ghB65+aTi1
 PHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=67TFO83mj06tzb4Glva8rqA1nXw+TKoHT4mJVyltUtA=;
 b=FA/ZYM+bT+RKerIuUoEZvWNtVBWM4Y0NHMEiWnsR5qmLxVk9PkznbmQ88oeTo4oYw7
 L3KgZ61d0NhOlzQ3gkaXwyvwFLhRiy4fSIRlG8dIYnjqxWL81tDSeea/dMacLmtK90n2
 7210A+XbqPlquKxz2TxbvH3HK0/cNtmVBF3nYGEllM0i5Ene3e6dzN6rloXf0NXd3P1z
 6TN9DnaxUFDqbFyfs/WIufW6TyLnoRFp1XAZCnQgQw4+eXNOpHqgs4778+rNI+Wi6U3D
 kX+5AfNWJwCJ73D81OhZinf20jzP9Kh1HFTER0+0K89raRbC0B7EBxsiWr20q+RyowWu
 Jq5w==
X-Gm-Message-State: AOAM530a6PjPiTtf5uhYP368d3ZMu6I8oTx44BrnhHoadax6RfZz2MNR
 fXY5aGoGznVG+3Hkn49yfXw+OQU5CbNQ9FY8ZR4=
X-Google-Smtp-Source: ABdhPJz0fB31YKBWeYvTbhpxBB/7C9u9RCDLIxDTpHP2vZiy2/5/sSNw8uACwiOBOtuWlUJWzk3/ddsxLlqibpaJ0uM=
X-Received: by 2002:a19:770a:: with SMTP id s10mr99354lfc.652.1627485591847;
 Wed, 28 Jul 2021 08:19:51 -0700 (PDT)
MIME-Version: 1.0
From: Muni Sekhar <munisekharrms@gmail.com>
Date: Wed, 28 Jul 2021 20:49:40 +0530
Message-ID: <CAHhAz+hotPKARumDGZex1MByC01KCsUvYPTUwpsHK+ozSnHXpA@mail.gmail.com>
Subject: PCM prepare callback
To: linux-sound@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>, 
 kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi all,

Is there any document which explains the sequence of snd_pcm_ops
callbacks called during playback and capture?

What driver is supposed to return from the PCM prepare callback if the
sound card is not ready for playback\capture?

-- 
Thanks,
Sekhar
