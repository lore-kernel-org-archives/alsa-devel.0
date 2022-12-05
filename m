Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B693C4321E
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Dec 2022 12:01:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8CD717C5;
	Mon,  5 Dec 2022 13:00:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8CD717C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1670241659;
	bh=75IouI0d6V8qhVhkCN2YvyRt2dfvvA79eQJUblCNSBU=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J7VO03BK1ZfVgpcl3DBESKNjs1uYU/uks4ZHwAWceF9xnGutn6bUaPDdaonMnmjb3
	 BKyy7wgJF9Xh/iaWVjChVffiLS0VH6vPKhpDLc/0hzm93MMz2XMzgYFB8eLxJ41604
	 jRptan3tKu3KmPOoNxIBgY/tyP9Jb33sh1kyjxhc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86FCBF80171;
	Mon,  5 Dec 2022 13:00:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 031D9F80236; Mon,  5 Dec 2022 13:00:07 +0100 (CET)
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E1E0F80155
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2022 13:00:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E1E0F80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=carlh.net header.i=@carlh.net
 header.b="OouIHYIt"
Received: from [164.90.213.35] (helo=main.carlh.net)
 by smtp.hosts.co.uk with esmtpsa (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim) (envelope-from <unknown@carlh.net>) id 1p2A8Z-00010V-Ca;
 Mon, 05 Dec 2022 11:59:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=carlh.net; 
 s=rsa1;
 h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:Subject
 :cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j3ynAU40H5bbN4+ZZfNYcgEo52c8Wi3SA5Gx5kNdc74=; b=OouIHYItFJUg7aLUvO6P6rSrOO
 4t63kITGv4G/FqRJSQe7ctszbZNVMf3uM2IH8k4rVIuawloQ749rpgU2qoJT8QP/gWziBenxh+cC3
 inzN4Q4ZweGAuAnU+5SlkK2J51FgkaJ4ZOSaCLJw6iaAJ29IfvfT2YsWIW3jTOwXRM2lQrT3bDHsg
 olkMVFHuTZc/2uTIkZ2BDrjj5HCk4pDx6KLhWaoHrm2tAWjSj6nmRWtpe4Y3oY5MW0OlPFPaa171/
 LCJ/yxlA111KXJXJTnU9YINbtMynm3P1Lgdp833KM/qLLSeTvFD/eqvZASVAonOoCL0G3D3w0Rx9k
 r6F6JbNA==;
Received: from carl (helo=localhost)
 by main.carlh.net with local-esmtp (Exim 4.94.2)
 (envelope-from <unknown@carlh.net>)
 id 1p2A8Y-0069IV-AQ; Mon, 05 Dec 2022 11:59:54 +0000
Date: Mon, 5 Dec 2022 11:59:54 +0000 (GMT)
From: Carl Hetherington <lists@carlh.net>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: Query about xrun on usb/pcm
In-Reply-To: <87cz93o9ab.wl-tiwai@suse.de>
Message-ID: <656d9d2-a0ec-7a3-394c-7a84b17afa11@carlh.net>
References: <b4e71631-4a94-613-27b2-fb595792630@carlh.net>
 <87y1s3v4ba.wl-tiwai@suse.de> <e830ee7b-e79e-54fb-a2ca-ffffd777b3f@carlh.net>
 <87edtv6pi6.wl-tiwai@suse.de> <baa6589-184f-6751-71be-1d5d67f8a6d5@carlh.net>
 <87fse2qk51.wl-tiwai@suse.de>
 <18aa8f93-92c7-eea-101f-8982292b6e18@carlh.net> <87cz93o9ab.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam_score: -1.9
X-Spam_bar: -
Cc: alsa-devel@alsa-project.org
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

Hi Takashi,

> > Can you see any problems with that?  In the application code I do need
> > to re-try the snd_pcm_prepare() if one fails with -EPIPE, but with this
> > undo step the second snd_pcm_prepare() is able to recover the endpoint
> > states, instead of hitting this problem where it tries to start things
> > that are STOPPING, but also won't set things to STOPPED because
> > stop_operating is false.
>
> Setting the stop_operating unconditionally there doesn't look right,
> as there may be other error types not only the pending XRUN.
>
> The problem is rather specific to USB audio driver that tries to start
> the stream at PCM prepare, so it's better to handle in USB audio
> driver itself.  That is, when -EPIPE is returned from
> start_endpoints() at prepare, the driver does some action.
>
> I can see two options:
> - Issue snd_pcm_stop_xrun() when start_endpoints() returns -EPIPE
> - Repeat the prepare after the sync at snd_usb_pcm_prepare()
>
> The former would require a bit of change in snd_pcm_stop_xrun(), and
> it relies on the application retrying the prepare.  The latter would
> be more self-contained.  I attached two patches (totally untested) for
> both scenarios.
>
> My gut feeling is for the latter solution, but this needs
> verification.

The latter solution seems to fix our problem perfectly!  Thank you so
much!

Is there anything I can/should do to help get the change merged?

Kind regards,
Carl
