From: Prince John <princejohnm@yahoo.com>
Subject: problems in /proc read and alsamixer
Date: Wed, 25 Jun 2003 07:38:26 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030625143826.8743.qmail@web11706.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hi,
I'm working on an Alsa driver for a Hitachi SH4 based
board with an AC'97 codec (AD1881).
ALSA driver - Ver. 0.9.1
Linux kernel - Ver. 2.4.18

All the modules are getting loadedand AC'97 read/write
call backs are working fine. 
But I'm facing following problems:

Problem 1: Segmentation Fault while reading the AC97
proc entries. 

/proc/asound/card0 directory contents:

# ls -l /proc/asound/card0
-r--r--r--    1 root     root            0 Jun  7
16:10 Aspen18xx
-r--r--r--    1 root     root            0 Jun  7
16:10 ac97#0
-r--r--r--    1 root     root            0 Jun  7
16:10 ac97#0regs
-r--r--r--    1 root     root            0 Jun  7
16:22 id
dr-xr-xr-x    3 root     root            0 Jun  7
16:22 pcm0c
dr-xr-xr-x    3 root     root            0 Jun  7
16:22 pcm0p
--------------

Following error comes when I try to read the ac97#0
files:

# cat ac97#0

Unable to handle kernel NULL pointer dereference at
virtual address 00000000
pc = 8c11091e
*pde = 00000000
Oops: 0000

PC  : 8c11091e SP  : 8c47dc10 SR  : 40000100 TEA :
c0100034    Not tainted
R0  : 00000002 R1  : 00000000 R2  : 0000007e R3  :
c014c685
R4  : 0000000a R5  : ffffffff R6  : c014c684 R7  :
ffffffff
R8  : 8cd75df4 R9  : 8c47dc60 R10 : 00000000 R11 :
ffffffff
R12 : 00000002 R13 : 8c47de5f R14 : 8c47dc60
MACH: 000004bf MACL: 00000000 GBR : ff800000 PR  :
c01022be
-------------------

# cat Aspen18xx

 Fault in unaligned fixup: 0000
-------------------

Similar types of errors are coming while reading other
proc files (in this dir) too. I think the error
happens
during the snd_iprintf function calls in ac97_codec.c
file, but don't know how to resolve it. Has anybody
face this problem?
Any ideas to resolve it?


Problem 2:
I have cross compiled the alsa utilities for my target
(SH4 based). While executing (in super user mode)
'alsamixer', it terminates with following
error message:

ALSA lib control.c:612:<snd_ctl_open_noupdate> Invalid
CTL default
alsamixer: function snd_ctl_open failed for default:

In mailing list, I could see many queries on this
error, but couldn't find any proper solution for this.
The snddevices script was run before this, which
creates the relevant device under /dev

Could you please give some advices to resolve these
issues?

Thanks a lot,
Prince.

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
