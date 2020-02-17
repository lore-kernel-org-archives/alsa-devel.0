Return-Path: <SRS0=LPcU=4F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE46C34022
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:02:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A390920801
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fTFOMP2h";
	dkim=pass (1024-bit key) header.d=ap2c.com header.i=@ap2c.com header.b="Ae7MdXi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A390920801
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ap2c.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1E91166F;
	Mon, 17 Feb 2020 20:01:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1E91166F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581966123;
	bh=d6u20ymNGDGT/s/mTlhh2v1n/whenhAnS82N9faW8Cc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fTFOMP2hzI0SDhHazS80t0RAxLk53/OnwLtUqRn4Os0PeiPtdc38XWXo80z/hxPMI
	 TF2tYyjMNyNscZUE6KRIdiF7FTW+xgJgO48xtuywyFzBQCJ27tmfCKvUyW9gDJ3J7r
	 qWxWBoAFKLNp5un0OFJJUofFxjhrbX9lK8HJk4mw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5D052F8015E;
	Mon, 17 Feb 2020 20:01:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C754CF80172; Mon, 17 Feb 2020 20:01:10 +0100 (CET)
Received: from berkelium.ap2c.org (unknown
 [IPv6:2a01:e35:1386:d790:250:fcff:fe42:7bed])
 by alsa1.perex.cz (Postfix) with ESMTP id 47FF3F800C4
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2020 20:01:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 47FF3F800C4
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ap2c.com header.i=@ap2c.com
 header.b="Ae7MdXi7"
Received: from berkelium.ap2c.org (localhost [127.0.0.1])
 by berkelium.ap2c.org (Postfix) with ESMTP id 982131164;
 Mon, 17 Feb 2020 20:01:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ap2c.com; s=ap2cCom;
 t=1581966066; bh=d6u20ymNGDGT/s/mTlhh2v1n/whenhAnS82N9faW8Cc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ae7MdXi7+sdE7bA42VHO3APIeICApFeSqUysqJRzDxlz0ulTA79pVrCGMsR2lDd8F
 rDZqmLDbz0MAXHr0wlM60MVNxO/njkZpalRQYgWfQIjegU5q3LFqKT7EEcIdMOmscb
 wjJVvLNmzmG/AwhUHOertSHKMQ/L7KC4I5lnP4KM=
X-Virus-Scanned: amavisd-new at ap2c.org
Received: from berkelium.ap2c.org ([127.0.0.1])
 by berkelium.ap2c.org (berkelium.ap2c.org [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id EJvim-mLAqJv; Mon, 17 Feb 2020 20:01:05 +0100 (CET)
Received: from antimony.ap2c.org (unknown
 [IPv6:2a01:e34:ec20:ab90:63ad:3e9d:5e02:f5e0])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by berkelium.ap2c.org (Postfix) with ESMTPSA;
 Mon, 17 Feb 2020 20:01:05 +0100 (CET)
From: =?ISO-8859-1?Q?Aur=E9lien?= Croc <aurelien@ap2c.com>
To: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] No sound with Realtek ALC298 on a Samsung Galaxy book
Date: Mon, 17 Feb 2020 20:01:05 +0100
Message-ID: <5023991.OkN0jAucn1@antimony.ap2c.org>
Organization: =?UTF-8?B?QVDCskM=?=
In-Reply-To: <s5hd0adfapa.wl-tiwai@suse.de>
References: <1610933.XPBrhYXKCp@antimony.ap2c.org>
 <2757884.e1HrdM282F@antimony.ap2c.org> <s5hd0adfapa.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Cc: Takashi Iwai <tiwai@suse.de>
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

> Sometimes you have some data in *.INF file or such.  At least, if the
> standard Windows driver (not the h/w vendor's one) works, the extra
> configuration is usually put there.

The Windows driver is the one provided by Realtek. The manufacturer ID is 
"INTELAUDIO\FUNC_01&VEN_10EC&DEV_0298&SUBSYS_144DC14F".
I looked into the INF file which corresponds to this driver but I'm not sure 
to understand it. There is a specific section attached to this device which 
looks like:
[CusEffectSettingsMaxim.AddReg]
HKR,SSTPPCfg\{C75061F3-F2B2-4DCC-8F9F-82ABB4131E66}\SPK\EFX,16777217, 1, 
1,0,0,1,1,0,0,0
HKR,SSTPPCfg\{C75061F3-F2B2-4DCC-8F9F-82ABB4131E66}\SPK\EFX,16777218, 1, 
2,0,0,1,0,0,80,2
....

I don't know if the solution is in these lines or not..


> Also, when you test the sound, don't use PulseAudio but test directly
> with ALSA native apps (e.g. aplay with -Dhw:0 or -Dplughw:0, etc).
> You can use speaker-test program, too.

I tried again all the channels with headphone only by using only ALSA and not 
pulseaudio. There is no sound at all.
Note that the internal microphone and the microphone of my headphone when it's 
plugged in works very well..

> And always try a headphone output at first.  The headset mic might not
> work, but the headphone output is usually the easiest one to get
> working.


Thank you for your help. I hope we'll find the problem..



