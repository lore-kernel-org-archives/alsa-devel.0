From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/3] add API to allow disabling period
	interrupts
Date: Mon, 17 May 2010 13:16:35 +0200
Message-ID: <4BF12593.3040001@ladisch.de>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>	
	<4BDABDDD.4050502@ladisch.de>	
	<w2s6160a5131004300644o3aedd30bvf0d13a7f9e758575@mail.gmail.com>	
	<s5hsk5uq4u4.wl%tiwai@suse.de>	
	<AANLkTiljN2IuWnI1g3BsVux33VcnMeCAwBZl7kexDPvU@mail.gmail.com>	
	<AANLkTil6ftaJ_wC--Tsq4pxPDAg9zmISstHuTvCWc_pk@mail.gmail.com>	
	<4BF1086F.9070900@ladisch.de> <4BF108E9.5020705@ladisch.de>
	<AANLkTilWrR_EQ-ma10q4DmG7ueuXuiVF25KgVEmGAocR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 118052437C
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 13:16:50 +0200 (CEST)
In-Reply-To: <AANLkTilWrR_EQ-ma10q4DmG7ueuXuiVF25KgVEmGAocR@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, pl bossart <bossart.nospam@gmail.com>, General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jassi Brar wrote:
> I am in favor of support variable hw_interrupt at lowest level, i.e, in
> ring buffer driver, instead of disabling hw_interrupt altogether.

Removing the constant-sized periods restriction would certainly be
useful.  However, it doesn't look as if anybody has the time to redesign
the ALSA API, the kernel framework and all the drivers.


Regards,
Clemens
