From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: FIX: soundblaster rear channels (ens1371)
Date: Fri, 17 Jan 2003 12:32:59 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301171229200.4134-100000@pnote.perex-int.cz>
References: <s5hsmvs14oo.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmvs14oo.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Uros Bizjak <uros@kss-loka.si>
List-Id: alsa-devel@alsa-project.org

On Fri, 17 Jan 2003, Takashi Iwai wrote:

> this is because we are using DAC2 for the hw:0,0 and DAC1 for hw:0,1.
> i'm not sure why it is.
> 
> Jaroslav, is there any drawback to use DAC1 as default playback?
> (i know that the OSS driver uses this order, too.)

This switch was for ENS1370 chip which has DAC0 rates a bit restricted. 
I've reversed streams for ENS1371.

> > To 
> > select this mode set bit27=bit24=1 and bit26=0. It seems that bit27=1 and 
> > bit24=bit26=0 is identical, but the windows driver clearly does the first, so 
> > why not? It works...
> > 
> > front only, no rear: 		bit27=0	bit26=0	bit24=0
> > rear mirrors front:		bit27=0 	bit26=1 	bit24=0
> > front & rear independant:	bit27=1 	bit26=0 	bit24=1 (x?)
> > 
> > 
> > I patched my driver by inserting the following code around line 1947:
> > (I included two lines of overlap to make the location easier to find)
> > =============================================
> > 	outb(ensoniq->uartc = 0x00, ES_REG(ensoniq, UART_CONTROL)); 
> > 	outb(0x00, ES_REG(ensoniq, UART_RES));
> > 
> > #ifdef CHIP1371
> > 	/* enable the rear outputs
> > 	This seems to work
> > 	ensoniq->cssr |= (0 << 27) | (1 << 24);
> > 	but the windows driver does this, so let's
> > 	also do it */
> > 
> > 	ensoniq->cssr |= (1 << 27) | (1 << 24);
> > 
> > 	/*
> > 	Use this for mirror mode
> > 	ensoniq->cssr |= (1 << 26);*/
> > #endif
> > 
> > 	outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
> > #if defined(CONFIG_GAMEPORT) || defined(CONFIG_GAMEPORT_MODULE)
> > =============================================
> > 
> > Maybe there is a better place to put this? I don't know... I put it in the 
> > snd_ensoniq_create() function because I always want 4ch output, and I don't 
> > see the use of the other modes in an ALSA enviroment.
>  
> it would be better to create new controls, and changing the controls
> via hook in the pcm configuration.

Done. Pieter, can you try the latest CVS source. When surround DAC is 
found, there should be 'AC97 2ch->4ch Copy Switch' which controls 
mirroring / separating channels. The front only configuration will be 
used only for cards with no surround DAC. Thank you for your work.

Please, update also alsa-lib and test these commands:

aplay -Drear <some.wav>
aplay -Dplug:surround40 <some.wav>

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
