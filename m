From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH] ASoC AC97 device reg bugfix
Date: Fri, 11 May 2007 07:02:50 +0200
Message-ID: <20070511050250.GA14711@roarinelk.homelinux.net>
References: <1178814513.10518.127.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil48.netpark.at
	[217.175.205.176])
	by alsa0.perex.cz (Postfix) with ESMTP id DF18424449
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 07:02:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1178814513.10518.127.camel@a10072.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 10, 2007 at 05:28:33PM +0100, Liam Girdwood wrote:
> This patch fixes a bug whereby AC97 bus device data was being clobbered
> when AC97 codecs using the generic ac97_codec.c driver were being
> registered. Codecs that didn't use the generic driver were unaffected
> (e.g. WM9712, WM9713).
> 
> Changes:-

> This may be related to bug #3038 :-
>  
> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3038
> 
> Manuel, can you try this on SH & Au1x00.

Yes, its fixed on both, thank you very much!

	Manuel Lauss
