From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH 1/3] add API to allow disabling period
	interrupts
Date: Mon, 17 May 2010 18:23:23 +0900
Message-ID: <AANLkTilWrR_EQ-ma10q4DmG7ueuXuiVF25KgVEmGAocR@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<4BDABDDD.4050502@ladisch.de>
	<w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>
	<s5hsk5uq4u4.wl%tiwai@suse.de>
	<AANLkTiljN2IuWnI1g3BsVux33VcnMeCAwBZl7kexDPvU@mail.gmail.com>
	<AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>
	<4BF1086F.9070900@ladisch.de> <4BF108E9.5020705@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6D809245A6
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 11:23:24 +0200 (CEST)
Received: by vws14 with SMTP id 14so3045846vws.38
	for <alsa-devel@alsa-project.org>; Mon, 17 May 2010 02:23:23 -0700 (PDT)
In-Reply-To: <4BF108E9.5020705@ladisch.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, pl bossart <bossart.nospam@gmail.com>, General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 17, 2010 at 6:14 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
Hi,
 I am in favor of support variable hw_interrupt at lowest level, i.e, in
 ring buffer driver, instead of disabling hw_interrupt altogether.
 That would provide even more flexibility for at least future embedded
  systems that support special low-power-audio-mode involving
  long durations of audio playback while the system is in suspend mode.

 Please have a look at
  http://mailman.alsa-project.org/pipermail/alsa-devel/2010-May/027674.html
 and consider use case for embedded systems too.

Thanks.
