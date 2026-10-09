Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F28CA9EC0
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Oct 2026 19:42:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5ADA36026D;
	Sat, 10 Oct 2026 21:42:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5ADA36026D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791661377;
	bh=Fz4PEuGI3O7q19w9pR/Qd7L9b3WTupUNixNtZQ6WqEM=;
	h=From:Date:Subject:Cc:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=DyDQAjsOqa7RtUXV3oXg7kGbv5pUVoOWLFvQG3nYQA2qTEgbUZncsetV9WQuw9Rw1
	 5MAqHgb5/NDv68J5wY2KtxnvSg5OLlElJUqr5wIlBSA8FYfwaSZ8IQUv8x1SX1+VCD
	 +ldi9suIGXUu9hr0n0/qsq96X7CqePDWjvQgDNXM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2B29CF8068F; Sat, 10 Oct 2026 21:41:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CD8E8F80613;
	Sat, 10 Oct 2026 21:41:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7409BF80557; Fri,  9 Oct 2026 06:31:51 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1791520310;
	b=rqoZJcn6kvNlBXlIv4+rZrfYCWBVA7mxEUxihG9wNkaZ11EI/DJLA4gjmMBFOvwo6SUU
	 /CajifnI1NUEX2Wn7W7AipEnLesXXW+qA9aT0TjSGwJj70U8TNLwZ4u39df+Uk0HwIw2u
	 YrCBByqphv893URZH7LEoU3XlST8EuNoISVosACdbqB/wRhON3QElVUuNiNtBbw/7C8NC
	 EL6iwHKKn/jK2stl/Hi1BCDaprid1Rmhp4kM0iyb/kbS/ypcPgMHmLpM3P1ku4SYfULGi
	 FjAHKvuNaf/0cwnFyuXYjmhDCocRnXy22xkfen22uO8uH1WboLYSmxqXTeCU9ygpmCA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791520310;
	h=DKIM-Signature:From:Mime-Version:Date:Subject:Message-Id:To;
	bh=Fz4PEuGI3O7q19w9pR/Qd7L9b3WTupUNixNtZQ6WqEM=;
	b=QEGPWmD4fjrnue+q7vmboUvMnU9wDG1vi77RQcxQdqkV/F1h5G+RRpun6Nr+LqR782xD
	 2vNBWBuZQPgf5S31COwBh/JudTQSDj2xT2CthDar8xBvLooiEhu7/PYn8i3nQPLAOMXQG
	 Cx53Y/vCvaYkyUzDmhmjqsmRiHExOAdqUl7Wf7Hnk0Ky8ycW5m4sZ33udSM6yXQaljIrg
	 bi1VZ47iDmD6ih5OUBAp2l33O2nUdAcOeov6ZbJI45F/qZjVJRpUpdNeOPeWUeUEUqooW
	 +8YBjPf7VBkOzlZ61XVnkKx/19HMOrmBl/LdMX+ps5YQUpAHMkCfPSu7tU1+u3DQIUQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Z+mIUMQx;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6FC72F8025A
	for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2026 06:31:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FC72F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Z+mIUMQx
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-9199927cb42so19313656d6.2
        for <alsa-devel@alsa-project.org>;
 Thu, 08 Oct 2026 21:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791520307; x=1792125107;
 darn=alsa-project.org;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xh/x7oXNS4mJ8zsjUTn1R5anhCmSoMMsD8wrAIfaouw=;
        b=Z+mIUMQxETGnZLZ5ojszcEBAGcDitMwfPvRjO6awYqyna7WxZ8+BFW9hOfJwtvX2cr
         NumJjf2Wze0ls6r7k0YzvqwD52p7h9H6/2ItYYT2E8cPRmROaps0wdWtlpHFuQDw++4C
         pQlnZfQ3rNHmdAMWWre9ShnyxCuc3Y4FS11mHL/B+hVcKSSWc74754PofmLuP8Gy7aLv
         9Ot3cVyqrQK8jAymqY56mel2IhNw1NihCSUhA1X9IZUPU9Z/pNLEIQEEPfORKl/Ac+Jl
         MPuTh2kPjOEaFGj38+GFZIMkPT1WvGHgqzK9fkqM5Ua1uXhb92EwOH31haEnOqa0QxwR
         8AfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791520307; x=1792125107;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:content-type:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xh/x7oXNS4mJ8zsjUTn1R5anhCmSoMMsD8wrAIfaouw=;
        b=WaMlCfYUQM446P4iCS+LbHwvMcmRxODbabDkztAJ2/64+NSTf0SK+Tut6qJYDELE5V
         ryCq53WBdJ/0zhxMLQsy/xy27DtrPRXR4BOx70YwgtNOn/DnMsxWG0LSgElvpPXP/TPe
         E4UF7m729646Y1BbjExZk/8tOHwBUy0uEBS5bRKMpJdfhXFF9a7YvgMyYQKWKDhD5kE+
         MD9i29CK+vICdgQykw8UmkYZiUuU62NXFvLhdZxBRJn2QV4/c9G+OV5pyT4IXQOQfL9x
         WTGF9qxSmnmguNSjU6b6aGH3mZVxeoop1Nhx97mxX+nVTDsl+oveNr6FQ+xpQnUBRhjJ
         rOtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz543wNbvDVEnIq18tBEthWri3old7rgSBk1VGD9m/TRSbfDoIiRc2nrmD9rLoJCgofe83niIsoOkT/@alsa-project.org
