From: "William W. Austin" <bill@34.mumb.atln.nrcrgais.dsl.att.net>
Subject: debugging an sfxload prolem under rc8b.1 (and earlier)
Date: Sat, 8 Mar 2003 11:33:00 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303081633.h28GX00E012600@34.mumb.atln.nrcrgais.dsl.att.net>
Reply-To: bill@34.mumb.atln.nrcrgais.dsl.att.net
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I added a new machine (or upgraded and old one) recently, and moved my main workstation to the newer,
2.1Ghz athlon machine :-).

However although everything else went smoothely, one problem now occurs under all of the drivers from
fr0rc6.1 through fr0rc8.1.

My wife is a composer and uses *very* *large* soundfonts.  Using an sblive! 2.1 card, I was
previously able to do:

	sfxload <1st sound font>
	sfxload -b <2nd sound font>
	...
	sfxload -b <7th sound font>

and these took up about 120 Mb.  No problem.

Now doing an sfxload of anything larger than roughly 10088 fails after loading the first 10088Mb and
then closing/exiting.

Looking a the output of strace sfxload large_font.sfx shows that the load fails due to running out of
memory like so (last few lines): 

> mmap2(NULL, 1740800, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
> 0x40067000
> _llseek(4, 0, [0], SEEK_SET)            = 0
> read(4, "RIFF\314KQ\6sfbkLIST\314\0\0\0INFOifil\4\0\0\0"..., 4096) = 4096
> read(4, "\\\"B\37\33\34\360\30\300\25\213\22X\17#\f\360\10\300\5"..., 1732608) =
> 1732608
> read(4, "\1\0\1\0\1\0\1\0\1\0\1\0\1\0\1\0\1\0\1\0\1\0\1\0\1\0\1"..., 4096) =
> 4096
> write(3, "\375\7\0\0\0\0\0\0f\213\32\0\1\0\0\0\0\0\0\0\0\0\0\0\203"..., 1739638)
> = -1 ENOSPC (No space left on device)
> munmap(0x40067000, 1740800)             = 0
> write(3, "\375\7\0\0\0\0\377\377\0\0\0\0\3\0 2", 16) = 0
> brk(0x8075000)                          = 0x8075000
> close(4)                                = 0
> munmap(0x40013000, 4096)                = 0
> close(3)                                = 0
> _exit(1)                                = ?

However, the same card can be swapped into another machine (both running same os on athlon cpu) and
it works correctly (i.e., the font loads and is usable).  The results are the same, BTW, whether I
build from scratch (raw tar.gz files) or build and install my own rpms -- the same rpms are loaded on
both machines FWIW.

Particulars:
OS:		redhat 8.0 with kernel-2.4.18-26.8.0 (athlon)
glibc:		glibc-2.2.93-5
Mem:		(main sys has 1 gb , second has 512 mb)
Sound card:	SoundBlaster Live! 2.1

The same alsa modules are loaded on both systems.  The same updates have been applied to *both*
machines -- the only differences are as shown below:

A) Cpu's: machine A has athlon xp2100+; machine B has athlon xp1800+
B) MB's are similar but different models: machine A is gigabyte ga7-vax while machine B is gigabyte
ga7-vrx.
C) the main machine is all scsi while the second machine had ide drives but scsi tape (1st machine
has adaptec 29160, 2nd has adaptec 2940U).
D) the video cards are different (machine A: Nvidia GeForce4 4200 64mb ddr; machine B: Nvidia GeForce
4 440 64mb sdr), although both use nvidia's drivers, version 4191.

I've gone through sfxload with the debugger, and yes, system A is returning no space left on device
causing the write to fail.

ANY suggestions on finding and fixing the cause of the problem on this one would be greatly
appreciated.  I know that the "Known Bugs" section on the card info on the alsa website says "- MIDI
on SB live drive not working properly." but this had never occurred previously.

Thanks in advance,

-- 
William W. Austin 			bill@34.mumb.atln.nrcrgais.dsl.att.net
       "Life is just a phase I'm going through... this time, anyway..."


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
