From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: cs4248 / thinkpad 755 / 755c , patch suggestions
Date: Wed, 2 Jul 2003 13:50:07 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030702185006.GU24005@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: witwerg@icequake.net
List-Id: alsa-devel@alsa-project.org


Hi,

After an afternoon and morning of poring over disassembly of the
Thinkpad 755/755c audio driver, I've found a solution to get it to work.

This information applies to Thinkpad 360, Thinkpad 750, Thinkpad 755C,
and Thinkpad 755CS with the Crystal CS4248 WSS codec.

The CS4248 is a full duplex stereo codec which is pin and command
compatible with an AD1848.  It is supported in the ALSA and OSS drivers.
However, on these laptops, any attempt to get the sound running with the
existing drivers has met with failure; the chip is forever in the busy
(0x80) state and never responds, so the driver's detection routine
bails out with ENODEV.

Getting tired of this problem finally, I wrote a little "catport"
program that lets me read and write to arbitrary hardware ports easily,
so I could prod a port and check its status immediately.

--------------------------------------------------------------------------------
catport.c
--------------------------------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/io.h>

int main(int argc, char **argv) {

	unsigned int port, temp;
	unsigned char val;

	if (argc < 3) { printf("need at least 3 arguments, exiting\n"); return 1; }
	if (getuid()) { printf("need root privileges\n"); return 1; }

	iopl(3);
	sscanf(argv[2], "%x", &port);

	switch (*(argv[1])) {
		case 'w':
			sscanf(argv[3], "%x", &temp);
			temp &= 0xff;
			val = (unsigned char)temp;
			outb(val, port);
			printf("Output %x (%c) to port %x\n", val, (unsigned char)val, port);
			break;
		case 'r':
			val = inb(port);
			printf("Received %x (%c) from port %x\n", val, (unsigned char)val, port);
			break;
		default:
			break;
	}

	return 0;

}
/* gcc ./catport.c  -o catport -g -O2 -Wall */

--------------------------------------------------------------------------------

This allowed me to determine where the proper port ranges were and verify that
the problem was what I thought.

So I use catport to check the ports 0x4e30-0x4e39.  Sure enough, they all return
0x80, the AD1848 busy.  Other ports return 0xff, so I assume that the CS4248 is
actually on these ports.  Any writes to these ports are ignored as per the AD1848
data sheet when the chip is in "reset" or "not ready" mode.


The DOS driver tpauddd.sys initalizes the chip and allows sound to be played to
it as a Windows Sound System compatible codec device.  Next step, I took a
copy of the tpauddd.sys off IBM's Audio Features diskette, and run it through
a disassembler.  After a day or so of looking over the disassembled code and
translating whatever I could find that hits the hardware into pseudo C code
so it was readable, I run across the following function which I wish I ran
across in the first place (the function names are filled in by myself while
analysing the code):

<mode dmca-violation="on">

----------------------------------------------------------------------------

Iseg000:ADC6	push    bp
Iseg000:ADC7	mov     bp, sp
Iseg000:ADC9	sub     sp, 4
Iseg000:ADCC	mov     ax, 1Ch         ; hmm 0x1c
Iseg000:ADCF	push    ax
Iseg000:ADD0	mov     ax, 15E8h       ; goes to port 0x15e8
Iseg000:ADD3	push    ax
Iseg000:ADD4	call    outb__
Iseg000:ADD7	add     sp, 4
Iseg000:ADDA	mov     ax, 15E9h	; check whats in 0x15e9
Iseg000:ADDD	push    ax
Iseg000:ADDE	call    inb__
Iseg000:ADE1	pop     bx
Iseg000:ADE2	mov     ds:4D45h, al		; save the value for later
Iseg000:ADE5	test    byte ptr ds:4D45h, 2    ; is bit 2 set?
Iseg000:ADEA	jnz     loc_0_AE3F		; if not, go away
Iseg000:ADEC	call    damnit2			; do some other stuff
Iseg000:ADEF	mov     al, ds:4D45h
Iseg000:ADF2	or      al, 2			; or the value from before with 2??
Iseg000:ADF4	sub     ah, ah
Iseg000:ADF6	push    ax
Iseg000:ADF7	mov     ax, 15E9h		; put it back into 0x15e9
Iseg000:ADFA	push    ax
Iseg000:ADFB	call    outb__
Iseg000:ADFE	add     sp, 4
Iseg000:AE01	push    word ptr ds:4D0Ch   ; $4D0C stores one of the codec's address
Iseg000:AE05	call    inb__			; read from it
Iseg000:AE08	pop     bx
Iseg000:AE09	cmp     al, 80h ; 'Ç'		; does it == 0x80?
Iseg000:AE0B	jnz     loc_0_AE38		; if not, we are done, return 0
Iseg000:AE0D	sub     ax, ax
Iseg000:AE0F	mov     [bp+var_2], ax		; i = 0
Iseg000:AE12	mov     [bp+var_4], ax		; j = 0

