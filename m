From: Paul Davis <pbd@op.net>
Subject: Re: MPU401 and native ALSA sequencer device?
Date: Fri, 15 Feb 2002 00:05:24 -0500
Message-ID: <200202150509.AAA06147@renoir.op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id GAA19051
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2002 06:09:53 +0100
In-reply-to: Your message of "Thu, 14 Feb 2002 22:52:54 GMT."
             <20020214225254.38324.qmail@web13102.mail.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Chris Rankin <rankincj@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>Hi,
>
>My ALSA sound driver uses an MPU401 for MIDI support,
>and the OSS emulation module snd-seq-oss works well
>with the snd-mpu401-uart module. However, there are no
>native ALSA sequencer devices:
>
>[root@wittsend src]# cat /proc/asound/seq/clients
>Client info
>  cur  clients : 3
>  peak clients : 3
>  max  clients : 192

you've just demonstrated the existence of the ALSA sequencer.

>Client   0 : "System" [Kernel]
>  Port   0 : "Timer" (Rwe-)
>  Port   1 : "Announce" (R-e-)
>    Connecting To: 63:0
>Client  63 : "OSS sequencer" [Kernel]
>  Port   0 : "Receiver" (-we-)
>    Connected From: 0:1
>  Output pool :
>    Pool size          : 1024
>    Cells in use       : 0
>    Peak cells in use  : 1024
>    Alloc success      : 12370
>    Alloc failures     : 0
>Client  64 : "External MIDI 0" [Kernel]
>  Port   0 : "MIDI 0-0" (RWeX)
>

there is no "ALSA Sequencer" as a specific client. each client listed
is a client of the ALSA sequencer. client 63 is a special client that
handles OSS sequencer data.

>Since the OSS layer plays music, it seems logical to
>assume that all the hardware bit-twiddling has been
>done already. I am therefore assuming that I just need
>to register some native ALSA sequencer device. Could
>someone point me towards a simple example somewhere,
>please? I have tried looking at the opl3_seq.c file
>but it seems to be doing a LOT more than just
>registering a device.

what is it that you want to do? if you want to send midi out of the
MPU401 external midi port, just connect up a program like pmidi to
client 64, port 0.

--p


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
