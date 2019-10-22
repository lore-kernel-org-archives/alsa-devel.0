Return-Path: <SRS0=bexm=YQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D58CA9EAE
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 04:49:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4240B2173B
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Oct 2019 04:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="af0SAsoL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWp4l8I3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4240B2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20A0E84C;
	Wed, 23 Oct 2019 06:48:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20A0E84C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571806142;
	bh=4FNHcR58AKj37KvfAfkQEYcStR0RrQipr7EiAx9xZT4=;
	h=From:Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=af0SAsoLwNTl+V04C3MKjZuqgR/htiy6B+RuKDj+qub+LLr2MX2qTyc8/Sl5IJoRe
	 LbZSlMfN12v4pgLMQNW7sEEoI2+5uF9u3FcbFIeQ3QToiQu2drKgA+ShsG3KWOKWBi
	 YZ2m2Y93KUVoBXXhbIKseTgF5WloTKYVsd6gm+kQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B08E2F80112;
	Wed, 23 Oct 2019 06:48:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A5DA7F8031A; Tue, 22 Oct 2019 18:26:33 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C8E1F800C0
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 18:26:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C8E1F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ZWp4l8I3"
Received: by mail-qt1-x832.google.com with SMTP id u22so27592712qtq.13
 for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2019 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=DvCXbKzRBhSsnBGFTwmCqZeUJeDxBT7HhLlxK3cxMn0=;
 b=ZWp4l8I3mzY4qTV2NisZC5+d9dMoFVnv4EBRHJw308lAZFxUjnFBz2J7YsSO72RlXS
 RMEE+h26ljdrRnnKyhAGvigGD/g8uFeakU6MTyONdDZ1uvH20qeUN0DPrr7zJBaufWpC
 GHwMTv5n/9R103sZCK+j7UcSw3Dg0keVfEKWHSOse/mw3XzXXNyEvJwQbBJVHvShBkNu
 YQGNP+hfWOVmcvp+Qfk5dTt2QMdzxsNf/CcHwfruE+jPJ5sm0TIWiUdOLoViHU4eNHwD
 kSlSBp2cIRgj/A+LBsE5Cpv+eZhGDbf7ZQk0eDjoLzTOEu38L5CEv812tJEpqqilmzle
 YGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=DvCXbKzRBhSsnBGFTwmCqZeUJeDxBT7HhLlxK3cxMn0=;
 b=ej5llk0L+pkLA/IKxg7gopNCtiYubK1Yf9Uezmp0fwpGFq0Dp+EFybcgVebXmtaD3H
 3+Ldmzrg13BOQyD906jXbXgjyv/VN62WlMpcgTl8X5vyE+9za3gIUTExTEhezbpFkMbO
 XLnidPdeCl7L2lX5Rn/oDpVHbkiZvSIVh63evGKVXz/vqV6rdbLZpg7xVzIHtTPfGSd8
 MnvUveeaLXTANwKdET29D52gyVVqCjIJtSS9o5NCN1xIGTEhcdBFWTzl36BYhhQHP6VH
 dW7aVcGEZWJrKIGQfhqbRn6sb5h3Ho+ioJ+oi44J6w0n741590vcnk7IQsqEUuu28xD3
 gFyA==
X-Gm-Message-State: APjAAAXc5RPlIQVwUz/8fmk2WpvwLQzSCRVh4LfHR/zbpWP1YQkTAUdT
 H9ro27BVYLTfOfKV97JmIYDKi7fAmgda3LTrnuL96cgP
X-Google-Smtp-Source: APXvYqwntMkG/5AW96k1xBVJnUT/cDz9cLtBz233N5sSnrOmJVNGiZ+9mQ6GBAtd2QfFoSKf/k4Q5oUGCBwPGNGXT3Y=
X-Received: by 2002:a0c:814d:: with SMTP id 71mr3983222qvc.226.1571761588159; 
 Tue, 22 Oct 2019 09:26:28 -0700 (PDT)
MIME-Version: 1.0
From: Matej Kupljen <matej.kupljen@gmail.com>
Date: Tue, 22 Oct 2019 18:26:17 +0200
Message-ID: <CAHMF36E6mrRzj1sabS9n89yvY1GqrThbYf2-VjdLSHN-1ApPPw@mail.gmail.com>
To: alsa-devel@alsa-project.org
X-Mailman-Approved-At: Wed, 23 Oct 2019 06:48:10 +0200
Subject: [alsa-devel] Recording on WM9712
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi all,

I have an iMX6q board with external AC97 WM9712 codec connected to SSI on iMX6.

The card is detected correctly and it is using generic AC97 codec
driver, not the specific one for WM9712. I was able to hard code the
values into fsl-asoc-card.c and fsl_ssi.c files, but my problem still
remains.

I can playback WAV file normally, also speaker-test works as expected.
The problem is when I try to record something from Line In.
It does record the file, but when I playback it, it is "too slow". I
tried different sample rates, but the problem is only worse (strange
beeping in the recording).

The command for recording is:
# arecord  -f dat -vv /tmp/record.wav

(I tired also with -M option, but there is no difference).

If I copy the recorded file to PC and use audacity to play it back
using 1.5x speed, the recording seems O.K.

Checking codec register values trough
/proc/asound/ac97audio/codec97#0/ac97#0-0+regs it seems that the
sample rates are set O.K. to 48kHz.

Any idea what might be wrong?
Is there anything else I can check?

Thanks and BR,
Matej
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
