From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: support for SAM940x based cards
Date: Fri, 17 Jan 2003 13:47:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301171347.15932.pieter.palmers@student.kuleuven.ac.be>
References: <200301160014.11787.c.esken@cityweb.de> <s5hsmvs14oo.wl@alsa2.suse.de> <3E27F04C.8020806@kss-loka.si>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E27F04C.8020806@kss-loka.si>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Uros Bizjak <uros@kss-loka.si>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

>   Yes, I have working code to communicate with SAM9407 chip (microcode
> loading,
> memory management, channel allocation, control interface, etc) and I
> have just start
> working on PCM interface.  Unfortunatelly, I haven't got any time to
> implement
> PCM routines, but all the low-level routines are in place. The code is
> written for older
> 0.9.x version of ALSA (as I didn't yet port it to latest CVS).
>
>   If anybody is interested in helping with this project, I would gladly
> share my (partially
> functional) code. Code is tested with EWS64XL (PnP detection of SAM9407,
> i2c stuff
> and TEA chips are working OK), has many comments, and basically just
> waits for someone to
> "fill in the blanks" on PCM part.
>

I would surely be interested in this code. I think a lot of code can be shared 
between the cards. The transfer mechanism of the ISIS different, but I think 
it can fit into a general approach i.e. a generic driver for the SAM970x chip 
supported by an 'architecture dependant' driver. 
The isis uses the maestro as a PCI to ISA bride and transfers from/to the chip 
should be done like this: 
(disassembled source at http:/isisalsa.sourceforge.net/assembler.htm)

registers involved:
MAESTRO_BASE + 44h: address of the ISA port (IDMA in ESS terminology) on the 
maestro.
MAESTRO_BASE + 46h: data register for the ISA port

so basically transfers come down to this: (disassembled from win drivers)
	mov ax, 1 		; address 0x01 is the SAM control port
	mov dx, MAESTRO_BASE
	add dx, 44h
	out dx, ax              ; select control port
	mov dx, MAESTRO_BASE
	add dx, 46h 	 ; switch to data register
	in ax, dx               ; read value

	by the way: does anyone know why they don't do it like this:
		mov ax, 1 		; address 0x01 is the SAM control port
		mov dx, MAESTRO_BASE
		add dx, 44h
		out dx, ax              ; select control port
		add dx, 02h 	 ; switch to data register
		in ax, dx               ; read value
	compiler issue?

	to illustrate this even further, consider this piece of code also 
disassembled from the win driver:
	looppoint1:           
       		mov     dx, 1
	        push    dx
 	       	mov     ax, dx
  	      	mov     dx, MAESTRO_BASE
   	     	add     dx, 44h                 ; Add
    		out     dx, ax                  ; control port
	        mov     dx, MAESTRO_BASE
	        add     dx, 46h                 ; Add
	        in      ax, dx                  ; read port
	        and     ax, 0FFh                ; keep lower 8 bits
*	        push    ax
*	        mov     ax, 2
*	        mov     dx, MAESTRO_BASE
*	        add     dx, 44h         ; Add
*	        out     dx, ax                  ; DATA16 port
*	        pop     ax
	        pop     dx
	        test    al, 80h                 ; is TE=0 ?
	        jz      short read_word         ; TE = 1 => data present
	        loop    looppoint1              ; Loop while CX != 0

	I marked the strange part of the code with an asterix. Isn't this pure 
overhead?

that aside, let's get back to the main issue...
The actual PCM data transfer is done with a 'repsw outw' command as sayd by 
Uros. Something like:
       		mov     dx, 2
  	      	mov     dx, MAESTRO_BASE
   	     	add     dx, 44h                 ; Add
    		out     dx, ax                  ; DATA16 port
	        mov     dx, MAESTRO_BASE
	        add     dx, 46h                 ; Add
		repsw outw ... (forgot syntax)

I wondered if it isn't possible to use the Maestro DMA capability to transfer 
the large chunks from main memory to the ISA/IDMA port independant from CPU? 
Do we have any information on this 'DSP modem' or IDMA port on the Maestro 
family? (I assume that ESS hasn't changed that much between Maestro 
generations)


Pieter

PS: I have the sourcecode of the Hoontech ST128 windows drivers (both 9x and 
WDM). If you want them, you can download them at 
http://isisalsa.sourceforge.net. These cards are based on SAM940x chips.

PPS: What do you think of the statement that this type of transfer isn't 
supported in WinXP/NT due to the HAL that OS uses? This is the justification 
of Guillemot not to provide WinXP drivers.



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
