From: gregkh <gregkh@linuxfoundation.org>
Subject: Re: stable-rc build: 9 warnings 0 failures
 (stable-rc/v3.18.75-20-g4ffe554)
Date: Tue, 17 Oct 2017 16:08:22 +0200
Message-ID: <20171017140822.GB1486@kroah.com>
References: <59e5d9f0.4465630a.ed9cc.22c2@mx.google.com>
 <CAK8P3a3jKcZhU4Ly0Fd4nLeZm4re0FLKdKK6=Ht4ZPsh6JDm2A@mail.gmail.com>
 <s5hinfevswy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by alsa0.perex.cz (Postfix) with ESMTP id CDDA4266DA4
 for <alsa-devel@alsa-project.org>; Tue, 17 Oct 2017 16:08:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hinfevswy.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Kernel Build Reports Mailman List <kernel-build-reports@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Olof's autobuilder <build@lixom.net>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 17, 2017 at 02:51:41PM +0200, Takashi Iwai wrote:
> On Tue, 17 Oct 2017 14:46:53 +0200,
> Arnd Bergmann wrote:
> > 
> > On Tue, Oct 17, 2017 at 12:22 PM, Olof's autobuilder <build@lixom.net> wrote:
> > > Warnings:
> > >
> > >       9 sound/usb/mixer.c:2161:27: warning: passing argument 1 of 'snd_usb_mixer_disconnect' from incompatible pointer type [-Wincompatible-pointer-types]
> > 
> > This broke after backporting 124751d5e63c ("ALSA: usb-audio: Kill stray
> > URB at exiting") into linux-3.18.
> > 
> > The interface was changed in commit a6cece9d8199 ("ALSA: usb-audio:
> > Pass direct struct pointer instead of list_head"), which was merged in
> > linux-3.19.
> > 
> > I don't immediately see how this can be fixed. Backporting a6cece9d8199
> > would probably work.
> 
> I already posted the revised patch yesterday, but apparently this
> seems overlooked:
> 
>   Subject: Re: [PATCH 3.18 08/19] ALSA: usb-audio: Kill stray URB at exiting
>   From: Takashi Iwai <tiwai@suse.de>
>   Date: Mon, 16 Oct 2017 20:50:02 +0200
>   Message-ID: <s5hpo9nylk5.wl-tiwai@suse.de>
> 
> The same patch is attached below.
> 
> Greg, could you replace the broken one?

Now replaced, thanks, and sorry for the delay.

greg k-h
