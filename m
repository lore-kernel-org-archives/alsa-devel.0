From: Adrian Bunk <bunk@stusta.de>
Subject: Re: [RFC] Moving snd-bt87x and btaudio to drivers/media
Date: Wed, 18 Jan 2006 20:41:47 +0100
Message-ID: <20060118194147.GN19398@stusta.de>
References: <1137590968.32449.46.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030403AbWARTlv@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1137590968.32449.46.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>, alsa devel <alsa-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Johannes Stezenbach <js@linuxtv.org>, Linux and Kernel Video <video4linux-list@redhat.com>, Manu Abraham <abraham.manu@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 18, 2006 at 11:29:28AM -0200, Mauro Carvalho Chehab wrote:
>...
> 	This I couldn't found at any Kconfig (but module exists, and also an
> entry at Makefile):
> sound/oss/Makefile:obj-$(CONFIG_SOUND_BT878)    += btaudio.o
>...

The entry is in sound/oss/Kconfig.

> Cheers, 
> Mauro.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
