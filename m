From: Kunal Gangakhedkar <kunal.gangakhedkar@gmail.com>
Subject: Re: [PATCH] Recognise and use subdevice 0x3061 found
	in some HP dv6 notebooks.
Date: Mon, 14 Dec 2009 15:53:54 +0530
Message-ID: <200912141553.54309.kunal.gangakhedkar@gmail.com>
References: <200912140029.42677.kunal.gangakhedkar@gmail.com>
	<s5hy6l5lvhp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f172.google.com (mail-iw0-f172.google.com
	[209.85.223.172])
	by alsa0.perex.cz (Postfix) with ESMTP id 47AF610388F
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 11:24:08 +0100 (CET)
Received: by iwn2 with SMTP id 2so1913366iwn.16
	for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2009 02:24:07 -0800 (PST)
In-Reply-To: <s5hy6l5lvhp.wl%tiwai@suse.de>
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

On Monday 14 Dec 2009 3:37:14 pm Takashi Iwai wrote:
> At Mon, 14 Dec 2009 00:29:42 +0530,
> Kunal Gangakhedkar wrote:
> > 
> > Obvious patch.
> > Recently bought an HP Pavilion dv6-1110ax notebook. The modparm 'model=hp-dv5'
> > works, but I thought it was better if it were natively supported.
> > 
> > Also, the 'hp_detect=1' hint
> > (echo "hp_detect = 1" > /sys/class/sound/hwC0D0/hints) works nicely to mute the
> > speakers when using the headphone jack(s). Is there any way to automatically
> > enable this?
> 
> This is weird.  hp_detect is basically always set unless you clear
> explicitly.  I guess it's simply a known IRQ problem on HP dv
> laptops.  It requires MSI.
> 
> Anyway, could you test the very latest kernel without your patch and
> confirm that the change is still needed?
> 

The patch wasn't about hp_detect. It was to get the subdev recognised natively so that 
you don't need the 'model=hp-dv5' modparm.

I'll try with enable_msi modparm as well without trying the hp_detect hint and let you know 
about it. Will also try the latest kernel.
 
Thanks,
Kunal
