From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: bugs in usb midi alsa code?
Date: Thu, 07 Nov 2002 13:50:29 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211071332210.15377-100000@studcom.urz.uni-halle.de>
References: <20021107122254.GE541@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA18739
	for <alsa-devel@alsa-project.org>; Thu, 7 Nov 2002 13:50:45 +0100
In-reply-to: <20021107122254.GE541@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: ws@seh.de, nando@ccrma.Stanford.EDU, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Martin Langer wrote:
> tuba:/usr/local/src/alsa-cvs/alsa-lib/test# ./rawmidi -v -I /dev/midi2
> Using:
> Input: /dev/midi2
> Output: NONE
> Read midi in
> Press ctrl-c to stop
> read fe
> read fe
> ...

> tuba:/usr/local/src/alsa-cvs/alsa-lib/test# ./rawmidi -v -I /dev/snd/midiC2D0
> Using:
> Input: /dev/snd/midiC2D0
> Output: NONE
> Read midi in
> Press ctrl-c to stop
> read fe
> read fe
> ...

So ALSA rawmidi works, too.

Apparently, the bug only occurs if a rawmidi port is used through the
alsa-lib functions. (The subdevice checking code in rawmidi_hw.c did
change, but that was a bugfix. Hmmm...)

And I'm still not able to reproduce it on my machine. I'll test with a
fresh checkout and the official rc5 tonight.

Did anybody test with a non-USB device?


Regards,
Clemens



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
