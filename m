Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D86C10F25
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:18:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655F620873
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 06:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="DSVG6/lZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hcX3nNIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655F620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EB091677;
	Wed, 11 Mar 2020 07:17:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EB091677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583907477;
	bh=koPyYPcnPETHgCvHEnnCmdmwfA+OhLOvchqTM1xprps=;
	h=From:References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DSVG6/lZNr18HAyScwtHKSF4iuX9gpN0S4Rd+k2xKI9ejb/CNjZwUZS/6F1hKjxaw
	 MCRwGr3R0MF88sziv3T40seDtTtZquLhi69KsW9YEy+POefI3yS+U5JH0L9ZPCALGD
	 QPGTJFP/0tBl6qy+8GdoY2qEkMXBGUazdlNlOe5w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA45CF802A2;
	Wed, 11 Mar 2020 07:15:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7247CF801EB; Mon,  9 Mar 2020 19:14:25 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D38D5F80123
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 19:14:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D38D5F80123
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com
 header.b="hcX3nNIn"
Received: by mail-lj1-x234.google.com with SMTP id e18so10989766ljn.12
 for <alsa-devel@alsa-project.org>; Mon, 09 Mar 2020 11:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:references:in-reply-to:mime-version:thread-index:date
 :message-id:subject:to:cc;
 bh=koPyYPcnPETHgCvHEnnCmdmwfA+OhLOvchqTM1xprps=;
 b=hcX3nNInTx9iPg7EaR+RByFVzvo/cSttxQcApuNwRryPYcMSIWjR9EGkmg4RuaKhT4
 Dvkz7XZHPwiW2D/MPgulKgvlSOp2p1+Z6RSgpSLCSj8oQlR1KydMYFuXN2GJqA+khaaI
 n+jHxvfrvN4OZXWhrflT6H8M3bYWCmMJnNwL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:references:in-reply-to:mime-version
 :thread-index:date:message-id:subject:to:cc;
 bh=koPyYPcnPETHgCvHEnnCmdmwfA+OhLOvchqTM1xprps=;
 b=O/6KK9PfdcizM3iNiROMdl6TF+ARSxXcdC10nrkf+zRjqCUKO30JNRNd+nYh/RpfPy
 3cUY/q4YbKh9RDss5m4+GAUWW+qIra9F0uK3RHURbbWoA7IxvfXQWJxABhXSNxsnPkn4
 6nwMSWBGpxp3s/ZxjmrJ179fWFjPvAPqcnLTGJ31ti1U3mIdYqMXU+mS/lKkeKMQj+aq
 nGrCidiPERbXTO5iDzBhSLMGmOGA3xYefl981r44xL/kiEM10UU42Q4cfoytyY8kbR0L
 hHQcpf0nCzM6WppdWdTyjouQoUcvfW8v8+dqZZdcgHfuKjyy5DBivVMHxu7v+anohlOX
 0zcg==
X-Gm-Message-State: ANhLgQ28A9NNWM3CDOUeGJ3zs8K2XJJluPEPef2KwNV5tW5YQbmxPMhR
 Hjk/z8392Rmi05HNH+nTw21dxuXF0KNVu6DuEzEO/Q==
X-Google-Smtp-Source: ADFU+vtgo6olIYRoVSmwWWivdI6JJjr250gtxBwwoAJTPwO/+EsUYi98/L4RLCE5w9lBmxHiqH1H3VYw5KdKjPdM5rA=
X-Received: by 2002:a2e:80c3:: with SMTP id r3mr10292149ljg.105.1583777660196; 
 Mon, 09 Mar 2020 11:14:20 -0700 (PDT)
From: Kevin Li <kevin-ke.li@broadcom.com>
References: <20200306222705.13309-1-kevin-ke.li@broadcom.com>
 <20200309123307.GE4101@sirena.org.uk>
 <69138568e9c18afa57d5edba6be9887b@mail.gmail.com>
 <20200309175205.GJ4101@sirena.org.uk>
In-Reply-To: <20200309175205.GJ4101@sirena.org.uk>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQK6AtPk+W1UvlC/8YJn5FlJAEq5hQGCyJpIAfJ2lUUB0s+e4qZONC5g
Date: Mon, 9 Mar 2020 11:14:18 -0700
Message-ID: <8113837129a1b41aee674c68258cd37f@mail.gmail.com>
Subject: RE: [PATCH] ASoC: brcm: Add DSL/PON SoC audio driver
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 11 Mar 2020 07:14:40 +0100
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Scott Branden <sbranden@broadcom.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Takashi Iwai <tiwai@suse.com>,
 bcm-kernel-feedback-list@broadcom.com, Stephen Boyd <swboyd@chromium.org>,
 linux-arm-kernel@lists.infradead.org
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

I can't really parse what you're talking about here (perhaps some of that
context would have helped...) but it doesn't seem to be the clocking of
the I2S bus which would normally be what master and slave would be talking
about.

It is the clock setting of I2S bus master or slave.
If I am playing music only, I set TX as master. All others are slave.
If I am recording only. I set RX as master. All others are slave.
If I am playing and recording at same time, I set first coming stream as
master second coming stream as slave. If I shut down first stream before
second stream, then I will set the second stream as master, otherwise
there will be no clock/FS signal on the I2S bus to maintain the second
stream to its end.
Hope it is clearer.
