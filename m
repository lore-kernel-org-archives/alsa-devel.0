Return-Path: <SRS0=Q8D2=NZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,CTE_8BIT_MISMATCH,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D131C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 21:50:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194566101A
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 21:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 194566101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5E8518EC;
	Fri,  3 Sep 2021 23:49:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5E8518EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630705833;
	bh=vCus6JzxlXIYvORlsPi9DH5CH2iItRA82smcqzNwLaQ=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z+5azA5P03HYz/YomNy5By3HiFObM//o3snRq3fcawaIOJ7PlFSeu0fkHEfAGh8Pv
	 kn3hL4fppGfLWJwWLm4vw1dFKk54Anx8f49rDvzZucaK1gpmOX5/Cqn/pnI9jf31ut
	 mZWdyX863azPdjDdf7G4Sjyj2xcIVdNURk+OdL8M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DB72F80227;
	Fri,  3 Sep 2021 23:49:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6755F80256; Fri,  3 Sep 2021 23:49:40 +0200 (CEST)
Received: from forward501j.mail.yandex.net (forward501j.mail.yandex.net
 [IPv6:2a02:6b8:0:801:2::111])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2745EF800B5
 for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2021 23:49:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2745EF800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru
 header.b="QmWR2djD"
Received: from iva3-ba3089b2118c.qloud-c.yandex.net
 (iva3-ba3089b2118c.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0c:4993:0:640:ba30:89b2])
 by forward501j.mail.yandex.net (Yandex) with ESMTP id 1163E6237EB;
 Sat,  4 Sep 2021 00:49:32 +0300 (MSK)
Received: from 2a02:6b8:c0c:a8a6:0:640:646b:8704
 (2a02:6b8:c0c:a8a6:0:640:646b:8704 [2a02:6b8:c0c:a8a6:0:640:646b:8704])
 by iva3-ba3089b2118c.qloud-c.yandex.net (mxback/Yandex) with HTTP id
 PnTnRZ0D0eA1-nVDOSajt; Sat, 04 Sep 2021 00:49:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1630705771; bh=wNd4T1/1u7lfBIu4RPFs2V738Ar7zXhkF6YTbIDabf0=;
 h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
 b=QmWR2djDZXvhtjv5QCQn0cDda4ySw961LqcVrvAjYDYR4bV3/ZQN9fZSEF0v//mmG
 S/lSrFFNhtZtZs72mnq37lcAbE1rbJ9QJhm1X1OyoCumHedvALLTxLx86lIgG1YiFQ
 2AgV3UrKkqBAh4S8M77UDW3LjiyXiwt7oFMq6xb0=
Authentication-Results: iva3-ba3089b2118c.qloud-c.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by iva8-646b8704b117.qloud-c.yandex.net with HTTP;
 Sat, 04 Sep 2021 00:49:31 +0300
From: =?utf-8?B?0KHRg9GA0LrQvtCyINCf0LDQstC10Ls=?= <surpaul@yandex.ru>
Envelope-From: surpaul@yandex.ru
To: Geraldo Nascimento <geraldogabriel@gmail.com>
In-Reply-To: <CAEsQvcuqkff--CgGDa8j0=GWgqMAx09ooo3zRCmGK8drxXGpMA@mail.gmail.com>
References: <333881630574354@mail.yandex.ru>
 <CAEsQvcuqkff--CgGDa8j0=GWgqMAx09ooo3zRCmGK8drxXGpMA@mail.gmail.com>
