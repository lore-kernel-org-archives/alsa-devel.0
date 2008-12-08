From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [patch] alsa-utils check if __USE_BSD is defined
 before compiling "BSD functions"
Date: Mon, 8 Dec 2008 08:48:48 +0100
Message-ID: <20081208084848.51dd7906@hcegtvedt>
References: <20081208072602.3b20cb50@hcegtvedt> <s5hfxkzp1b4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.atmel.no (nat-132.atmel.no [80.232.32.132])
	by alsa0.perex.cz (Postfix) with ESMTP id 75A2410381B
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 08:48:50 +0100 (CET)
In-Reply-To: <s5hfxkzp1b4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 08 Dec 2008 08:34:55 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 8 Dec 2008 07:26:02 +0100,
> Hans-Christian Egtvedt wrote:
> > 
> > Hi,
> > 
> > Another bug/issue I tripped over when compiling alsa-utils in an
> > environment using uClibc to supply the C library functions. Here I
> > have enabled some old BSD style functions. The attached patch will
> > honor them if they are enabled.
> > 
> > Without this patch I get a redefined error during compile.
> 
> Hmm, but with this patch, I get undefined reference errors :)
>     alsactl/init_sysfs.c:39: undefined reference to `strlcpy'
>     ....
> 
> Checking __USB_BSD seems insufficient, unfortunately.
> 

Perhaps it should be UCLIBC specific? Something like
"&& !(defined(__UCLIBC__) && defined(__USE_BSD))"

-- 
Best regards,
Hans-Christian Egtvedt
