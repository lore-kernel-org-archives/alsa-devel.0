From: Uros Bizjak <uros@kss-loka.si>
Subject: Re: support for SAM940x based cards
Date: Fri, 17 Jan 2003 14:09:19 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E28007F.3020705@kss-loka.si>
References: <200301160014.11787.c.esken@cityweb.de> <s5hsmvs14oo.wl@alsa2.suse.de> <3E27F04C.8020806@kss-loka.si> <200301171347.15932.pieter.palmers@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301171347.15932.pieter.palmers@student.kuleuven.ac.be>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Pieter Palmers wrote:

>>  Yes, I have working code to communicate with SAM9407 chip (microcode
>>loading,
>>memory management, channel allocation, control interface, etc) and I
>>have just start
>>working on PCM interface.  Unfortunatelly, I haven't got any time to
>>implement
>>PCM routines, but all the low-level routines are in place. The code is
>>written for older
>>0.9.x version of ALSA (as I didn't yet port it to latest CVS).
>>
>>  If anybody is interested in helping with this project, I would gladly
>>share my (partially
>>functional) code. Code is tested with EWS64XL (PnP detection of SAM9407,
>>i2c stuff
>>and TEA chips are working OK), has many comments, and basically just
>>waits for someone to
>>"fill in the blanks" on PCM part.
>>
>>    
>>
>
>I would surely be interested in this code. I think a lot of code can be shared 
>between the cards. The transfer mechanism of the ISIS different, but I think 
>it can fit into a general approach i.e. a generic driver for the SAM970x chip 
>supported by an 'architecture dependant' driver. 
>
  I have prepared a snapshot of my sam9407 directory at 
www2.arnes.si/~krklubsls1/sam9407-19.Dec.2002-NW.tar.gz
This code has been in working state a couple of months ago, but now it 
is broken because of not-yet-finished PCM changes.

  BTW: I have uploaded some documents found on various sites regarding 
sam9407 programming:
www2.arnes.si/~krklubsls1/TTFirm.ps
www2.arnes.si/~krklubsls1/progref.ps

  And, there are linux drivers (OSS)  - also for ISIS - on  
http://www.anime.net/~sam9407/

    Uros.




-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
