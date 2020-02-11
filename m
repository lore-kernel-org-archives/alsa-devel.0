Return-Path: <SRS0=kaO4=37=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C9CC35242
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 05:43:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3C82070A
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Feb 2020 05:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C016FNz7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqdrGlbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3C82070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3E06165D;
	Tue, 11 Feb 2020 06:42:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3E06165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581399778;
	bh=Itx1V7SLqT5d21UNTns2qnb/OKbUXQD77bUYjPtgvjs=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C016FNz7/m52QuLLc2fqkZff9xcMAMNCe8whJ2kG03SN1KReF1hIBIMjEMYEF9XvH
	 /3HNDvMazA7hSlVroqW+2+tHWaZyQyOkIYxfAaRvAVy46Fcq1WlSnz6qdYw3Uzap3c
	 gePJDm4vjzWvN5tpz5VPgBhnE2oFzgNYk52tFOs0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0AC29F8013E;
	Tue, 11 Feb 2020 06:42:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E7E3F80145; Tue, 11 Feb 2020 06:42:03 +0100 (CET)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E0336F8013D
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2020 06:41:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E0336F8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="RqdrGlbr"
Received: by mail-pf1-x441.google.com with SMTP id j9so4905122pfa.8
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 21:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UDKlGelLJeUF6pD+P3omj2I8PEga/Mg93lEF6QxZWw0=;
 b=RqdrGlbr0LGUnHSM/8lY8oSSxCzJQZsFCAPBQiQ7ly3Se2RpfQkhNqvCU8xXkZW8vy
 zbx4oCyrY4peXVIlCW/1gPd8ZiLs39xl9Elp9aT/Bxn0SvkWhz4f+cEF1Gbd0sb7wEKZ
 POs0n6Ip2AAX0eZzGKuEoijRabh2BHgjkJXHX0iriPNB7hSjXKPy62S2BYiFod8epfjq
 Z2+4aRLJPJuidAJzLJyNtWyLudNrRwaU7mhm2yUsempgKT7HTm37DtEhcXe68GHfP90Q
 gPC3uQW9+kYInGezObQ8SQpensq8bepzVwkzaUKQo9WVUwVlTKgVSEEKEN2b0wI259hG
 HiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UDKlGelLJeUF6pD+P3omj2I8PEga/Mg93lEF6QxZWw0=;
 b=o0a1yUtMTMlXz3NDam+1fFZTV4MvZK9clx0Cp5YSLCcm0mKi+fzFfLuSMjQwy3Lwr2
 Y6jNu5Wh9ja+JdXoD8Ni/uBqiyDHPsT5qeociD+MOZozL2MburISczHlhYtJIQuQr633
 XqO8AAe702GZpJA2bHpxlzEexKMGFKYwda+TsgOYYSvpI3MVG9V7bE3WRn5EL+jzgnh5
 s3Ri3+fzVuwp5ZO//1RkXSzQGJ5kLrhW8zOMFiUvKJJg9Hk/jo24DxGof7eNqhC1QfUV
 AhtoJrw1FpR6iGnNmz4oEB+lIQlhibXZy4bQPzP96pbM7IJszg4u2hANBKQ27dw4d2BK
 gmYQ==
X-Gm-Message-State: APjAAAVareY2DfvycOB1+gBzobDhZnyGb8lDIvvGYgNPnI0Dlw8x65AY
 Jq4Z5kInebueJe2XATy8FOc=
X-Google-Smtp-Source: APXvYqy36smb8HxKIZqu3n/yLetntJKQtJdPfuo66eolw1quD7u8rRCiiMCDIXCfU5pypqd2IRuppg==
X-Received: by 2002:a63:480f:: with SMTP id v15mr5094564pga.201.1581399715276; 
 Mon, 10 Feb 2020 21:41:55 -0800 (PST)
Received: from f3 (ag119225.dynamic.ppp.asahi-net.or.jp. [157.107.119.225])
 by smtp.gmail.com with ESMTPSA id l21sm1976693pgo.33.2020.02.10.21.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 21:41:54 -0800 (PST)
Date: Tue, 11 Feb 2020 14:41:50 +0900
From: Benjamin Poirier <benjamin.poirier@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>
Message-ID: <20200211054150.GA3119@f3>
References: <20191129144027.14765-1-perex@perex.cz> <20200210025249.GA2700@f3>
 <20200210030416.GA3302@f3>
 <b31f7280948d4cff91ab5dfcd1e14024@realtek.com>
 <20200210121450.GA3072@f3>
 <026068c1-7189-762f-d0e7-16ef08a9de3d@perex.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <026068c1-7189-762f-d0e7-16ef08a9de3d@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>, Kailang <kailang@realtek.com>
Subject: Re: [alsa-devel] [PATCH] ALSA: hda - fixup for the bass speaker on
 Lenovo Carbon X1 7th gen
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

