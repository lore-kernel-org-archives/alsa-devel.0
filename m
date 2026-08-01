Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F7BC5518E
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:37:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E44F860209;
	Mon,  3 Aug 2026 11:37:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E44F860209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785749859;
	bh=Bltht+q0Owqwr/jPSfkjocl1D5/JflDZGLG+4NP3eJ4=;
	h=Date:From:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=qWuAnHFlYuJX6BORmd2t2BpILUihRuHtQZ9tPH12UQHN1GniuMFuuGUMPoRw9PzVo
	 EUy24vDX1vMUJI1BhCXlZ0vZfY3KcOWVwT+zaq3tNnsVl6gHHpPK0Zeibp/WBYa+ND
	 npyJ3jb80R6eA45RP2wF+DKtNlmfGzQfZiGwOFMw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3B0F3F80614; Mon,  3 Aug 2026 11:36:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CA8F9F8061D;
	Mon,  3 Aug 2026 11:36:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3CF6F804CC; Sat,  1 Aug 2026 21:29:56 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785612594;
	b=OooLGWr2Ofe5uIjXUFMTVq5h5qAAD2oDfCEW/b2K/pep9AuHTx3gSzwbcrKM1giRxxZY
	 I5Swf5oRDc7qbcLhl3A7EjfAdeLB7xin06aUXJZppcqrlwb/rUE2s3HYDwRAIIkS04MxA
	 8Bh5UbyUPC6Oy2Dgw5qW8WSulCWB4251RQUSTfxJNTh7H1AKkQAIquWaQ68bYzcsSw1G7
	 Q3Rrf11WFt/EnGoe27Au4N7ZrcsIheX1D6VI1xwh6nGhHF5ht1rxXcFDAB7LhQQR61b1E
	 /GmnM9gq/gvUczVOojQ4T5NoBQs98V5oKj00NB2vdSas+vzOwicC5PQn3506lFbXGdA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785612594;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=Bltht+q0Owqwr/jPSfkjocl1D5/JflDZGLG+4NP3eJ4=;
	b=IabZHVCpTqXzyjl4Sxncj1FhJ6k5PeKvQ6dQNmnkm4+OGtea6x1E680MbEdkB3hbkxjE
	 0liGHc2B0eVyB9og9g67r8Ta9g4HP+SU3VRretQXr8OPeWVrXDKNRqpSreTXIqYK7gldF
	 SzRM2DBC+BXIsoA70UIXzD4Wn8xeNbWC3DEMqJVnblmgUxHAB45tdqrd0KhWFs5OWjEBo
	 9p4inMeEREvsDxr93vNIngkc9cQnNX1t+CYsJv2GVZ1BgF+s0IvUqxXbLXek/grPH1QAK
	 9oKWKGZcprUdmYdR1sKpThSbzNVuUKW8lUDPLmXUvOOEcbb03mqcyibmjNj4KRWjjXg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=p61DtKTP;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 87AABF8032D
	for <alsa-devel@alsa-project.org>; Sat,  1 Aug 2026 21:29:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87AABF8032D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=p61DtKTP
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-81f3b227a4aso32552997b3.1
        for <alsa-devel@alsa-project.org>;
 Sat, 01 Aug 2026 12:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785612591; x=1786217391;
 darn=alsa-project.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f8EwEgCLAzSnLLvTB0ORM/t+tuYV4Jrt2Go9jEaMnDU=;
        b=p61DtKTPP/jOrpzayWu46Rdaid+wkHdyNMCA79fNHcVqzBjj3ZpfGloeXiGp8FsyR/
         kOMbb++kpkZydGZkhgMAW67v2zaawH/rFbr+81nOLGSVM6zurIa0/MJ7UKwwJC7uWVoZ
         rI8nyBBCXNZ2HEM0t8WDAzo4giNCj8NHgogWYP46yjHLJKo3HxIchGV/NhZwQ6cR5jTu
         SZyGEcb+KRdEHqzGuR89pXdG0Q031w4xIDe08KY7U0xf9aqaVSp8qv1SY8YlOto59Mm5
         jKUYd6ZtP74WsIEPohEiOeDI1wcYI3lH0P9xW20JjM8f7ETHAeJ99FWNy4w7TqHjzuzf
         X8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785612591; x=1786217391;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f8EwEgCLAzSnLLvTB0ORM/t+tuYV4Jrt2Go9jEaMnDU=;
        b=gob8hv6w8Pd1vtEtgF1T3kYMghFOdmxC16GU9RUdxpkfins6W/Veff5JQWUYcZnhCq
         WoIGgu84pvWORvNQqyKd0NESDJC6EJY1d2hMYasdnWpbxOAc3dYrOlunenHEiuVnwJIM
         TzIvU1muCHcTFCW3Tnue39lIEC0Ho2QkNsS1J8giAPMMvqZb2wSVY8wSZzZrQmhbe3r/
         KnK0vbh1/boVGGKMQKWkKynUQvbOTQ3dvtb0jCstDkjGm7wCezZRyeFiE5d5NFtaLKw/
         JI1WtSCDQtVznHRR3vaJaQYtcPR9yQrx3GfUGDMNxzO3h7Mh5Ta6RFXxErZQWBY9qTTS
         x9sQ==
