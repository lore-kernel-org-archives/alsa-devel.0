From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Mon, 17 May 2010 09:17:57 -0500
Message-ID: <AANLkTin5uIghRtk0yBzwyFd5-4eQMxwEp4t-6b-0Z_FJ@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<4BDABDDD.4050502@ladisch.de>
	<w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>
	<s5hsk5uq4u4.wl%tiwai@suse.de>
	<AANLkTiljN2IuWnI1g3BsVux33VcnMeCAwBZl7kexDPvU@mail.gmail.com>
	<AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>
	<4BF1086F.9070900@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f176.google.com (mail-yw0-f176.google.com
	[209.85.211.176])
	by alsa0.perex.cz (Postfix) with ESMTP id E1DBB24681
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 16:18:01 +0200 (CEST)
Received: by ywh6 with SMTP id 6so2491927ywh.16
	for <alsa-devel@alsa-project.org>; Mon, 17 May 2010 07:18:01 -0700 (PDT)
In-Reply-To: <4BF1086F.9070900@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Instead of a new field in snd_pcm_hardware, you should better use a new
> flag so that userspace also knows about this capability.

Yes this is much better indeed.
