From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/3] ALSA: USB-descriptor endianess fixes
Date: Fri, 12 May 2017 14:16:33 +0200
Message-ID: <20170512121633.GR30445@localhost>
References: <20170512102821.2630-1-johan@kernel.org>
 <s5h37cafhmv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 06EFC266A38
 for <alsa-devel@alsa-project.org>; Fri, 12 May 2017 14:16:39 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id y10so13572717wmh.0
 for <alsa-devel@alsa-project.org>; Fri, 12 May 2017 05:16:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5h37cafhmv.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Johan Hovold <johan@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 12, 2017 at 01:18:16PM +0200, Takashi Iwai wrote:
> On Fri, 12 May 2017 12:28:18 +0200,
> Johan Hovold wrote:
> > 
> > These patches add missing endianness conversions when accessing the USB
> > device-descriptor fields. In the process, clean up the us122l driver
> > which had product-id conditionals sprinkled throughout.
> > 
> > The final patch drops the Kconfig dependency on x86 since it's a USB
> > driver that compiles just fine on non-x86. Perhaps this should be a
> > (X86 || COMPILE_TEST) dependency instead in case there are external
> > dependencies that warrants this limitation.
> 
> Yeah, I vaguely remember that the driver is specific to x86 because of
> its particular usage of mmap.  Maybe some other architectures may
> match, but not all.  So, X86 || COMPILE_TEST would be more sensible.

Thanks for clarifying. I'll respin in a v2.

Johan
