From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-usb-midi vs ohci
Date: Mon, 11 Nov 2002 10:23:11 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211111011030.20273-100000@studcom.urz.uni-halle.de>
References: <3DCD81DA.7030004@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA02957
	for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2002 10:23:18 +0100
In-reply-to: <3DCD81DA.7030004@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> I'm have a machine which needs the ohci usb driver. I have 2.4.19-pre10
> kernel for it.
>
> When I try to load the usb-audio module I get a constant stream of
>
> snd-usb-midi: usb_submit_urb: -22
>
> Which doesn't stop until I remove the module.

In the 2.5.45 kernel, the behaviour of interrupt transfers (used for
Roland and Quattro MIDI input) changed, so snd-usb-midi was changed as
well, but this change was incompatible with earlier kernels.
It's now fixed on CVS.

BTW: please test the MIDI input with "alsa-lib/tests/rawmidi -v -i hw:x,0",
it would be nice to know if the M-Audio protocol support works at all.
I guess the Quattro is sending a stream of Active Sensing bytes (0xfe).


Regards,
Clemens



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
