From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: bugs in usb midi alsa code?
Date: Fri, 08 Nov 2002 09:39:48 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211080920200.23272-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.44.0211071037490.16062-100000@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA04456
	for <alsa-devel@alsa-project.org>; Fri, 8 Nov 2002 09:39:55 +0100
In-reply-to: <Pine.LNX.4.44.0211071037490.16062-100000@cmn37.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Martin Langer <martin-langer@gmx.de>, Werner Schweer <ws@seh.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fernando Pablo Lopez-Lezcano wrote:
> > OSS:         rawmidi -v -I /dev/midix
>
>   ./rawmidi -v -I /dev/midi1 --> works fine
>
> > ALSA direct: rawmidi -v -I /dev/snd/midiCxD0
>
>   ./rawmidi -v -I /dev/snd/midiC1D0 --> works fine

These two tests access the driver directly, without going through the ALSA
library, so I'll assume that the driver itself works fine.

> > ALSA Lib:    rawmidi -v -i hw:x,0
>
> ./rawmidi -v -i hw:1,0
> Using:
> Input: device hw:1,0
> Output: NONE
> ALSA lib rawmidi.c:247:(snd_rawmidi_open_conf) symbol _snd_rawmidi_hw_open
> is not defined inside (null)
> snd_rawmidi_open hw:1,0 failed: -6
> Closing
>
> > ALSA Lib:    rawmidi -v -i hw:x,0,0
>
> Same as the previous test.

The ALSA lib is not able to load and call a function from librawmidi.
There seems to be something wrong with your ALSA configuration.
>From the error message I would deduce that there is a rawmidi_type
definition in .asoundrc or /etc/asound.conf or /usr/share/alsa/alsa.conf
which lacks the "lib" key, but I'm not sure about this.
You might try recompiling and installing the alsa-lib package, or
temporarily removing the config files mentioned above.


HTH
Clemens



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
