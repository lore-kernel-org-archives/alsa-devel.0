From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: MPU401 and native ALSA sequencer device?
Date: Thu, 14 Feb 2002 22:52:54 +0000 (GMT)
Message-ID: <20020214225254.38324.qmail@web13102.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Received: from web13102.mail.yahoo.com (web13102.mail.yahoo.com [216.136.174.147])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id XAA12265
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2002 23:52:57 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

My ALSA sound driver uses an MPU401 for MIDI support,
and the OSS emulation module snd-seq-oss works well
with the snd-mpu401-uart module. However, there are no
native ALSA sequencer devices:

[root@wittsend src]# cat /proc/asound/seq/clients
Client info
  cur  clients : 3
  peak clients : 3
  max  clients : 192

Client   0 : "System" [Kernel]
  Port   0 : "Timer" (Rwe-)
  Port   1 : "Announce" (R-e-)
    Connecting To: 63:0
Client  63 : "OSS sequencer" [Kernel]
  Port   0 : "Receiver" (-we-)
    Connected From: 0:1
  Output pool :
    Pool size          : 1024
    Cells in use       : 0
    Peak cells in use  : 1024
    Alloc success      : 12370
    Alloc failures     : 0
Client  64 : "External MIDI 0" [Kernel]
  Port   0 : "MIDI 0-0" (RWeX)

Since the OSS layer plays music, it seems logical to
assume that all the hardware bit-twiddling has been
done already. I am therefore assuming that I just need
to register some native ALSA sequencer device. Could
someone point me towards a simple example somewhere,
please? I have tried looking at the opl3_seq.c file
but it seems to be doing a LOT more than just
registering a device.

Cheers,
Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