On 2020/02/10 13:54 +0100, Jaroslav Kysela wrote:
> Dne 10. 02. 20 v 13:14 Benjamin Poirier napsal(a):
[...]
> > 
> > Here's the relevant part of Node 0x17 from /proc/asound/card0/codec#0
> > with different quirks applied and the level of sound output through the
> > speakers:
> > 
> > no quirk
> >    Connection: 3
> >       0x02 0x03 0x06*
> >    -> loud volume
> > ALC285_FIXUP_SPEAKER2_TO_DAC1
> >    Connection: 3
> >       0x02* 0x03 0x06
> >    In-driver Connection: 1
> >       0x02
> >    -> weak volume
> > ALC295_FIXUP_DISABLE_DAC3
> >    Connection: 3
> >       0x02 0x03* 0x06
> >    In-driver Connection: 2
> >       0x02 0x03
> >    -> loud volume
> 
> Kailang, what's the difference between nodes 0x02 and 0x03 for this codec?
> Or the DACs are setup differently?
> 
> The problem with those Realtek codecs is that they have many "hidden"
> functions controlled by the undocumented registers.
> 
> I have not tested 0x03. Also, both pair of stereo speakers should be
> connected to one DAC for X1 otherwise we will lose the volume control.

Thanks for your reply, however, that statement is incorrect.

The bass speakers don't need to be connected to the same DAC as the
front speakers. In fact, I found that it's better to connect them to
different DACs: that gives louder max volume and that also gives
individual control for front and bass speakers. But it has to be the
right DACs: 0x02 and 0x03, not 0x02 and 0x06!

As I wrote in my first mail in this thread,
> Applying the following diff brings the volume back to previous levels
> and brings functional volume control:
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I'm not suggesting to simply revert commit d2cd795c4ece ("ALSA: hda -
fixup for the bass speaker on Lenovo Carbon X1 7th gen"), I'm suggesting
to use a different quirk.

I went back and collected detailed observations regarding the mixer
controls with each quirk.
pavucontrol controls are reported with the device configured with the
"Analog Surround 4.0 Output" profile.

no quirk
	-> Loud max output volume
	DAC connection
	  Connection: 3
	     0x02 0x03 0x06*
	Controls in alsamixer
		Master controls front speakers only.
		Speaker controls front speakers only.
		Bass Speaker is a toggle that mutes everything.
		PCM controls all speakers.
		There is no "Front" mixer.
	Controls in pavucontrol
		"Front Left"/"Front Right" sliders work as expected.
		"Rear Left"/"Rear Right" sliders seem to operate in a
		non-linear fashion such that most values above 0% result in
		max volume output. This is probably linked to the fact
		that "Bass Speaker" is just a toggle in alsamixer.
		-> Because the bass speakers (Rear) are more powerful, the
		net effect is that when the channels are linked into a
		single slider, it seems like it has just two modes: mute or
		max.
ALC285_FIXUP_SPEAKER2_TO_DAC1
	-> Weak (~60%) max output volume
	DAC connection
	  Connection: 3
	     0x02* 0x03 0x06
	  In-driver Connection: 1
	     0x02
	Controls in alsamixer
		Master controls all four speakers.
		Speaker controls all four speakers.
		Bass Speaker is a toggle that mutes everything.
		PCM controls all four speakers.
		There is no "Front" mixer.
	Controls in pavucontrol
		"Front Left"/"Front Right" sliders have no effect.
		"Rear Left"/"Rear Right" sliders control both front and
		bass speakers.
		-> Volume control is effective but it's not possible to
		control front and bass speakers individually.
ALC295_FIXUP_DISABLE_DAC3
	-> Loud max output volume
	DAC connection
	  Connection: 3
	     0x02 0x03* 0x06
	  In-driver Connection: 2
	     0x02 0x03
	Controls in alsamixer
		Master controls all speakers.
		Speaker is a toggle that mutes everything.
		Bass Speaker controls bass speakers only.
		PCM controls all speakers.
		Front controls front speakers only.
	Controls in pavucontrol
		"Front Left"/"Front Right" sliders control front speakers
		only.
		"Rear Left"/"Rear Right" sliders control bass speakers
		only.
		-> Volume control is effective and it's possible to control
		each of the four speakers individually.

In summary, ALC295_FIXUP_DISABLE_DAC3 offers the loudest max volume and the
most detailed mixer controls. I'll send patches shortly.

Another interesting fact that I found while looking more into this is
that the Audio device PCI SSID on the Carbon is 0x2292 but the codec
SSID is 0x2293!

If you have access to an X1 7th gen of some sort (Carbon or Yoga),
please post `dmidecode -t system`, `lspci -vnn` and the content of
"/proc/asound/card0/codec#0" so that we can better compare in case of
different behavior.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
