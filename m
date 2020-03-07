Return-Path: <SRS0=bYd2=4Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97F0C10F00
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Mar 2020 04:26:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3348A206D7
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Mar 2020 04:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="m3uOWMDf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XN9TzsKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3348A206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 602D483E;
	Sat,  7 Mar 2020 05:25:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 602D483E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583555161;
	bh=A+EdBak+uiCMTKs8DPDV5J9DaAG6NP52fOVNHw76750=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m3uOWMDfB1K0w0Q/VlE0icOqitFrg/NkgCno+B+3xs49vqHw2sWEjhnh5b3w6RPzq
	 loFyObKdC6qmE+dAJOfFjRE1y/0D/TfjxUqy1UDo9XCEfH5/mQOSBiTOwXtmEij2S+
	 NwL3+WqnbP2M2JzYyxFqCpYGj1Fw4H3hL4nNsAT4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9AB24F80245;
	Sat,  7 Mar 2020 05:25:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9C54F8025F; Sat,  7 Mar 2020 05:25:08 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 33EF7F80130
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2020 05:25:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 33EF7F80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="XN9TzsKj"
Received: by mail-il1-x12d.google.com with SMTP id t4so423920ilo.8
 for <alsa-devel@alsa-project.org>; Fri, 06 Mar 2020 20:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/B90CqercAEcYrvvEoOddntUvXrGF8qFwsFSiNeCla0=;
 b=XN9TzsKjE7h7rCmPCGwadZJoBlTdBUPDvNu2xgxTQPaZ8XZtaXmLVjJ5IT9XmY9lqw
 WvdLwrERvtEm8rDO88/dxD7fKe9bvabaeWlFpI+1Ec9yzuSLyE3Zh4Uh1vGDuKcP8VBQ
 I3CZNcbuZPh2CUaOghOHlvzydTaBbxwTsMma5oYtz/shwCFShbXaHz/t9n8Q5uMbodhu
 UtozmCbiX9/M88oecpZQ842Kf1i7ghRCfmGOYNhTtHcSHzNITP+6tyFEx9ghvPmDiYjO
 lpdMzc52KEubcB++sIYLR6vqIo8sa+CcT/Funb4q3ssPcozgcT1h2VNBphv+a44pRJw4
 rwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/B90CqercAEcYrvvEoOddntUvXrGF8qFwsFSiNeCla0=;
 b=VPQcrYf4gDA6Y+2HSco5S48jrsEi581vYFo9GXrOKwwGTf7mjvbn9LPLkG0fZ5phCH
 fQl/nA0xkalZvvT/+ns7iC2qf92Cr/FU65pezMh1Y9eDrLWOlBCp4dgFvoLP9RZ041qr
 L+MkEtXZQJVTmvf9PSnbFbQiJRTvcE8A1d/m8Sk1v75jBMpUO4pBj4qBbNmiogIML+1J
 6ZUHKHsGk+6tfBfjbZ++BRusxjPsB+xmZSoHYPsgyU4a7QX0kE2RS3FiOjbI11IzIsjR
 1SNmChxYTtzQKMxb9AXkdCA+/Pi9tYkpcKpdiFN760+yB70VkA6dd6mLjKMuxA+p9MFQ
 d24A==
X-Gm-Message-State: ANhLgQ3WK4FSS8sS7vU71/jn+WT06PjbkACXNgDAU2kbxw3KCypyR2rS
 60v0JBSF67Ar51MlWWHuV8hmBcW7Pr9x8/Mg1Zc=
X-Google-Smtp-Source: ADFU+vvuhS7Tlz8mN3ypyJjbXL7HzD1K5WwoKyHvozZ4mbHYnbJ9NzLuNomM/rmvdn6BDK1MubaFMo6ftIPFXQqT2ZY=
X-Received: by 2002:a92:860a:: with SMTP id g10mr6119229ild.280.1583555102844; 
 Fri, 06 Mar 2020 20:25:02 -0800 (PST)
MIME-Version: 1.0
References: <20200106131159.476744-1-hdegoede@redhat.com>
 <9f6ffcbe-10fe-91fa-3998-029c2837a39d@perex.cz>
In-Reply-To: <9f6ffcbe-10fe-91fa-3998-029c2837a39d@perex.cz>
From: youling 257 <youling257@gmail.com>
Date: Sat, 7 Mar 2020 12:25:06 +0800
Message-ID: <CAOzgRdZZQLKYOQDxvySaum5CTD8Se=UVac=ha9R=+vF_md+4Xg@mail.gmail.com>
Subject: sudo alsaucm -c bytcht-cx2072x set _enadev Speaker
To: Jaroslav Kysela <perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

sudo alsaucm -c bytcht-cx2072x set _enadev Speaker

       alsaucm: error failed to set _enadev=Speaker: No such file or
directory