X-Gm-Message-State: AFuF++m+JfvXqb7KFMokdlAnkuHMRWu3F0wKXuHii6jGXEU54WA2OmiW
	clTA4flKdDkw2xnMTzF6bieYRhmPnWQTB6Ncnr2g3jEfmjyK5l4eEx2Z
X-Gm-Gg: AYBFou3NizHN2csYEKpVpfbjHTypGbwJNVShSOqmL/MTAloUKWhE6j4+jhWqZv6hhLl
	KLzLlJlu5LA218PdUzoE++ClUfQXL/ajHLtySnComgit/L6rszKddcTca0IXiipYbYZezjyL35H
	/q6jgXooCjMId7/xeLnvUiLdFFAJnXnI4Gkay/TNGWVvMpT1lDIrcczLjZhUt1AfzdnrdvWFHIR
	644ZOMapk2Sp5QNNyfnoqQRsqOXtQP7zEDELA8T1HhG5ypSY/zkz/MxAJfjHO4myD4fv84Zl1ve
	5Ag6bYuMLfxnQIj+Wja4YGxyzFgwtVoJhDrVbqr7dXk5kaixKQuKMiPpDkVpi4UhAHWTd9rRk5U
	ew6MBDJDOLlIc1/ja7JuIJTQZj9clztQcSEBaIvhIUHvxaSRiyHIgJAtsQcIR1WhP1H0pZ8BKnk
	0+QlJgF0qG/9doa8WXtn53WJOB1OpzjQnwK0mfg8M0laLjZXPEJKlD4VyOWnHnDhJeWGjY19cjZ
	NoGuHOtix3u8YMB0t8IP2zGDBJ4Ooz+/+3/HHe9Hy082Zu4BVtNXRvLsg==
X-Received: by 2002:a05:620a:2985:b0:93e:910c:5e65 with SMTP id
 af79cd13be357-93ebd26b66fmr106881185a.49.1791520307022;
        Thu, 08 Oct 2026 21:31:47 -0700 (PDT)
Received: from smtpclient.apple (c-24-245-44-53.hsd1.mn.comcast.net.
 [24.245.44.53])
        by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b5501755asm8674026d6.12.2026.10.08.21.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 21:31:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Cory Mattson <corymattson@gmail.com>
