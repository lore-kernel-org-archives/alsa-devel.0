From: Uros Bizjak <uros@kss-loka.si>
Subject: Re: FIX: soundblaster rear channels (ens1371)
Date: Fri, 17 Jan 2003 13:00:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E27F04C.8020806@kss-loka.si>
References: <200301160014.11787.c.esken@cityweb.de>	<3E273C33.9050905@cucumelo.org>	<200301170104.40726.pieter.palmers@student.kuleuven.ac.be> <s5hsmvs14oo.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>, alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>>Does ALSA support non-DMA audio transfer? I believe the ISIS uses this kind of 
>>transfers, but I don't know for sure yet. I know it's stupid design not to 
>>use DMA, but there is nothing to do about it I guess.
>>    
>>
>
>yes, but the implementation depends on the driver.
>you can use tasklet for transferring the data e.g. via io-port
>read/write.
>
>Uros has been working on the ALSA SAM9407 driver, and IIRC, maxi ISIS
>uses a similar (same?) chip.  he might be able to help the development
>of this driver.
>
  Yes, I have working code to communicate with SAM9407 chip (microcode 
loading,
memory management, channel allocation, control interface, etc) and I 
have just start
working on PCM interface.  Unfortunatelly, I haven't got any time to 
implement
PCM routines, but all the low-level routines are in place. The code is 
written for older
0.9.x version of ALSA (as I didn't yet port it to latest CVS).

  If anybody is interested in helping with this project, I would gladly 
share my (partially
functional) code. Code is tested with EWS64XL (PnP detection of SAM9407, 
i2c stuff
and TEA chips are working OK), has many comments, and basically just 
waits for someone to
"fill in the blanks" on PCM part.

  Regarding sam9407: When you set up PCM channel and start transfer, 
chip will signal to driver,
when it is ready to receive data. Following this signal, you send data 
block with outsw()/insw()
command and terminate transfer with chip-specific message sent to 
SAM9407 control port. Some
kind of pseudo DMA.

    Uros.



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
