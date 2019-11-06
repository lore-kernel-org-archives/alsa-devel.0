Return-Path: <SRS0=zQEr=Y6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D955C5DF62
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 03:10:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90BC6217F4
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 03:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Um0F/Wux";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="gC5lHlvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BC6217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9010B16E3;
	Wed,  6 Nov 2019 04:09:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9010B16E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573009842;
	bh=slCPJrv5ahWwU00+9Fkr6K+Jx+5kInHzNvL4LzW8DUg=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Um0F/Wux64Rl6ZOuGUQP/cPvaMv11cB0CBUlbUwbM5VTiqqFTkB7GSmGJOFy4w+iq
	 HcHu8aaQ/uTROpJoEJCwEjqSDAltahZK4Cxfmt6Cf5T3wgbcsFkAVJGJzru3//xHJz
	 TkcnVYBHjFB4sfkaZ36S5DVPvlaR7nKCp7S5QDIo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 199F9F80321;
	Wed,  6 Nov 2019 04:09:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B4BC9F803D0; Wed,  6 Nov 2019 04:09:50 +0100 (CET)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F1F89F80291
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2019 04:09:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1F89F80291
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="gC5lHlvE"
Received: by mail-il1-x144.google.com with SMTP id r9so3740707ilq.10
 for <alsa-devel@alsa-project.org>; Tue, 05 Nov 2019 19:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kLn1z29UwM1hwoH8EX5/MCYgepnN6kJ+9iQmSZNa/TQ=;
 b=gC5lHlvEg9tNQ+vdTbUXL9AUEeEvjEAH14FfZ8yrr8V03AusoHq8SloRWYmNTkmOfZ
 rQN1VvryFDedYaciVAtfrH3kNUyrb4zhZbi7HGOG/uJIz7mLQrViQ26/IOsWcZb7eoCy
 XRCwn4mVGv0WQjQ4tuHMhejbaHkbQhNt/PC+LKj05oqrPO7+v1qN6Cq3obuDj47NhKyP
 zcHHQ9PHPFgEAz+XfiEfrC/3LIpul9/353p0U7MkPTdI3qamikEo66Mui9Jw4xAOdwhS
 yhbyBMv8E5lFBUkpOFcegyO3tbXPP8z5+samfLnJPmU4G1RNkp1kltTOFFIJn2Zg/6zN
 PyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kLn1z29UwM1hwoH8EX5/MCYgepnN6kJ+9iQmSZNa/TQ=;
 b=Wamk77Tkq/zuglUZ0Vij1YAA5bjScvvALEBv5aNIBe9fy1J1tLew/gBSS5a8pWYiDw
 Si8A7heaGXEAQdMexftC6mb6YvlNyN1cFjN3zh+n3Cnn9mXkEwkXJMMiMtG2Xl7J4AhH
 0/OKQI1xr0TLHfjrUdaiYzlpyspfEVL5cETm/9Y6ISyQwFTXz99OKgjFMBOMyAjryWT5
 6jTDkElWI/zhrPKfTAiXxD7hEGMjIkR3CF1idPTiQtIS4+ooZWzb+ehDAx7fkeXITJYn
 OBzao2k1CL0sahfSk4kQ4NMlcJCF+1y2W7mYluua4ipFIiZKGTkH7FkCg6gHsAmyzfC8
 I5fA==
X-Gm-Message-State: APjAAAW+rFERriLd5kY8sXNvZvis3ucp7mhF3VSyugpRBPODeLoduPUN
 IOxpOKholS5oAu6cDv1ws+xXQKMp3jK6sbP75+aXdA==
X-Google-Smtp-Source: APXvYqxduT7mWjoIdS0AvkDBtchw/GmTrGC2w0KBoaGFLXku4Om/m05pY3Hn4cjtYLp6SrbJqWLFJWMG41JruFrnZhw=
X-Received: by 2002:a92:109c:: with SMTP id 28mr349266ilq.142.1573009785163;
 Tue, 05 Nov 2019 19:09:45 -0800 (PST)
MIME-Version: 1.0
References: <87wocdhkz6.wl-kuninori.morimoto.gx@renesas.com>
 <87k18dhkw2.wl-kuninori.morimoto.gx@renesas.com>
 <CAFQqKeW9ZuUcGFkjw30q-CuBfWtnDoBB_UsmjFCdBPPS78nZrg@mail.gmail.com>
 <87ftj1hgly.wl-kuninori.morimoto.gx@renesas.com>
 <CAFQqKeXx9rXj3b0monvJ6CrBj9B0YCzwcAUc2SH7ya9yb9mjnA@mail.gmail.com>
 <87eeylhfw9.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87eeylhfw9.wl-kuninori.morimoto.gx@renesas.com>
From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Date: Tue, 5 Nov 2019 19:09:39 -0800
Message-ID: <CAFQqKeW8d7KY=Wmau2wnGdH0MO0n4N7RskiLAA8RzjeRGe6ygw@mail.gmail.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 9/9] ASoC: soc-core: call
 snd_soc_dapm_shutdown() at soc_cleanup_card_resources()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, Nov 5, 2019 at 6:56 PM Kuninori Morimoto <
kuninori.morimoto.gx@renesas.com> wrote:

>
> Hi Ranjani
>
> Thank you for your feedback
>
> >     Do you mean [7/9] patch ?
> >     It merges snd_soc_instantiate_card() and snd_soc_bind_card().
> >     Thus, snd_soc_bind_card() is still exist.
> >     Or am I misunderstanding ?
> >
> > Oh yes, sorry I misread that. So why not remove cleanup_card_resources
> and move everything to snd_soc_unbind_card()?
>
> Good question :)
>
> Indeed snd_soc_bind_card() and snd_soc_unbind_card() are paired function.
> We want to merge cleanup_card_resources() and snd_soc_unbind_card().
> But, can you check snd_soc_unbind_card() ?
> unbind() is caring
>         - card->instantiated
>         - snd_soc_flush_all_delayed_work(card);
>         - unbind_card_list
>
> Actually I tried to merge cleanup() and unbind() into one,
> but then, the code became not simple.
> So I gave up this time.
> But, we might can do it in the future if soc-core is more
> cleanuped/simpled.
>
OK, makes sense. In that case, this series looks good to go.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

>
> Thank you for your help !!
> Best regards
> ---
> Kuninori Morimoto
>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