Mime-Version: 1.0 (1.0)
Date: Thu, 8 Oct 2026 23:31:35 -0500
Subject: ALSA: hda/realtek: LG Gram 16T90SP (ALC298 + ALC1318,
 SSID 1854:0521) - no speaker output, need amp init sequence
Message-Id: <0270FFF8-D78F-40D7-874F-6240AEA8C759@gmail.com>
Cc: kailang@realtek.com, zhangheng@kylinos.cn, tiwai@suse.de
To: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
X-Mailer: iPhone Mail (24A446)
X-MailFrom: corymattson@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: ZTIP3ALRXDSKK4YNN5FTXSR2UYLPQZNM
X-Message-ID-Hash: ZTIP3ALRXDSKK4YNN5FTXSR2UYLPQZNM
X-Mailman-Approved-At: Sat, 10 Oct 2026 19:41:36 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZTIP3ALRXDSKK4YNN5FTXSR2UYLPQZNM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Kailang, Takashi,=20

I=E2=80=99m hoping you can assist with resolving a problem I=E2=80=99m havjn=
g.

The internal speakers on the LG Gram 16T90SP (Meteor Lake, ALC298, SSID 1854=
:0521) are silent under Linux. Headphones and Bluetooth work. Windows works,=
 and the Realtek driver there (RTKVHD64.sys) drives a Realtek ALC1318 I2S am=
p behind the ALC298. No existing in-tree quirk enables it.

Bug report with full dumps (alsa-info, Linux codec dump, Windows RtHDDump fo=
r speakers and headphones):
https://bugzilla.kernel.org/show_bug.cgi?id=3D221815

Tested so far, all with silent speakers (playback runs normally in software)=
:
	=E2=80=A2 SOF (sof-audio-pci-intel-mtl) and legacy snd_hda_intel (d=
sp_driver=3D1)
	=E2=80=A2 model =3D17aa:231e (ALC287_FIXUP_LENOVO_THKPAD_WH_ALC1318=
). Mapping 1854:0521 to this fixup directly oopses in try_assign_dacs on pro=
be.
	=E2=80=A2 model=3D1854:0490 (ALC298_FIXUP_LG_GRAM_STYLE_14) and mod=
el=3D1854:0488 (ALC298_FIXUP_SAMSUNG_AMP_V2_4_AMPS)
	=E2=80=A2 Windows Wid 0x20 coefficient table from RtHDDump, with ma=
tching pin 0x17 routing
	=E2=80=A2 GPIO mask/direction/data sequences (0x01-0x08), alone and=
 after the Windows coefs
	=E2=80=A2 Zhang Heng's test script using ALC1316-compatible tunnel w=
rites (coef 0x22 =3D 0x0010, amp power-on coef 0x10 =3D 0x1b21)
ACPI lists 10EC1308:00 on _SB_.PC00.I2C3.HDC1 at I2C address 0x10, with stat=
us=3D0. Probing 0x10 on that bus (i2c-[1]) during playback gets no response,=
 so the amp appears to be reached only through the codec, not over I2C.

A VFIO verb capture isn't possible on this machine: the audio controller (00=
:1f.3) shares an IOMMU group with LPC, SMBus and SPI.

Kailang, could Realtek share the ALC1318 init sequence used for SSID 1854:05=
21 (or 18540520/0521), or point to which existing ALC1318 fixup is closest f=
or an ALC298 host? I can test patches right away.

System details:
	=E2=80=A2 LG Electronics 16T90SP-G.ADB8U1, BIOS 16T90SPF08 (04/24/2=
024)
	=E2=80=A2 Intel Core Ultra 7 155H, HDA controller 8086:7e28
	=E2=80=A2 Codec: Realtek ALC298 (10ec:0298), subsystem 0x18540521, r=
ev 0x100103
	=E2=80=A2 Kernel 7.0.0-28-generic (Ubuntu 24.04 base)

Thanks,
Cory Mattson