Iseg000:AE15 loc_0_AE15:
Iseg000:AE15	push    word ptr ds:4D0Ch  ; read $4D0C
Iseg000:AE19	call    inb__
Iseg000:AE1C	pop     bx
Iseg000:AE1D	cmp     al, 80h ; 'Ç'	   ; is it 0x80?
Iseg000:AE1F	jnz     loc_0_AE3C	   ; if not, the chip is now ready, jump out
Iseg000:AE21	add     [bp+var_4], 1	   ; i++
Iseg000:AE25	adc     [bp+var_2], 0   
Iseg000:AE29	cmp     [bp+var_2], 7
Iseg000:AE2D	jb      loc_0_AE15
Iseg000:AE2F	ja      loc_0_AE38
Iseg000:AE31	cmp     [bp+var_4], 0A120h  ; if (i <= big_number) goto tryagain;
Iseg000:AE36	jbe     loc_0_AE15

Iseg000:AE38 loc_0_AE38:
Iseg000:AE38	xor	ax, ax
Iseg000:AE3A	jump	short loc_0_AE42

Iseg000:AE3C loc_0_AE3C:
Iseg000:AE3C	call    do_the_init

Iseg000:AE3F loc_0_AE3F:
Iseg000:AE3F	mov     ax, 1

Iseg000:AE42 loc_0_AE42:
Iseg000:AE42	mov     sp, bp
Iseg000:AE44	pop     bp
Iseg000:AE45	retn 


----------------------------------------------------------------------------------


Now I'm not exactly certain on what everything is going on, but the one loop
certainly looks like the one ad1848_probe calls.  So, on a whim, I try those
two port addresses with my catport.

nemesis@debbook:~/debs$ sudo ./catport r 0x4e30   
Received 80 () from port 4e30  ; as usual

nemesis@debbook:~/debs$ sudo ./catport r 0x15e8
Received 2 () from port 15e8

nemesis@debbook:~/debs$ sudo ./catport w 0x15e8 0x1c
Output 0x1c () to port 15e8

nemesis@debbook:~/debs$ sudo ./catport r 0x15e8
Received 1c () from port 15e8  ; ok, it took

nemesis@debbook:~/debs$ sudo ./catport r 0x15e9
Received f9 () from port 15e8

(f9 |= 2) == fb, so:

nemesis@debbook:~/debs$ sudo ./catport w 0x15e9 0xfb
Output fb () to port 15e9

nemesis@debbook:~/debs$ sudo ./catport r 0x15e9
Received fb () from port 15e9

nemesis@debbook:~/debs$ sudo ./catport r 0x4e30
Received 40 () from port 4e30  ; What the... it's up!!!


that's all it took.

Now, I insert the module against the default resources which are
I/O 0x4e30, IRQ 10, DMA 0,1

$ sudo insmod snd-ad1848 port=0x4e30 irq=10 dma1=0

And the sound is inited!  I can use alsamixer and cat something to /dev/dsp
and it exits successfully, no errors in the dmesg.

Now, I can't actually *hear* the sound, because I am working through an ssh; my
IBM laptop is at home 100 miles away in a corner somewhere.  But since alsamixer
works, the DSP does not block, and all of the ports read the correct AD1848
values (i.e. index = 0x40, statuc=0xcc, revision/mode = 0x8a, etc), I think we
are in business.  I am guessing that the Thinkpad leaves the chip disabled unless
a driver enabled it, for the power consumption reasons.

So, my question to alsa-devel is, what should be the proper way to do this fix?
I could just do something like the following:

... try init ...
else { /* if the chip remained busy, let's see if we have a Thinkpad that needs
		the chip powered on */

	outb(0x1c, 0x15e8);
	temp = inb(0x15e9);
	outb(temp|2, 0x15e8);
	... try init again ...
}

But that seems a braindead solution -- we don't want to go banging random ports
on a machine which may have other sensitive things attached there.  Under
windows 95, the 0x15e8-0x15ef is assigned to "Motherboard Resources" -- is there
a way to determine whether this I/O range is allocated by the system in a useful
manner instead of making guesswork?

Let me know a better way to do that, and I will submit a patch.

Thanks!

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
