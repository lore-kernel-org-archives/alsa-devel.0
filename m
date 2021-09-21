Return-Path: <SRS0=+sGq=OL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB072C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 17:35:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B184C61184
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Sep 2021 17:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B184C61184
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paranoici.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6690825;
	Tue, 21 Sep 2021 19:34:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6690825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632245745;
	bh=6uBD3ddbL0aieWi8ijaMMU/gFpcifb0efKzyXxE8qIs=;
	h=Date:From:To:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n5NYV5oDuEVVh6KXlxGh+UbllqB1f22u5kFLUWUub5PHgsOom+0Ghyok3gfWTf7dn
	 /VsR8zeVCJ00A1kPhowiWV5xUyvYU/ALxC0l5cR0OfErEV/x0wQtGWBmjqWQ5R3+MT
	 JEI1Te7wsxtHkEwYnRjoioJRGTK+T1DNmirxemmw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FA1FF8025F;
	Tue, 21 Sep 2021 19:34:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ECC7BF80268; Tue, 21 Sep 2021 19:34:52 +0200 (CEST)
Received: from confino.investici.org (confino.investici.org [212.103.72.250])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D45FF8011F
 for <alsa-devel@alsa-project.org>; Tue, 21 Sep 2021 19:34:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D45FF8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org
 header.b="VWy1uCN5"
Received: from mx1.investici.org (unknown [127.0.0.1])
 by confino.investici.org (Postfix) with ESMTP id 4HDT814knhz1153;
 Tue, 21 Sep 2021 17:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
 s=stigmate; t=1632245681;
 bh=6uBD3ddbL0aieWi8ijaMMU/gFpcifb0efKzyXxE8qIs=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=VWy1uCN5pC8lIoGAv7blO7YE3lsCmWS7GFW1Ypj9CIPXa26AJA7x6HeX3y+GtqEdQ
 0qbv2rTWRPZjpXnUsPGJoE8ek9W88O5YbzoLnEnWvgAjXBKVBTCwS0KXn3LEwQz9aK
 Fad5Cv655EypC1kA/Frf9aZnxvQDfzNjLKQocbVs=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250])
 (Authenticated sender: orest@paranoici.org) by localhost (Postfix) with
 ESMTPSA id 4HDT812w53z10xs; Tue, 21 Sep 2021 17:34:41 +0000 (UTC)
Date: Tue, 21 Sep 2021 17:34:36 +0000
From: AreYouLoco? <areyouloco@paranoici.org>
To: linux-audio-dev@lists.linuxaudio.org, alsa-devel@alsa-project.org
Subject: =?US-ASCII?Q?Re=3A_=5BLAD=5D_Mackie_Onyx_1640i=3A_Long_ru?=
 =?US-ASCII?Q?n_playback_results_in_xrun_and_hang=2E?=
In-Reply-To: <12c47c5d-cae0-8c68-cfb5-8161e8d0d4fb@paranoici.org>
References: <FC940720-82E9-4091-8ED0-36AA3CC4D682@paranoici.org>
 <12c47c5d-cae0-8c68-cfb5-8161e8d0d4fb@paranoici.org>
Message-ID: <C31FF33E-123C-47B4-AA37-45E8B573F36A@paranoici.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

So the problem was pulseaudio hanging and not respawning because it cannot =
handle realtime priorities=2E

On September 13, 2021 11:36:59 AM UTC, AreYouLoco? <areyouloco@paranoici=
=2Eorg> wrote:
>I am going to recompile the kernel with options mentioned here:
>
>https://www=2Ealsa-project=2Eorg/main/index=2Ephp/XRUN_Debug
>
>And try to debug why the xrun appears=2E
>
>I also checked with buffer size 1024 and exaclty one xrun and then hang r=
epeats=2E
>
>On 9/13/21 12:23 PM, AreYouLoco? wrote:
>> Hi,
>>=20
>> I am using custom build real-time kernel 5=2E12=2E2-rt3-fw=2E JACK with=
 ALSA
>> backend on Mackie Onyx 1640i=2E
>> Lenovo Thinkpad T420 with FireWire=2E Debian Bullseye (11=2E0 - stable)
>> JACKD version 1=2E9=2E17=2E
>> I am using 512 samples 3 periods @48kHz=2E
>>=20
>> The problem is that long run playback only around 1h (but the time
>> differs), result in
>> XRUN detected by JACK logs and the whole audio stops=2E So I have to
>> restart JACK in order to make it work=2E
>> DMESG is silent about that issue=2E But sometimes I get:
>>=20
>> snd_oxfw fw1=2E0: Detect discontinuity of CIP: E8 00
>> And different hex values there=2E
>>=20
>> Here is interesting part from the log:
>>=20
>> Sun Sep 12 22:10:12 2021: Jack: JackRequest::Notification
>> Sun Sep 12 22:10:12 2021: Jack: **** alsa_pcm: xrun of at least 0=2E027=
 msecs