Subject: Re: No sound after kernel 5.8.15-301
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Sat, 04 Sep 2021 01:49:31 +0400
Message-Id: <676251630705379@mail.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
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

   Â

   $ aplay Enable.wav
   Playing WAVE 'file.wav' : Signed 24 bit Little Endian in 3bytes, Rate
   48000 Hz, Stereo

   $ pasuspender -- aplay Enable.wavÂ

   Playing WAVE 'file.wav' : Signed 24 bit Little Endian in 3bytes, Rate
   48000 Hz, Stereo

   In the first case, the music plays, and in the second, it doesn't.

   $ aplay -l / $ pasuspender -- aplay -l
   **** List of PLAYBACK Hardware Devices ****
   card 0: PCH [HDA Intel PCH], device 0: ALC256 Analog [ALC256 Analog]
   Â  Subdevices: 1/1
   Â  Subdevice #0: subdevice #0
   card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
   Â  Subdevices: 1/1
   Â  Subdevice #0: subdevice #0
   card 0: PCH [HDA Intel PCH], device 7: HDMI 1 [HDMI 1]
   Â  Subdevices: 1/1
   Â  Subdevice #0: subdevice #0
   card 0: PCH [HDA Intel PCH], device 8: HDMI 2 [HDMI 2]
   Â  Subdevices: 1/1
   Â  Subdevice #0: subdevice #0
   card 0: PCH [HDA Intel PCH], device 9: HDMI 3 [HDMI 3]
   Â  Subdevices: 1/1
   Â  Subdevice #0: subdevice #0
   card 0: PCH [HDA Intel PCH], device 10: HDMI 4 [HDMI 4]
   Â  Subdevices: 1/1
   Â  Subdevice #0: subdevice #0

   In dmesg, I did not find anything interesting, except for this. Should
   there be front headphone and speakers or just front headphone?

   $ sudo dmesg | rg HDA Â  Â  Â  Â  Â  Â  Â  Â  Â  Â  Â
   [ Â  Â 3.190288] input: HDA Intel PCH Front Headphone as
   /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
   [ Â  Â 3.190322] input: HDA Intel PCH HDMI/DP,pcm=3 as
   /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
   [ Â  Â 3.190355] input: HDA Intel PCH HDMI/DP,pcm=7 as
   /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
   [ Â  Â 3.190413] input: HDA Intel PCH HDMI/DP,pcm=8 as
   /devices/pci0000:00/0000:00:1f.3/sound/card0/input21
   [ Â  Â 3.190472] input: HDA Intel PCH HDMI/DP,pcm=9 as
   /devices/pci0000:00/0000:00:1f.3/sound/card0/input22
   [ Â  Â 3.190501] input: HDA Intel PCH HDMI/DP,pcm=10 as
   /devices/pci0000:00/0000:00:1f.3/sound/card0/input23

   Â

   02.09.2021, 23:06, "Geraldo Nascimento" <geraldogabriel@gmail.com>:

   Hi, Pavel,
   Â
   Standard advice is to try aplay ALSA command while suspending
   PulseAudio/PipeWire.
   Â
   Also please check your dmesg log for anything strange.
   Â
   Thank you,
   Geraldo Nascimento
   Â
   Em Qui, 2 de set de 2021 12:23, Ð¡ÑÑÐºÐ¾Ð² ÐÐ°Ð²ÐµÐ»
   <[1]surpaul@yandex.ru> escreveu:

     Â  Â Hello!
     Â  Â Ã
     Â  Â I lost sound from laptop speakers after updating the kernel.
     Sound via
     Â  Â HDMI, AUX or Bluetooth works. Details on the links:
     Â  Â [1][2]https://bbs.archlinux.org/viewtopic.php?id=269301
     Â
     Â [2][3]https://ask.fedoraproject.org/t/no-sound-after-kernel-5-8-15
     -301/164
     Â  Â 41
     Â  Â Ã
     Â  Â Help me please.
     Â  Â --Ã
     Â  Â Pavel Surkov
     Â  Â Ã
     References
     Â  Â 1. [4]https://bbs.archlinux.org/viewtopic.php?id=269301
     Â  Â 2.
     [5]https://ask.fedoraproject.org/t/no-sound-after-kernel-5-8-15-301/
     16441

   Â

   Â

   --Â

   Pavel Surkov

   Â

References

   1. mailto:surpaul@yandex.ru
   2. https://bbs.archlinux.org/viewtopic.php?id=269301
   3. https://ask.fedoraproject.org/t/no-sound-after-kernel-5-8-15-301/164
   4. https://bbs.archlinux.org/viewtopic.php?id=269301
   5. https://ask.fedoraproject.org/t/no-sound-after-kernel-5-8-15-301/16441
