From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] sscape: driver extension to 2nd DMA and
 WSS port
Date: Mon, 17 Sep 2007 14:23:59 +0200
Message-ID: <20070917142359.71007011.krzysztof.h1@gmail.com>
References: <20070916105127.c6848e41.krzysztof.h1@gmail.com>
	<s5hvea9eesp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 591B9103867
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 14:16:41 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so989724nfd
	for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2007 05:16:40 -0700 (PDT)
In-Reply-To: <s5hvea9eesp.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Chris Rankin <rankincj@yahoo.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 17 Sep 2007 13:01:42 +0200
Takashi Iwai <tiwai@suse.de> wrote:


> I reject your patch not because of coding style but it changes the
> existing module option :-)
> 
> Can you keep the option dma and just add dma2?

Yes, of course.

> 
> Also, you changed the initialization of port[].  Any reason?  Is the
> current code broken in that way?
> 
No, the code is not broken. The changed way is exactly the same but shorter.
>From the sound/initval.h:

#define SNDRV_DEFAULT_PORT      { [0 ... (SNDRV_CARDS-1)] = SNDRV_AUTO_PORT }

I can leave old initialization if you prefer.

Regards,
Krzysztof
