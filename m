Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA9EC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Oct 2022 06:05:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 88F4B36BB;
	Tue, 11 Oct 2022 08:04:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 88F4B36BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665468302;
	bh=4/l0at35d5ZpUwnD1wrDKWJwkOqrdxisFrwwbw15s3A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t8OT4IOozEXbY7/VnR9wrM+FoOZK1t1Tm6VP8+loE1zdgCBgS56wlu1PQfx5wlkvH
	 y8EcLm8E4lS1B4CVU/OEsoyy3bomFxyv+wl+n7Nvy7pZpz5csdj3B39zHM+beRYku7
	 TECowdZK7A3mdLl3Z3wIACZFWJOk2zxHtmezITOA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13764F80566;
	Tue, 11 Oct 2022 08:02:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 14B15F80256; Mon, 10 Oct 2022 18:27:12 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB184F800B8
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2022 18:27:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AB184F800B8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ZwrOrNjv"
Received: by mail-io1-xd36.google.com with SMTP id p16so3125964iod.6
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2022 09:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/l0at35d5ZpUwnD1wrDKWJwkOqrdxisFrwwbw15s3A=;
 b=ZwrOrNjv+DPNhE5Jeg4JGXLwQ6WcmyorDalyibYOWbZNNUwMZS48FmdRTvZ6Qm+aTJ
 lSNo4uf75769dCJtXPcejkJH36PLk3nQmjzKUy/W+6Uw92fJSJWWgKD8OdFOabv0t1yW
 E2C5xAWcwfR+HdgrTuPt0vwUavv8DDFv1pwnDtBK7V1uF+85mPloR0zz8zct4aqjUnNx
 +/wWv2YJ68htDxnUCgvc/AgchrlD4IEOfLRfpEa8d7WUUua00QkO86OdCb54JU2Y8Shh
 kCsbB4mLCwe8z6dVZSCvifNz4QhrZHMu0Bz+89Kq1kYdrPAc9KpOaI8d4DKM2iJCioQt
 wQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/l0at35d5ZpUwnD1wrDKWJwkOqrdxisFrwwbw15s3A=;
 b=4dV6MU6wJEvilALy9NocduPUD8RFixn7pgnFl5xZAebFui+B83WpFfa/nN4slpaGgv
 osiYW+lBxSF3wQljPC2q3QN4NO+C6G96gOWnl4slTw0k6YjQctn10gPHA8JnxGWDy5eE
 n80Spxp5hGDS7hJU7QUvZMIVcZoP6CyNlaCKdrJl6HaxzNolA3vdJ/ILdxi5IhmjjoFy
 /IZpTRN9AZfRyyeTrTzb2uDma0c/La3S4jwaQkcsucDx17xi7fYiWRH15FuZIKEuh5nn
 wDsSEErMq/iWbFgi0KTj6qQKhnEv6kE/7NAiCbeyBkekgo2HPa+8fNYpd8pvddnOKT2P
 g8nw==
X-Gm-Message-State: ACrzQf1E00qbnvaT/rtTRT+hBYBtMqyjVJOZH3hyu2wKhWeAj81igvzj
 CG02aJ5n9WBCZjYB3Sh3M72rmolZzd48c4zhCic=
X-Google-Smtp-Source: AMsMyM7bAhLwNuit40EhmKHM4albATagjiH95EZ2eAu5WNbTVC8+sEKsctBxCCsczwGXpY2l1kjFIXb/7YvCpqo27zM=
X-Received: by 2002:a05:6638:3c45:b0:363:afb2:3269 with SMTP id
 bg5-20020a0566383c4500b00363afb23269mr4242865jab.215.1665419226823; Mon, 10
 Oct 2022 09:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221008181655.2747857-1-lis8215@gmail.com>
 <Y0P/u4pJT8rup8Za@sirena.org.uk>
 <CAKNVLfZhH3s=jBWAoSppXSotY9giRRJbub9MqxCtjdZKh4fprg@mail.gmail.com>
 <Y0Q//+onKu16VQKH@sirena.org.uk>
In-Reply-To: <Y0Q//+onKu16VQKH@sirena.org.uk>
From: Siarhei Volkau <lis8215@gmail.com>
Date: Mon, 10 Oct 2022 19:26:55 +0300
Message-ID: <CAKNVLfZJuE-sPyHFQdo_PGHg5FZEUjbamJqAce+GyBCxc6xTbw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: codecs: jz4725b: Various improvements and fixes
To: Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 11 Oct 2022 08:02:21 +0200
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Paul Cercueil <paul@crapouillou.net>
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

=D0=BF=D0=BD, 10 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 18:53, Mark Brown =
<broonie@kernel.org>:
> The issue is that if someone is relying on the current behaviour and the
> control starts doing something completely different they might be
> surprised, it at least needs a separate change.

At the moment there's only one consumer for the codec in the mainline kerne=
l
Its RetroMini RS-90 and it doesn't seem to have capture capabilities.
