Return-Path: <SRS0=QEGn=OO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3602C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Sep 2021 16:33:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0581461212
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Sep 2021 16:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0581461212
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F802112;
	Fri, 24 Sep 2021 18:32:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F802112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632501183;
	bh=A6JxwrVzG+M1QZOkYELl9uEcx3yYqKZpPMjPO08o0BU=;
	h=From:To:Subject:In-Reply-To:References:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h2t7U7pojSHcO4EZJGUM8Z6+m1PBRPeyBtpAxoAOJvo3IMvuUjJcXrfMgozNKVm9k
	 G/28IEkRp1nSSc1YSjB6DEImvFRKRHC2bqymToMAhl5b8plvehu1205GswIeJQ9rFq
	 AIHOaJq4vFtC8+SJHYUzcwdLhkWPLMkue4H1HZM4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC340F8013F;
	Fri, 24 Sep 2021 18:32:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CE9AAF802A0; Fri, 24 Sep 2021 18:32:10 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3409DF8013F
 for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2021 18:32:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3409DF8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=vt-edu.20210112.gappssmtp.com
 header.i=@vt-edu.20210112.gappssmtp.com header.b="yWiKV8sx"
Received: by mail-qk1-x731.google.com with SMTP id b65so28288541qkc.13
 for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2021 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vt-edu.20210112.gappssmtp.com; s=20210112;
 h=sender:from:to:cc:subject:in-reply-to:references:mime-version
 :content-transfer-encoding:date:message-id;
 bh=A6JxwrVzG+M1QZOkYELl9uEcx3yYqKZpPMjPO08o0BU=;
 b=yWiKV8sxNRBVIQoj5mjjPaepUvhxaHj5l52/aNg9wma83ZsBRLrYFSLGLmpZ8qa9Um
 e2iO9PCq8KLMonNImPxZU67/TJ0HMRQO+nvgfYPxflxpvamcBIn8ZVfzRqzRINTwcudS
 c0gxc2SPxYdJS/+Jg1YYNz+ugMDt3iaBmXnlwZAncPSJJCnu87sGA56xIdsDq8PP3xhF
 E/SainZOBUyjMMGnF2SUm6VG32hynv9jwNdQloZu0zDiv9wvnCCW36npy72yDpDqgk9p
 Uc+ftrhD6Nj6JbHElwHzwPWQEUTJjWZpVgCi7XpyUjxHo2mtO1/YPweGyzhCDeTUrD5x
 Py5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
 :mime-version:content-transfer-encoding:date:message-id;
 bh=A6JxwrVzG+M1QZOkYELl9uEcx3yYqKZpPMjPO08o0BU=;
 b=MvtENjaRwBUEq1fJeOwFr79XaABs2fdr+jT0aKi1SV75hFwtW0bN2TbZYbRH/MASiI
 aT28+HnZTDvMkDF2CzZR61PPmWU+sb/Y/RYEUbUuNeicSlQ0wP71F9Uy8vGWLBy5Zi7D
 wsENLs65BOjUWoKSY1+UVlbEp9AjbO3WVLa/gZp/AfeIRDNfs/rKWQmG+cymCUdrr8lT
 YR/lDL9/4jA3Gy1eU78vpx4lM3sistgLRpcE7njN/9mGkQhWw96SJsVtLbV2UbKnOV6t
 xsOwTzlcHIxic77N274vmhoJ3za8i351hjprEwO4OBVVS4AvErAN+vwvHwpxCvnzeEHA
 cqng==
X-Gm-Message-State: AOAM5328WoCwMQaK/n151Nf0XAmATf99DaesayV2gIhbc3MdcnK80guK
 agLLwhSuVbgDCTLRT3fDq+zAZg==
X-Google-Smtp-Source: ABdhPJyZkyijez4+UFuIqDpxznqcf112EFu0GEU8zOmAIOdmhessX4OFbJa5ntIqtwewTxyodsmJXA==
X-Received: by 2002:a37:8ce:: with SMTP id 197mr11292808qki.492.1632501122565; 
 Fri, 24 Sep 2021 09:32:02 -0700 (PDT)
Received: from turing-police ([2601:5c0:c380:d61::359])
 by smtp.gmail.com with ESMTPSA id c26sm3968493qka.33.2021.09.24.09.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Sep 2021 09:32:02 -0700 (PDT)
From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks"
 <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.10.0-pre 07/05/2021 with nmh-1.7+dev
To: Muni Sekhar <munisekharrms@gmail.com>
Subject: Re: ALSA kernel projects - for academic purposes
In-Reply-To: <CAHhAz+i=3NDuxK2rZZY6N18=OTbkna3VMVpx4nNgF0vyq3JmQA@mail.gmail.com>
References: <CAHhAz+i=3NDuxK2rZZY6N18=OTbkna3VMVpx4nNgF0vyq3JmQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1632501120_29054P";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 24 Sep 2021 12:32:00 -0400
Message-ID: <324112.1632501120@turing-police>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-sound@vger.kernel.org,
 kernelnewbies <kernelnewbies@kernelnewbies.org>
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

--==_Exmh_1632501120_29054P
Content-Type: text/plain; charset=us-ascii

On Fri, 24 Sep 2021 19:34:59 +0530, Muni Sekhar said:
> What small projects would you suggest to a novice with the ALSA
> kernel. The aim is to develop a familiarity with the ALSA kernel
> source code, and also to submit it for academic purposes.

A good place to start is getting a good handle on what the phrase "the ALSA
kernel" even means.

There's the Linux kernel, a small corner of which is the ALSA subsystem for
sound.


--==_Exmh_1632501120_29054P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQEcBAEBCAAGBQJhTf2AAAoJEI0DS38y7CIc2VQIAI4QqDMZsrbYBybjSLC8m2HQ
F69XRLVtwg2T69DHutroBi+zgN1czc5aiWll756/zdvf2H6nQQlGD+Gf+ADrIM+T
V6iZ/DPaxQiiSPFaLpjZv3N8kL90zUG30W2fJloEDLBT94ZTrVdKVnT98zTGsk26
BMFHYkbM3zPVnqcaIbPwwZp15/JAFHVLw4m8aCG5RT2kS2HDsMC1+BFhM7Xp+pjU
1zm/TVkhJi28gHoaqzY8Pf2njZEDcxouEf2gxWMQDCqF/6TcmqdvdVZoM6KKPLX8
8x8EA3U1iGLB9LMWrhknud/1hBH/4ravInvhIL641eO3E4C1oluG5t/Vs7PrLMM=
=P3lI
-----END PGP SIGNATURE-----

--==_Exmh_1632501120_29054P--
