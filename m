Return-Path: <SRS0=heU4=AM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FD8C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 08:01:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980DE2073E
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2020 08:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LiAs043v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980DE2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 203B31670;
	Wed,  1 Jul 2020 10:00:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 203B31670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593590476;
	bh=PnSaX/ukWzKH5s2Ahrkx4P0DGNSwYlvxYMPcLyH4PvM=;
	h=Subject:From:In-Reply-To:Date:References:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LiAs043vNReziWNEhvHwOrYS9ISbdlWz+v+IOtQp1FO8ClOtAtPmfXjYNjhC3sVdR
	 7SkwcrVgwFlhM8CZHYVDinQA2Zov/cNDLg2MCJqKnKAfnErVmGzQKfrG73FYhV6ZEx
	 PlWN/6axvxrOn/m6s4bSAkBKKIZZ4nAbobAUX0Ew=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B556F8020C;
	Wed,  1 Jul 2020 10:00:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A332DF80217; Wed,  1 Jul 2020 10:00:24 +0200 (CEST)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3184EF801D8
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2020 10:00:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3184EF801D8
Received: from mail-pj1-f70.google.com ([209.85.216.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1jqXfD-0007Fo-Oh
 for alsa-devel@alsa-project.org; Wed, 01 Jul 2020 08:00:16 +0000
Received: by mail-pj1-f70.google.com with SMTP id b6so5026163pjw.1
 for <alsa-devel@alsa-project.org>; Wed, 01 Jul 2020 01:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=GW8JJBP3OeAvfZkkdI4iX3hRICxg+YUixnYmOzaJcjw=;
 b=GrUFgzEjT7xvg4eJU3BZ7/kG+gW1b19LV7gktDtqBL6kBde6tCLA9smKTGkJM5kH5e
 SeAsVfvY7EK3KRPP9hyNaJ/q515BAB+Q2WxDsi9i1to8UQiABehdudLQdjSGXFjkUDDr
 w+l1+DoPitJ202tkVaFu63lvODjKmCVaz7cLOq7aN/2s2RHo8YcseOYe+WgiIqAG/jM/
 9dwtn9kLK6KgHYk6JdQmppeemkLMNlGDiL2bso4Y4MrH8fpJ/YFoS0mt5z9KYFZPsyEZ
 3lI22O76sO+RVObwDSFGFuqSiw1pIJyezt3jw+GFO0bGl9SM2Hd98yHuCggMdsmAe5DL
 BXBg==
X-Gm-Message-State: AOAM533khpKJThOw4HyLRNv34SRI+xuQZcwEJ472/hFJX8O8izlvrjlz
 cEBAVIYNj0BOe7q+U/gECAoW/QxfRig+dSqQoeqyPTKhASJegQx2JwJHRijn6hTw/vVwQetDi8T
 6g1iU2sMDwUgbPIIjvf8822MhV0Udkp6EMY4gyvBX
X-Received: by 2002:a17:902:e783:: with SMTP id
 cp3mr19843386plb.265.1593590414207; 
 Wed, 01 Jul 2020 01:00:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzV9agnsbKTHGvuQxcOeClpZMX08uYZcbhTp02OKxPn8O8KgWPCKecHkc6BCE5uO690zdpcfw==
X-Received: by 2002:a17:902:e783:: with SMTP id
 cp3mr19843335plb.265.1593590413720; 
 Wed, 01 Jul 2020 01:00:13 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net.
 [220.133.187.190])
 by smtp.gmail.com with ESMTPSA id b10sm4915172pft.59.2020.07.01.01.00.10
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Jul 2020 01:00:13 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] ALSA: hda/realtek: Serialize setting GPIO LED
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hh7urg2bh.wl-tiwai@suse.de>
Date: Wed, 1 Jul 2020 16:00:09 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <2A526AAE-1F25-44DB-8078-1E1A585B8629@canonical.com>
References: <20200701052138.6378-1-kai.heng.feng@canonical.com>
 <s5hh7urg2bh.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Cc: Libin Yang <libin.yang@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 Kailang Yang <kailang@realtek.com>, Tomas Espeleta <tomas.espeleta@gmail.com>,
 Thomas Hebb <tommyhebb@gmail.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 open list <linux-kernel@vger.kernel.org>, tiwai@suse.com,
 Hui Wang <hui.wang@canonical.com>, anthony.won@canonical.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Jian-Hong Pan <jian-hong@endlessm.com>,
 =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
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



> On Jul 1, 2020, at 14:46, Takashi Iwai <tiwai@suse.de> wrote:
>=20
> On Wed, 01 Jul 2020 07:21:35 +0200,
> Kai-Heng Feng wrote:
>>=20
>> If a system has two GPIO controlled LED, one for mute and another one
>> for micmute, and both of them are on before system suspend, sometimes
>> one of them won't be turned off by system suspend.
>>=20
>> The codec doesn't seem to be able to control multiple GPIO LEDs at =
the
>> same time, so introduce a new mutex to serialize setting the LED, to
>> prevent the issue from happening.
>>=20
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> include/sound/hda_codec.h     | 1 +
>> sound/pci/hda/hda_codec.c     | 1 +
>> sound/pci/hda/patch_realtek.c | 3 +++
>> 3 files changed, 5 insertions(+)
>>=20
>> diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
>> index d16a4229209b..3a1792bbb7ac 100644
>> --- a/include/sound/hda_codec.h
>> +++ b/include/sound/hda_codec.h
>> @@ -206,6 +206,7 @@ struct hda_codec {
>>=20
>> 	struct mutex spdif_mutex;
>> 	struct mutex control_mutex;
>> +	struct mutex led_mutex;
>=20
> Since it's only for Realtek codec, can it be better in alc_spec
> instead?

Ok, I found that the mutex just papers over the real issue.

The root cause is that led_set_brightness_nopm() use schedule_work() but =
the work queue doesn't gets flushed.
I'll fix it there properly.

Kai-Heng

>=20
>=20
> thanks,
>=20
> Takashi

