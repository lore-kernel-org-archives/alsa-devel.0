From: Martin Langer <martin-langer@gmx.de>
Subject: Re: bugs in usb midi alsa code?
Date: Thu, 7 Nov 2002 15:20:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021107142039.GA535@tuba.home>
References: <20021107122254.GE541@tuba.home> <Pine.HPX.4.33n.0211071332210.15377-100000@studcom.urz.uni-halle.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id PAA20028
	for <alsa-devel@alsa-project.org>; Thu, 7 Nov 2002 15:21:13 +0100
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0211071332210.15377-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, ws@seh.de, nando@ccrma.Stanford.EDU, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 07, 2002 at 01:50:29PM +0100, Clemens Ladisch wrote:
> 
> So ALSA rawmidi works, too.
> 
> Apparently, the bug only occurs if a rawmidi port is used through the
> alsa-lib functions. (The subdevice checking code in rawmidi_hw.c did
> change, but that was a bugfix. Hmmm...)

commenting out that new line doesn't help!

> 

In former days I have had these lines in /proc/asound/seq/clients. There
were two endpoints for each direction.
Client  64 : "Evolution Electronics Ltd. MK-249C USB MIDI keyboard" [Kernel]
  Port   0 : "MK-249C USB MIDI keyboard Port 0" (R-e-)
  Port   1 : "MK-249C USB MIDI keyboard Port 1" (-We-)


Now I have two endpoints in the messages, but a mixed entry in the clients
list. Is this correct or do we have a multi endpoint problem?

[...]
Nov  7 14:18:55 tuba kernel: snd-usb-midi: detected 1 input jack(s) on
endpoint 1
Nov  7 14:18:55 tuba kernel: snd-usb-midi: detected 1 output jack(s) on
endpoint 2
[...]


Today /proc/asound/seq/clients shows me only one port of my keyboard and the
description doesn't has the port number included like above.

tuba:~# cat /proc/asound/seq/clients 
[...]
Client  80 : "External MIDI 2" [Kernel]
  Port   0 : "MK-249C USB MIDI keyboard Port " (RWeX)
[...]


I hope this can help

martin


-- 
"2b|!2b"


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
