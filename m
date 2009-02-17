From: hagedorn@kimae.de
Subject: ALI5451: "stimer is not ready"
Date: Tue, 17 Feb 2009 18:28:49 +0100
Message-ID: <200902171828.49692.hagedorn@kimae.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 814201037EE
	for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2009 18:28:50 +0100 (CET)
Received: from exchange.kimae-win.lan (mail.kimae.eu [80.152.248.6])
	by post.strato.de (fruni mo9) (RZmta 18.18)
	with ESMTP id m02c93l1HHAWiV for <alsa-devel@alsa-project.org>;
	Tue, 17 Feb 2009 18:28:50 +0100 (MET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Dear All,

since our hardware supplier changed the processor type from Transmeta T5700 
(667MHz) to T5800 (997MHz), we experience massive problems with the sound 
card access. 

With the new T5800 processor we first noticed problems with IDE access. But it 
can be solved by switching "acpi=off" and choosing another processor type in 
kernel config, e.g. 'Pentium MMX' instead 'Transmeta Crusoe'. 

Moreover we experienced random appearance of
 "ali_stimer_read: stimer is not ready" 
messages from ALSA when accessing the sound card on T5800.
I tried also 2.4.37 and 2.6.22 kernels. An update to ALSA 1.0.19 does not help 
too. 
The strange thing is that i can boot the same system over and over again...
in some cases i get above error message, sometimes i get no ALSA error message 
at all but the sound card can not be accessed, and sometimes the system works 
and is recording sound - at least for a few hours.
Loading the kernel module trident instead of ALSA makes the system freeze 
immediately on a T5800. On a T5700 it works.
System yields regulary " i8253 count too high ! resetting " but does not  
seem to have any effect on system with T5700. On T5800 this messages is much 
more often. On 2.6.22 kernel i saw "TSC unstable" at boot time.


I do not have knowledge about these timing things, so i would like to know
a) what does above message mean exactly?
b) what timing source is alsa using and how can i influence it?
c) what timing source is the kernel using and how can i influence it?
d) can this be caused by defect hardware or buggy BIOS?
e) do you have any other ideas (e.g. kernel options)?


Some info about the original system which worked well on T5700:

- Linux is self-compiled with 'Linux from Scratch'
- System boots from Compact Flashdisk, HDD is used for log files only
- Kernel 2.4.22, optimized for Transmeta crusoe
- Glibc version 2.3.2, compiled with GNU CC 3.3.3 for i686 on Kernel 2.4.25 
- ALSA 1.0.5a, loaded modules are snd, snd-ali5451, soundcore, snd-pcm
 snd-timer, snd-page-alloc, snd-ac97-codec

The same compact flashcard containing this configuration on a T5800 system 
will yield IDE errors "DRQ after issuing write" and will show the stated ALSA 
stimer error.


Thank you very much in advance.
Kind regards,
Christoph