>> Sun Sep 12 22:10:12 2021: Jack: Repreparing capture
>> Sun Sep 12 22:10:12 2021: Jack: Repreparing playback
>> Sun Sep 12 22:10:12 2021: Jack: ALSA XRun wait_status =3D 0
>> Sun Sep 12 22:10:12 2021: Jack: JackEngine::ClientNotify: no callback
>> for notification =3D 3
>> Sun Sep 12 22:10:12 2021: Jack: JackEngine::ClientNotify: no callback
>> for notification =3D 3
>> Sun Sep 12 22:10:12 2021: Jack: JackClient::ClientNotify ref =3D 2 name=
 =3D
>> dbusapi notify =3D 3
>> Sun Sep 12 22:10:12 2021: Jack: JackClient::kXRunCallback
>> Sun Sep 12 22:10:12 2021: Jack: JackEngine::ClientNotify: no callback
>> for notification =3D 3
>> Sun Sep 12 22:10:12 2021: Jack: JackEngine::ClientNotify: no callback
>> for notification =3D 3
>> Sun Sep 12 22:10:12 2021: Jack: JackEngine::ClientNotify: no callback
>> for notification =3D 3
>> Sun Sep 12 22:10:12 2021: Jack: JackEngine::ClientNotify: no callback
>> for notification =3D 3
>> Sun Sep 12 22:10:28 2021: ERROR: ALSA: poll time out, polled for
>> 15998655 usecs, Retrying with a recovery, retry cnt =3D 1
>> Sun Sep 12 22:10:44 2021: ERROR: ALSA: poll time out, polled for
>> 15998654 usecs, Retrying with a recovery, retry cnt =3D 2
>> Sun Sep 12 22:11:00 2021: ERROR: ALSA: poll time out, polled for
>> 15998659 usecs, Retrying with a recovery, retry cnt =3D 3
>> Sun Sep 12 22:11:16 2021: ERROR: ALSA: poll time out, polled for
>> 15998649 usecs, Retrying with a recovery, retry cnt =3D 4
>>=20
>> Anyone have idea what might be the cause of this XRUN? Or how to debug =
that?
>>=20
>> Its reproducible on my setup=2E Another log catched the same issue:
>>=20
>> Sun Sep 12 16:50:44 2021: Jack: **** alsa_pcm: xrun of at least 0=2E030=
 msecs
>> Sun Sep 12 16:50:44 2021: Jack: Repreparing capture
>> Sun Sep 12 16:50:44 2021: Jack: Repreparing playback
>> Sun Sep 12 16:50:44 2021: Jack: ALSA XRun wait_status =3D 0
>> Sun Sep 12 16:50:44 2021: Jack: JackRequest::Notification
>> Sun Sep 12 16:50:44 2021: Jack: JackEngine::ClientNotify: no callback
>> for notification =3D 3
>> Sun Sep 12 16:50:44 2021: Jack: JackEngine::ClientNotify: no callback
>> for notification =3D 3
>> Sun Sep 12 16:50:44 2021: Jack: JackClient::ClientNotify ref =3D 2 name=
 =3D
>> dbusapi notify =3D 3
>> Sun Sep 12 16:50:44 2021: Jack: JackClient::kXRunCallback
>> Sun Sep 12 16:50:44 2021: Jack: JackEngine::ClientNotify: no callback
>> for notification =3D 3
>> Sun Sep 12 16:50:44 2021: Jack: JackEngine::ClientNotify: no callback
>> for notification =3D 3
>> Sun Sep 12 16:50:44 2021: Jack: JackEngine::ClientNotify: no callback
>> for notification =3D 3
>> Sun Sep 12 16:50:44 2021: Jack: JackEngine::ClientNotify: no callback
>> for notification =3D 3
>> Sun Sep 12 16:51:00 2021: ERROR: ALSA: poll time out, polled for
>> 15998366 usecs, Retrying with a recovery, retry cnt =3D 1
>> Sun Sep 12 16:51:16 2021: ERROR: ALSA: poll time out, polled for
>> 15998353 usecs, Retrying with a recovery, retry cnt =3D 2
>> Sun Sep 12 16:51:32 2021: ERROR: ALSA: poll time out, polled for
>> 15998352 usecs, Retrying with a recovery, retry cnt =3D 3
>> Sun Sep 12 16:51:48 2021: ERROR: ALSA: poll time out, polled for
>> 15998367 usecs, Retrying with a recovery, retry cnt =3D 4
>> Sun Sep 12 16:52:04 2021: ERROR: ALSA: poll time out, polled for
>> 15998353 usecs, Retrying with a recovery, retry cnt =3D 5
>> Sun Sep 12 16:52:20 2021: ERROR: ALSA: poll time out, polled for
>> 15998371 usecs, Reached max retry cnt =3D 5, Exiting
>> Sun Sep 12 16:52:20 2021: ERROR: JackAudioDriver::ProcessAsync: read
>> error, stopping=2E=2E=2E
>> Sun Sep 12 16:52:20 2021: Jack: JackPosixThread::ThreadHandler : exit
>>=20
>> I am willing to provide additional info=2E
>>=20
>> Thank you in advance,
>>=20
>> AreYouLoco?
>> _______________________________________________
>> Linux-audio-dev mailing list
>> Linux-audio-dev@lists=2Elinuxaudio=2Eorg
>> https://lists=2Elinuxaudio=2Eorg/listinfo/linux-audio-dev
>
