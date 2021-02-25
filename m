Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA30FC433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 13:45:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4272364D9F
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 13:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4272364D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7895B167C;
	Mon,  1 Mar 2021 14:44:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7895B167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614606332;
	bh=Gob0C6PTjv1UhxE44gaMBrOGwljKgBub+P/jV+zgwZE=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=m95gEr/R5L9q+f1I6SmAg6EuAbDBiaWnqlV/5U9ryqIGbWmrJXDZAnCqogbAhcZU7
	 u9vSPdLETnmBvPHDhdLj5ncosJ2ve8/pHeESTv6q2zeLEAG2+hTVqrVaVuHCurC9ct
	 cD+8wXlaM4L/6xW7Ox6DYcPaWCJzeTmE7zrJs12g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A719F8049C;
	Mon,  1 Mar 2021 14:43:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28EEDF8016A; Thu, 25 Feb 2021 21:17:33 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4DABFF800E4
 for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2021 21:17:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4DABFF800E4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="kACaN+Zc"
Received: by mail-ed1-x52d.google.com with SMTP id c23so2029519edr.13
 for <alsa-devel@alsa-project.org>; Thu, 25 Feb 2021 12:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=Gob0C6PTjv1UhxE44gaMBrOGwljKgBub+P/jV+zgwZE=;
 b=kACaN+ZcnZPBj5TGHirGsgR/kjALk2CA+U6QgoqGzQ1n0BKgXG6pMBWa+ml/1mi5pd
 52XUeCIRY47L/LGebznYSopf9dTReDio3bSHuo824KyRBs5u8s95pIt68u/tj/NPIo22
 5yCB7UArPHciKh1zNfAkUjyySsDL3RlT4up732C5do0m0iFdwWZYaeKNeJPuSjtB7YbV
 Jd01tD/j2iYemiHTSvZZAwWOrLr28cdev0OqKgopDsx791XLRunZAcXkmIDvBThbWVnz
 ZjJF+bvD5LX/81VZBc4iR9Noa3KCd7fAIx2Auix24jSg/CRY9hHPJITqtfOV+nRX/z+s
 gDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Gob0C6PTjv1UhxE44gaMBrOGwljKgBub+P/jV+zgwZE=;
 b=qTIXkAF0J7e4zYCMGfCZnP72jTse5R7kLgUajSvM+FDhUH7/OEPRrXMJB1/17BqRm0
 ujBDuVEf0ELWFA5J9K6E+8Ca2GTl1lzePvkt13qMe/97Ob0DJBzzToWGw5hc/idPMLC/
 qFOvZjtxdaU+q7vvG+wkfqMoMDWi2PMO3UCpm/HPg6u2j65Hrvn7QhdtgUko5m70S0Ax
 duBTFHqTZZSKj6llX0UdhYWlwlBf8rH5AK4d8PIPOIIrYSy2do8Pe61fR+C2bxjqk8sW
 X2kZNQDA9AtpdjlFbYnJvy75s77QQO5gv+gkmJn9fOA7+Ks5CGBP5hqfcnXd5MVJfuVY
 WtOg==
X-Gm-Message-State: AOAM5315K3t011Uh/ek7xy5eE7TQL/x66l1DEj7u0AqPePEWG9zeM4wx
 1K7OuzSg11mFWExSR1GCnQnZLFavbMDaU7rYwV8pPf7xKtXZDA==
X-Google-Smtp-Source: ABdhPJwSwUSNeogiXJ0+uCfEBzNMFTCdZTN/05Enj3O8EDUvcy1LWdmZ305TdP9tniTEwi7fcKpHv0f3QEa4lYT2oPQ=
X-Received: by 2002:aa7:c9cf:: with SMTP id i15mr4864770edt.296.1614284246462; 
 Thu, 25 Feb 2021 12:17:26 -0800 (PST)
MIME-Version: 1.0
From: Steven Skeard <stevenskeard@gmail.com>
Date: Thu, 25 Feb 2021 15:16:50 -0500
Message-ID: <CAHVejFyWtqdF-6XC0+Jk4vdZGJcTQNSfm9pMpqa4mT6o57Eedg@mail.gmail.com>
Subject: Possible alsa bug around USB drivers
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 01 Mar 2021 14:43:21 +0100
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

Hey all,

The last few weeks I've been plagued by inconsistent audio on my PopOS
20.10 desktop. Sometimes on boot everything would be fine, but other
times I would have no working audio and only dummy devices in the
audio menus. I eventually found that if I specify the modprobe order
so that the USB driver (eg. for my webcam) loads after the onboard
motherboard driver, that audio will work consistently.

Here are the related links:
- Reddit thread where I posted the original problem and the solution:
https://www.reddit.com/r/pop_os/comments/lmvbj3/audio_not_working_after_upgrading_computer/
- A related thread where it sounds like an arch user has the same
problem: https://bbs.archlinux.org/viewtopic.php?id=260373
- The alsa info I uploaded while under the effects of the problem:
http://alsa-project.org/db/?f=a23ccbb818fec6eaf08b032504eac5d5d8a30589

I'm not really sure where this problem originated but I figured you
guys might be able to point me in the right direction if it is not an
alsa problem.

I don't think I messed with the original alsa-base.conf but I suppose
my memory could be failing me here. I'm not sure where this file comes
from but I'm guessing it could be either a pop os, ubuntu, or alsa
default configuration?

Thanks,
Steven Skeard
