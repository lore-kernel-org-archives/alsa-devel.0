Return-Path: <SRS0=nSv5=DG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A86EC4741F
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:48:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23CEE206D9
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KopeNNjh";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="C22svMhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CEE206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DC4C181E;
	Tue, 29 Sep 2020 17:47:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DC4C181E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601394481;
	bh=9C9NA9gs7eDjTFf8QLP3+29e3J/YqyHLDmkT6XH2WMI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KopeNNjhismk1CBvXmqyLnfjUTmHUdmKaG/6B3m7VFWuFBaXxf8DDVEsGo3zzMu/x
	 h7GfpAeLgHIfZJtwMOQN5ccUK9nU0RzdW0xyGxEac3eul/uS6vB0NdEkfgz/retWsm
	 maGSz7bYIJW30MbPr3+ZSBNjUex+EF+9qUyDIwzg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00818F800AB;
	Tue, 29 Sep 2020 17:47:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C55D2F801F5; Tue, 29 Sep 2020 17:47:08 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 887D2F800AB
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2020 17:47:01 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 7077BA0040;
 Tue, 29 Sep 2020 17:47:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 7077BA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1601394420; bh=me70nD+qBMspyY77HK834GqF5MXlgWAJCcZFv0yqiYs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=C22svMhzgc8fetdX1s8le8wkE4rM8FCnW3oC2GnSvmhQcH0bQWEAoxr+45t9xMrCn
 6lmNy/5vC2sWob5G1n7ybffkAHalNrFfrySUC2O/oeJmex529lG3aaURSn21dxQcLa
 Lu5oowQieSCt+TkUS+ZpI7DrcYyZKLtHqLJLnucg=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue, 29 Sep 2020 17:46:58 +0200 (CEST)
Subject: Re: HDA-Intel UCM crux
To: Takashi Iwai <tiwai@suse.de>
References: <s5hwo0ciorg.wl-tiwai@suse.de>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <46e46e1b-3487-1884-433f-14d569df249e@perex.cz>
Date: Tue, 29 Sep 2020 17:46:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <s5hwo0ciorg.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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

Dne 29. 09. 20 v 17:30 Takashi Iwai napsal(a):
> Hi Jaroslav,
> 
> it seems that the recent addition of HDA-Intel.conf in ucm2 caused a
> regression on our CI tests on KVM.  Namely, when this UCM profile is
> used for a plain HD-audio device on KVM, the device remains muted as
> default at the fresh desktop start up.  Without a UCM profile, PA
> properly unmutes and raises the volume, but with a profile, it won't.
> 
> When the volume was once saved in the pulse local config, it seems
> restored, though.  The tested environment was KDE.
> 
> Could you take a look at it?

Hi,

It seems that the '_boot' command succeed (no-op) in this case so the legacy
configuration is skipped in 'alsactl init'. I'll give a look. Thank you for
the report.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
