From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH 2/4] alsa-kernel: schedule_timeout() fix
	for kernel/drivers/input/touchscreen/ucb1400_ts.c
Date: Tue, 18 Sep 2007 15:58:46 +0200
Message-ID: <46EFD996.6050702@gmail.com>
References: <46E58D01.9080809@gmail.com>	<Pine.LNX.4.58.0709170325380.27377@shell4.speakeasy.net>	<46EF18FF.7070906@gmail.com>	<46EF3097.7060300@gmail.com>	<46EF52E4.90401@gmail.com>	<s5habrkchpa.wl%tiwai@suse.de>	<46EFD769.3010503@gmail.com>
	<s5hwsuo9itg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id DAF5A244D7
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Sep 2007 15:59:46 +0200 (CEST)
In-Reply-To: <s5hwsuo9itg.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Krzysztof Helt <krzysztof.h1@gmail.com>, ALSA devel <alsa-devel@alsa-project.org>, Trent Piepho <xyzzy@speakeasy.org>
List-Id: alsa-devel@alsa-project.org

On 09/18/2007 03:58 PM, Takashi Iwai wrote:

> At Tue, 18 Sep 2007 15:49:29 +0200,
> Rene Herman wrote:

>> Only split of from the rest since I'm not in fact sure what/why that 
>> drivers/input stuff is inside alsa-kernel.
> 
> This code is in ALSA HG tree just because it refers AC97 interface.
> When the ac97 side is changed, we might need to touch it.
> 
> But, this change has nothing to do with the sound, so I think it'd be
> better to pass it to the input subsystem maintainer.

Will do, thanks.

Rene.
