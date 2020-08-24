Return-Path: <SRS0=/b47=CC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2A4C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:26:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97DF2074D
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 08:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OKeIBT24";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2k1aUG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97DF2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BB9A15F9;
	Mon, 24 Aug 2020 10:25:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BB9A15F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598257597;
	bh=OLfldAL9VUjeIC9Ywgu+hoiSmT0rc7nMwXpADFevEtY=;
	h=From:Date:Subject:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OKeIBT24rgMiO1h+gk59ROVGVPnGfKlkaGnBKGMVwvD29G4SPsYohRh/VPCZpyv4m
	 jWousSSklQTotJyTGH131+t+hH/g0FUHb4WMFl9ZJfHtX5Pon/+7eGrl6hn44D2dC3
	 lA+PIkp/rWwPQwo8cfM7jBdpX8SwLwFgj5eFvLrI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A108BF8013D;
	Mon, 24 Aug 2020 10:25:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B57E4F801D9; Mon, 24 Aug 2020 10:25:37 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77766F8013D
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2020 10:25:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77766F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="r2k1aUG/"
Received: by mail-lf1-x12d.google.com with SMTP id 145so1141010lfi.8
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2020 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=XVar8OnwfwB1TY87+/LSOHek4rlWMDoo5c+yWk2RNY4=;
 b=r2k1aUG/tv+fnyPTNpIGYy2Cc5GZtD0pUA66AjrBeTDu7rUD55xsxhwjpP8RHEmm9t
 kBOzH1BrdaWJ1iFcZXkImDXwaXPEyKE2XJvftKgLcwub0BpzFJb9uKmkARNDa9UkbCVw
 2/ajfWPNXQLPbyDs5KKUEkow95/0CrDuXNyBdXpfRi3sZWIYTOjPZpJOODzU8waT9bIH
 WN1Zdu7QIZipsmdWZlJpQFNsn3h4JcsA18ZlAAguIAIz+xr+OghmF0+fDctvz304jGls
 ielDsUddo32gzXyAXSUgT8FmX5a3aY7FQeuUIyaXgAemKrAxdMZ/AgCtnPvF1EcQHILw
 cvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=XVar8OnwfwB1TY87+/LSOHek4rlWMDoo5c+yWk2RNY4=;
 b=oy2fybzRx8etEvRRMM4LCK8A3b2pK6BfcVKA05wfTDjIP5pWdwNaq5HRbV0ZkAfOEN
 ivqeXscw/w0J+ZZnZomAtxG8KqJzhdY42a9NEqetyPRMnhkc76eDBge/D9mAE0P8QxiK
 PgaVC8CBOqcAR9Lko+Jhk1qmfJtnvqCNvhPwShhA3hlXWBELOhB9n+cyoTX22zxKCERS
 si/gkJ4ac+DSD1fSgw7AY5fh0EV4gQmuscHfU+3KhiYZY14RKm4JMy1JcACjeJtHPeYa
 PpyxJ54BskwKD6ykG3PCA0QijsrEvR8TQKbI3oksAM/92yLqQ6XOFEgQl17mPhC+cHg8
 PVxQ==
X-Gm-Message-State: AOAM533tBfI9X+av+P+2iXhT2TH9egd+Xd+g2MfKxi4zK0sP3HSR+EwV
 2zVa6+Vz+twQ4XplYM5VXXYI7hZOw22eGPK2KKp38iQLO4OCWg==
X-Google-Smtp-Source: ABdhPJyRzkmzuL/h+URSoXt5HW/DXCJWXq36IsZnQtuNkSunli5Eo16+26j9CpFQ7lCR/oMqnfuHW++pPSjga9MTbag=
X-Received: by 2002:a19:be0e:: with SMTP id o14mr2185892lff.203.1598257524019; 
 Mon, 24 Aug 2020 01:25:24 -0700 (PDT)
MIME-Version: 1.0
From: nick83ola <nick83ola@gmail.com>
Date: Mon, 24 Aug 2020 09:25:13 +0100
Message-ID: <CABPh3UOJXzvFWEoK7XkuV+37=TmHiQ_R7H_nvSCdzbu0WNcTfg@mail.gmail.com>
Subject: Help with EDIROL UA-101 midi not recognized on kernel / UA101
 improvements
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, 
 Clemens Ladisch <clemens@ladisch.de>
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

Hi alsa-devel,

I have an old edirol interface (ua-101) that is still kicking (8 channel
I/O in a small package)

The problem is that recently (I don't know from what kernel) the midi is
not recognized anymore.
Also I would like to implement an application to control the internal mixer.

Can someone help me out/point me in the right direction where to start?Or
help me with this?
I never debugged an USB driver before.

Thank you
Nicola Lunghi