X-Gm-Message-State: AOJu0YzPZ/wa1+7/LLIPVlZYxhRH5cRXXvN1pF+K34PotMr8tz0F4jeM
	xkJi93scxDc9JkxcM1NYqsxpmnqHldPIC/4VQu8aC33T70txEfNd5zJdb1D3nm0P
X-Gm-Gg: AR+sD11bsGcAnW8lZTSaYaiFYtgxvjHlVQ52ITx29qhDZwmjrNFbNz4+4VBKe8bbL8I
	H2ldeJ1MQFzPnivHdyjUN55C6CsXBXWZEW1ehm5AiYZcjJxCW+QTe/lvn9m1Dom3O2BWX4F2xZN
	ceR4SpMFqcQBam9yWbPjKkGFYrWAvBB9WAMofsVjAki9tfu+bnHXRONSx3RJqqZmxwKsxhgo7rI
	LbT1bPIRO6dSC9wyFjbcZLWFjYKLyLm1zphYtwKeBT1Gp6sYMl4hpDcjOkTZ66nsQj0mATVqXT+
	mrhDe60A2CRrXAxmRVhUaBePYsZ3autJQbzhp2ZJTAvMaj3f2PDU2wRsVeITGfa15wV0Mel9Lhc
	OizdKYenbyCeEGcy4Fu9ntX8hXjDcdG5AtQ4e3okzo3UvmYuCDbMP6Apd7z+ZoOXTbSbO0s8Dxr
	pdCwK60lEFguGKJ9XryC5PQb/jvd2bfLS/EGHh6M/Ta1Ace+N/Cp7E4D1ZKA2DnD6di7btBjoJR
	MrgVXQBFpal38ymky++36y8Ef1Rz0c=
X-Received: by 2002:a05:690c:4442:b0:81e:c972:e8c3 with SMTP id
 00721157ae682-81fd4ba85d1mr71180857b3.29.1785612591370;
        Sat, 01 Aug 2026 12:29:51 -0700 (PDT)
Received: from eggsbenedict (ip-74-215-254-164.dynamic.fuse.net.
 [74.215.254.164])
        by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fccf97f33sm28863607b3.21.2026.08.01.12.29.50
        for <alsa-devel@alsa-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 12:29:50 -0700 (PDT)
Date: Sat, 1 Aug 2026 15:29:49 -0400
From: Adam Stylinski <kungfujesus06@gmail.com>
To: alsa-devel@alsa-project.org
Subject: CA0132 surround issues
Message-ID: <am5JLWbU55jEVW70@eggsbenedict>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.3.3 (2026-06-12)
X-MailFrom: kungfujesus06@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: ABYJ7YOAO2TF2PKAAPZJ254LL7IKJRMT
X-Message-ID-Hash: ABYJ7YOAO2TF2PKAAPZJ254LL7IKJRMT
X-Mailman-Approved-At: Mon, 03 Aug 2026 09:36:48 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ABYJ7YOAO2TF2PKAAPZJ254LL7IKJRMT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hello,

I have an EVGA X299 Dark motherboard that has a Core3d based chip.  I use an analog 5.1 configuration and have noticed that often the surround, center, and LFE channels end up not initializing correctly when testing through speaker-test.  I went down the rabbit hole of patching the kernel module with hardcoding msleeps before ca0132_alt_select_out is called and returning early from some of the callbacks if the DSP firmware downloaded state wasn't set as DOWNLOAD_COMPLETE.  I don't suspect these things had any influence, though.  I then manually set amixer controls for these things to "off" and then back "on" again and magically they came back to life, suggesting something is happening setting up the chip's pin configuration that amixer somehow fixes.  My mixer controls were on and the volumes were set at audible levels.  I'm hoping someone here as a suggestion other than a hacky fix of just retoggling these things every time.  
