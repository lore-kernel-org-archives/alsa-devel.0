From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Hammerfall DSP System Problems
Date: Fri, 6 Jun 2003 06:39:37 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGMEJPCGAB.mknecht@controlnet.com>
References: <7954491.1054848482159.JavaMail.java@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <7954491.1054848482159.JavaMail.java@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: frankgaetano@collegeclub.com
Cc: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Frank,
   I'm an HDSP 9652 non-user for many of the same reasons. A couple of
comments below.
Mark

>
>
> Hello,
>   I recently purchased a Hammerfall DSP system to use on Windows and
> especially LINUX for use on Ardour. I have the multiface system. I
> must say I am confused on the support of the newest version of this
> pci card (I know that I have firmware version 11). I downloaded the
> current CVS on alsa-dev and compiled it fine. However when I run
> modprobe I get the following error:
>
>  /sbin/modprobe snd-hdsp
> /lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o:
> init_module: No such device

[MWK] This is sometimes caused by a mismatch between between the firmware
revision in your card/box and those firmware revisions that the driver knows
about. Run lspci to see what your card has, and read through the driver code
to see what the driver knows about.

NOTE TO DEVELOPERS - Can't you make this message "init_module: No such
device" more descriptive, such as "init_module: Checked for devices with PCI
Device ID's XXX, firmware revisions AA, BB, CC, DD & EE - No devices found"?
Many people, including me, don't know how to read source code and can't give
you as much direct information. Just a thought.



> Hint: insmod errors can be caused by incorrect module parameters,
> including invalid IO or IRQ parameters
> /lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: insmod
> /lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o failed
> /lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: insmod
> snd-hdsp failed
>
> Then when I just offer the command insmod snd-hdsp I get the
> following:
>
> /sbin/insmod snd-hdsp
> Using /lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o
> /lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved
> symbol snd_hammerfall_get_buffer_R5bab1fdf
> /lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved
> symbol snd_rawmidi_receive_R1e37534c

[MWK] I have seen these sorts of errors when:

1) The kernel source code that the driver was compiled against is not the
same as the kernel that's running. For instanace, you have a standard
distribution kernel and a custom kernel from kernel.org. If you are running
the standard kernel, but the Alsa driver was compiled with /usr/src/linux
pointing at the custom kernel, then problems ensue.

2) The C compiler used to compile Alsa does not match the compiler used to
compile the kernel.

<SNIP>
>
> When I run hdsploader it completes but says nothing like this:
>
> hdsploader - firmware loader for RME Hammerfall DSP cards
> Looking for HDSP + Multiface or Digiface cards :
>

[MWK] Again, this strikes me that Alsa does not understand your firmware
revision since it isn't even finding a card.

Good luck!!




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
