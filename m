From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: ALSA: echoaudio: remove all snd_printk
Date: Tue, 4 Nov 2014 22:41:52 +0530
Message-ID: <20141104171152.GA10949@sudip-PC>
References: <20141104160156.GA15854@mwanda>
 <s5hlhnruelj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id D7442260611
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 18:12:04 +0100 (CET)
Received: by mail-pa0-f44.google.com with SMTP id bj1so14824301pad.17
 for <alsa-devel@alsa-project.org>; Tue, 04 Nov 2014 09:12:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <s5hlhnruelj.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 04, 2014 at 05:15:20PM +0100, Takashi Iwai wrote:
> At Tue, 4 Nov 2014 19:01:56 +0300,
> Dan Carpenter wrote:
> > 
> > Hello Sudip Mukherjee,
> > 
> > The patch b5b4a41b3929: "ALSA: echoaudio: remove all snd_printk" from
> > Nov 3, 2014, leads to the following static checker warning:
> > 
> > 	sound/pci/echoaudio/echoaudio.c:1908 snd_echo_free()
> > 	error: dereferencing freed memory 'chip'
> > 
> > sound/pci/echoaudio/echoaudio.c
> >   1905          /* release chip data */
> >   1906          free_firmware_cache(chip);
> >   1907          kfree(chip);
> >                 ^^^^^^^^^^^
> >   1908          dev_dbg(chip->card->dev, "Chip freed.\n");
> >                         ^^^^^^^^^^

oops , missed it. sorry.

> > 
> > We have lots of printks in this function.  We could just delete them all
> > and no one would care.  These days you can get the same information from
> > ftrace.
> 
> Yep, maybe it's a wiser choice.  Sudip, care to send a clean up patch?
> 
sure. i have alredy started. cleanup like Joe Perches suggested from all the functions.

thanks
sudip

> 
> thanks,
> 
> Takashi
