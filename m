From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: bugs in usb midi alsa code?
Date: Fri, 08 Nov 2002 09:17:45 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211080859300.22689-100000@studcom.urz.uni-halle.de>
References: <20021107231105.GC560@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA04206
	for <alsa-devel@alsa-project.org>; Fri, 8 Nov 2002 09:17:48 +0100
In-reply-to: <20021107231105.GC560@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, alsa-devel@alsa-project.org, ws@seh.de
List-Id: alsa-devel@alsa-project.org

Martin Langer wrote:
> So, if my client is aconnected (aconnect 80:0 73:0) I can't catch an error
> with rawmidi trying all four possibilties.

When the sequencer has opened the port, others cannot access it, so that's
OK.

BTW: Does input through the sequencer work?

> If I disconnect (aconnect -x) my keyboard I can produce an error. This
> situation is the only possibility to see an error message and it must be
> "rawmidi -v -i hw:2,0,0". The other three rawmidi options are running fine and
> didn't show an error.
>
> tuba:/usr/local/src/alsa-cvs/alsa-lib/test# ./rawmidi -v -i hw:2,0,0
> Using:
> Input: device hw:2,0,0
> Output: NONE
> ALSA lib rawmidi_hw.c:247:(snd_rawmidi_hw_open) SNDRV_RAWMIDI_IOCTL_INFO failed: No such device
> snd_rawmidi_open hw:2,0,0 failed: -19
> Closing

This happens when you remove the bugfix I mentioned yesterday. Without the
fix, snd_rawmidi_hw_open always asks for the output stream information.
(If you do have that bugfix, you're using some older version of alsa-lib.)

> Yes, "rawmidi -v -i hw:2,0" does his job without
> problems and the message is also different to Fernando's output.

In theory, that means when you use current CVS as it is (with the bugfix),
everything should work on your machine?

I'm slightly confused now. It seems you (Martin/Fernando/Werner) have
different errors.


Regards,
Clemens



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
