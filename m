From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: FIX: soundblaster rear channels (ens1371)
Date: Fri, 17 Jan 2003 01:04:40 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301170104.40726.pieter.palmers@student.kuleuven.ac.be>
References: <200301160014.11787.c.esken@cityweb.de> <3E273C33.9050905@cucumelo.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E273C33.9050905@cucumelo.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Finally I figured out how to enable the rear channel separately from the front 
on the creative labs CT5880 (= modified ens1371 as it seems).

I'll describe the settings to enable this, but I'm not going to submit a 
patch, as I have noticed that I messed up my ens1370.c too much, and I can't 
get a clean version because CVS doesn't work. It's a minor change, so I 
assume it can be done by the maintainers.

The whole thing is in three bits in the BASE+0x04 register (ES_REG_STATUS in 
the driver). These bits are bit27, bit26 and bit24
There are three modes of operation:
1) No rear output: bit27=bit26=bit24=0
2) rear output is a mirror of the main output, but controlled by the 
'surround' slider of the mixer. I assume the ens1371 mixes the two 'devices' 
and sends the mix to both MAIN and SURROUND DAC. This mode is selected by 
setting  bit27=bit24=0 and bit26=1
3) independant rear (surround) and front output. Using the current driver, 
this has the strange side-effect that HW:0,0 becomes the rear output and 
HW:0,1 becomes the front. So HW:0,0 is controlled by the 'surround' mixer 
control, and HW:1,0 is controlled by the PCM and Master mixer controls. To 
select this mode set bit27=bit24=1 and bit26=0. It seems that bit27=1 and 
bit24=bit26=0 is identical, but the windows driver clearly does the first, so 
why not? It works...

front only, no rear: 		bit27=0	bit26=0	bit24=0
rear mirrors front:		bit27=0 	bit26=1 	bit24=0
front & rear independant:	bit27=1 	bit26=0 	bit24=1 (x?)


I patched my driver by inserting the following code around line 1947:
(I included two lines of overlap to make the location easier to find)
=============================================
	outb(ensoniq->uartc = 0x00, ES_REG(ensoniq, UART_CONTROL)); 
	outb(0x00, ES_REG(ensoniq, UART_RES));

#ifdef CHIP1371
	/* enable the rear outputs
	This seems to work
	ensoniq->cssr |= (0 << 27) | (1 << 24);
	but the windows driver does this, so let's
	also do it */

	ensoniq->cssr |= (1 << 27) | (1 << 24);

	/*
	Use this for mirror mode
	ensoniq->cssr |= (1 << 26);*/
#endif

	outl(ensoniq->cssr, ES_REG(ensoniq, STATUS));
#if defined(CONFIG_GAMEPORT) || defined(CONFIG_GAMEPORT_MODULE)
=============================================

Maybe there is a better place to put this? I don't know... I put it in the 
snd_ensoniq_create() function because I always want 4ch output, and I don't 
see the use of the other modes in an ALSA enviroment.

Regards,

Pieter

PS: I'm also developing a driver for my Maxisound ISIS, where do I look for 
information on ALSA/linux driver developement? Does anyone have a 'template' 
ALSA driver?
Does ALSA support non-DMA audio transfer? I believe the ISIS uses this kind of 
transfers, but I don't know for sure yet. I know it's stupid design not to 
use DMA, but there is nothing to do about it I guess.



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
