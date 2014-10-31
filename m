From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH 0/3] Kill the rest snd_print*() usages
Date: Fri, 31 Oct 2014 18:15:36 +0530
Message-ID: <20141031124536.GA32600@sudip-PC>
References: <1414514715-569-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 84EE52606C8
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 13:45:47 +0100 (CET)
Received: by mail-pa0-f47.google.com with SMTP id kx10so7662213pab.34
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 05:45:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1414514715-569-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 28, 2014 at 05:45:12PM +0100, Takashi Iwai wrote:
> Hi,
> 
> it's a small series to get rid of snd_print*() usages in a few
> PCI sound drivers.  There remain still a few, I know, but this is
> just a matter of cleanup, so let them be there...

hi,
still there is approx. 723 usages of snd_printk (including snd_printk in comments),
and including 46 in PCI.
shall i do the cleanups for you ?

thanks
sudip


> 
>  [PATCH 1/3] ALSA: ctxfi: Kill the rest snd_print*()
>  [PATCH 2/3] ALSA: pcxhr: Kill the rest snd_print*()
>  [PATCH 3/3] ALSA: au88x0: Kill the rest snd_print*()
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
