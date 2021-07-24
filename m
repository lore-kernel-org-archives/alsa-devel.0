Return-Path: <SRS0=2VZE=MQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0E0C4338F
	for <alsa-devel@archiver.kernel.org>; Sat, 24 Jul 2021 21:55:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836AC60E78
	for <alsa-devel@archiver.kernel.org>; Sat, 24 Jul 2021 21:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 836AC60E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=hpfr.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 85999175A;
	Sat, 24 Jul 2021 23:54:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 85999175A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627163710;
	bh=DySfM+aaxg4ql9/44vVBshGjcUzcKlymkku+DSGOfts=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vX4ZTsVr6EtPpTgMugFk1a3vFAx/VRuWePPMnG2Zj45RrVSuYoRS7FtHZM+y//Avu
	 dT46xDS9DV1LvK+ZTFiiHKcyvh8t+j7R5WVzHNjAONDGr9vQV+natRzM7FeQMt8sEP
	 0zNRUWsClyd1hoDj/I5Ym+lP8W4emXNBwQBc8K48=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1B89F80086;
	Sat, 24 Jul 2021 23:54:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6B17FF80227; Sat, 24 Jul 2021 23:54:18 +0200 (CEST)
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1ACC9F80086
 for <alsa-devel@alsa-project.org>; Sat, 24 Jul 2021 23:54:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1ACC9F80086
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=hpfr.net header.i=@hpfr.net
 header.b="SkYekklb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpfr.net; s=key1;
 t=1627163645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=1x+pujbYygguQYrnb0Q41BCRMLn5IkDC8m2IdiuwXdQ=;
 b=SkYekklb6rw8lcw4T2vEedMOfBTB+dpOQo5WuqSmn0459WQJ2yj6bTObV47NAUvC/CNkAg
 GHjpjGjqDjzx+IAVewxkEyQU4TxFOZKOOHR0B3Lhe1/Mvb9ohDWL9Psj7MsGeNnPDjdHlx
 Mpwv3rJkN7uLLLkxv4X3lZC8C7CXk+Oj2Yxqw1qBD7qDx1MIX3OW4G6SrR7p7MehBSvZ11
 NFikb6kjQ0BZMuIBZvCwYjHyq61mfoH7tK1ilH/P6TQtO/WO7zrlJtU7nLCKA+sAA/r2dJ
 MVrqDbIXoBznZigM74KPINMG5n/ZzLX5xsD45BkxRTKaHco6pcQsUP2Qg8LmLg==
From: Liam Hupfer <liam@hpfr.net>
To: alsa-devel@alsa-project.org
Subject: Pulseaudio dropping GPU audio
Date: Sat, 24 Jul 2021 16:50:09 -0500
Message-ID: <87fsw3l6o5.fsf@hpfr.net>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: liam@hpfr.net
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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

Hello,

I=E2=80=99ve set up a Linux VM where I=E2=80=99m passing through an RX 580.=
 I=E2=80=99m using the GPU
audio and my monitor=E2=80=99s audio jack. For some reason the Linux VM kee=
ps losing
track of the audio output. It always shows up under `lspci' under ID `06:00=
.0'
using the `snd_hda_intel' driver, but `pulseaudio' (I also tried `pipewire',
same issue) keep losing it. Most times I can restart `pulseaudio' and it wi=
ll
find the device again; occasionally, it takes multiple restarts.

I checked the Arch wiki and I found something[=C2=B9] on audio over HDMI (I=
=E2=80=99m using
DisplayPort, if that matters). I checked the device and it did report `Enab=
le+'.
Even so, I added the kernel parameter `snd_hda_intel.enable_msi=3D1', but n=
othing
changed.

Here are some `journalctl --user -u pulseaudio' logs:
=E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80
=E2=94=82 20:37:31 host pulseaudio[2373]: ALSA woke us up to write new data=
 to the device, but there was actually nothing to write.
=E2=94=82 20:37:31 host pulseaudio[2373]: Most likely this is a bug in the =
ALSA driver 'snd_hda_intel'. Please report this issue to the ALSA developer=
s.
=E2=94=82 20:37:31 host pulseaudio[2373]: We were woken up with POLLOUT set=
 -- however a subsequent snd_pcm_avail() returned 0 or another value < min_=
avail.
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80

Anyone have any suggestions for troubleshooting? `pulseaudio'=E2=80=99s log=
s suggested
it might have to do with ALSA, so I asked for help here.

Thank you!

=E2=80=94Liam


[=C2=B9] <https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF#Slowed_=
down_audio_pumped_through_HDMI_on_the_video_card>
