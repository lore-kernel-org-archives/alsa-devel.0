Return-Path: <SRS0=Eq0+=FZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB9FC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Dec 2020 22:52:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53364229C6
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Dec 2020 22:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53364229C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CB201750;
	Mon, 21 Dec 2020 23:52:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CB201750
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608591170;
	bh=lePDU5VwODevzBS7Iwlgqpthx/TKyjoF3KY6yRcBDFA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bU0jMTqjdwqMF3BDggJZipfsSUUSLrjAFqiTbIzY9PlM+RQXjni+CBkkgZ/NXpTXa
	 nvjaHkuf+y8BbsMAhIPaGt3KIJuP3yGKpi4KAbUTnA0C9DLZLm/1k0kT9tCL0aDYnt
	 V8RHc2GUJ7JbFNehMWRrwsc5Kk+je2hkOgDwCB40=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0466F80168;
	Mon, 21 Dec 2020 23:51:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93633F801D5; Mon, 21 Dec 2020 23:51:58 +0100 (CET)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5EDA0F80116
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2020 23:51:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5EDA0F80116
Received: by mail-ot1-f42.google.com with SMTP id f16so10267358otl.11
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2020 14:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xGMhjs6ip+VhnoHGisVBlYY5haZY44B4LgsaGJIElNA=;
 b=h7bHeP1h3wdhKWiu+NE3wUCJwwgWDF3g0UeRjxZ5VHBgyuzIjePTbyIYweTF5D9Q8P
 1OPubdMc6bx00E5H/J+F5gLgk0NJpWA8KzErThkiERBLQDP0+Upw5NU5ixK71h6K6L5S
 7W7c/P9caZLyghO+RKw/h5JEexvni7YSsC8I5mTCl6oyN+tJyX5Xv3kswisDZjoHqJ8v
 X1yRfJUHpIaf/UgUsUAJmMN9ZW/qbyml5EWnkwu+lQwPy68aYmmP6axsaVY1I4pakbdB
 gVhMBAh+67KE8EVeFSr4QF9npQtGe4VytGGKzYkB4oOx8Ys2JTaxjAL9C6CzTrK02L5J
 5ZBg==
X-Gm-Message-State: AOAM533QFiasl9WIm7Np/Je1O6pJQwFXmUJLBbiGtK4HveWfude2IbEx
 qfZvu2JiF6uQx3XCLUGazw==
X-Google-Smtp-Source: ABdhPJyEneAcqgapuClLy3QG+WNloZI+QjG5a9eKSxP6BzvpzXcDR/RnINhSm96dHxDrcRZGlePjkA==
X-Received: by 2002:a05:6830:1d71:: with SMTP id
 l17mr13816820oti.269.1608591106625; 
 Mon, 21 Dec 2020 14:51:46 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id w138sm3856739oie.44.2020.12.21.14.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Dec 2020 14:51:45 -0800 (PST)
Received: (nullmailer pid 720870 invoked by uid 1000);
 Mon, 21 Dec 2020 22:51:42 -0000
Date: Mon, 21 Dec 2020 15:51:42 -0700
From: Rob Herring <robh@kernel.org>
To: Adam Ford <aford173@gmail.com>
Subject: Re: [PATCH] ASoC: wm8962: Add optional mclk device tree binding
Message-ID: <20201221225142.GA720812@robh.at.kernel.org>
References: <20201217162740.1452000-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217162740.1452000-1-aford173@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, aford@beaconembedded.com,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
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

On Thu, 17 Dec 2020 10:27:40 -0600, Adam Ford wrote:
> The driver can request an optional clock for mclk.
> Update the txt file to reflect this.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

Acked-by: Rob Herring <robh@kernel.org>
