From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: bugs in usb midi alsa code?
Date: Thu, 07 Nov 2002 09:10:33 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0211070857080.1450-100000@studcom.urz.uni-halle.de>
References: <20021106114346.GA541@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA14942
	for <alsa-devel@alsa-project.org>; Thu, 7 Nov 2002 09:10:40 +0100
In-reply-to: <20021106114346.GA541@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>, Werner Schweer <ws@seh.de>, Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fernando Pablo Lopez-Lezcano wrote:
> OSS emulation (raw midi interface):
>   Midi input and output works fine on the first port,
> ALSA:
>   input does not seem to work at all.

Werner Schweer wrote:
> same on my Roland/Edirol UA100 (audio + 2 midi ports).

Martin Langer wrote:
> last but not least: same on my Evolution MK-249C keyboard

I don't think the bug is in the snd-usb-audio driver because OSS input
seems to be working.

Please try the following with the rawmidi program in alsa-lib/test:
OSS:         rawmidi -v -I /dev/midix
ALSA direct: rawmidi -v -I /dev/snd/midiCxD0
ALSA Lib:    rawmidi -v -i hw:x,0
ALSA Lib:    rawmidi -v -i hw:x,0,0

Did you update alsa-lib together with alsa-kernel? Are you sure you have
the correct version of libasound installed, and your programs are using
it?


HTH
Clemens



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
