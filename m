From: Bas van Dijk <basvandijk@home.nl>
Subject: No soundcards found
Date: Thu, 26 May 2005 00:24:42 +0200
Message-ID: <200505260024.42655.basvandijk@home.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

( I first posted this bug on bugs.gentoo.org, but we couldn't figure it out: 
http://bugs.gentoo.org/show_bug.cgi?id=93086 )

My sound sometimes works and sometimes doesn't.  
  
I have a "SiS AC97 Controller" and I compiled the driver for it in the kernel.  
Note that the error also occurs when using modules. 
  
The kernel gives the following error while booting:  
  
> dmesg   
...   
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13 09:39:32   
2005 UTC).   
PCI: Enabling device 0000:00:02.7 (0000 -> 0001)   
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5   
ACPI: PCI interrupt 0000:00:02.7[C] -> GSI 5 (level, low) -> IRQ 5   
codec_ready: codec is not ready [0x300000]   
Intel ICH: probe of 0000:00:02.7 failed with error -5   
ALSA device list:   
  No soundcards found.   
...   
   
> lspci -v   
...   
0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]   
Sound Controller (rev a0)   
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 2440   
        Flags: medium devsel, IRQ 5   
        I/O ports at 1400   
        I/O ports at 1080 [size=128]   
        Capabilities: [48] Power Management version 2   
...  
  
> uname -r  
2.6.11-gentoo-r9  

As you can see from the gentoo bug report, the same error occured on a vanilla 
sources 2.6.12 kernel.

How can I fix this?

( BTW. I tried singing up with the ALSA bug tracking service but it didn't 
work :-( )


-------------------------------------------------------
SF.Net email is sponsored by: GoToMeeting - the easiest way to collaborate
online with coworkers and clients while avoiding the high cost of travel and
communications. There is no equipment to buy and you can meet as often as
you want. Try it free.http://ads.osdn.com/?ad_id=7402&alloc_id=16135&op=click
