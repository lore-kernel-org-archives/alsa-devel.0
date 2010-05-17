From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: [PATCH 2/3] ALSA: hda-intel: add support for
	disabling period irq
Date: Mon, 17 May 2010 09:05:38 -0500
Message-ID: <AANLkTimyYbvWckeEwzYvGI9OTEDa2I-gc4MDgndden-m@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<4BDABDDD.4050502@ladisch.de>
	<w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>
	<s5hsk5uq4u4.wl%tiwai@suse.de>
	<AANLkTiljN2IuWnI1g3BsVux33VcnMeCAwBZl7kexDPvU@mail.gmail.com>
	<AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>
	<4BF1086F.9070900@ladisch.de> <4BF10909.3070003@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F3FA24676
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 16:06:28 +0200 (CEST)
Received: by iwn1 with SMTP id 1so379411iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 17 May 2010 07:06:27 -0700 (PDT)
In-Reply-To: <4BF10909.3070003@ladisch.de>
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

Pretty much the same code as mine. How many ways can one find to
program a bit...
We may want to keep a module parameter to disable this functionality
for debug purposes,same for adding a trace message shall an interrupt
still happen.
