From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: bugs in usb midi alsa code?
Date: Thu, 7 Nov 2002 10:54:10 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211071037490.16062-100000@cmn37.stanford.edu>
References: <Pine.HPX.4.33n.0211070857080.1450-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA23995
	for <alsa-devel@alsa-project.org>; Thu, 7 Nov 2002 19:54:49 +0100
In-Reply-To: <Pine.HPX.4.33n.0211070857080.1450-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Martin Langer <martin-langer@gmx.de>, Werner Schweer <ws@seh.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > OSS emulation (raw midi interface):
> >   Midi input and output works fine on the first port,
> > ALSA:
> >   input does not seem to work at all.
> 
> Werner Schweer wrote:
> > same on my Roland/Edirol UA100 (audio + 2 midi ports).
> 
> Martin Langer wrote:
> > last but not least: same on my Evolution MK-249C keyboard
> 
> I don't think the bug is in the snd-usb-audio driver because OSS input
> seems to be working.

Yes, it is weird...

> Please try the following with the rawmidi program in alsa-lib/test:
> OSS:         rawmidi -v -I /dev/midix

  ./rawmidi -v -I /dev/midi1 --> works fine

> ALSA direct: rawmidi -v -I /dev/snd/midiCxD0

  ./rawmidi -v -I /dev/snd/midiC1D0 --> works fine

> ALSA Lib:    rawmidi -v -i hw:x,0

./rawmidi -v -i hw:1,0
Using: 
Input: device hw:1,0
Output: NONE
ALSA lib rawmidi.c:247:(snd_rawmidi_open_conf) symbol _snd_rawmidi_hw_open 
is not defined inside (null)
snd_rawmidi_open hw:1,0 failed: -6
Closing

> ALSA Lib:    rawmidi -v -i hw:x,0,0

Same as the previous test.

> Did you update alsa-lib together with alsa-kernel? Are you sure you have
> the correct version of libasound installed, and your programs are using
> it?

alsa-driver, alsa-kernel, alsa-lib and alsa-utils are compiled and 
installed from the same source tree (or so I think). 

-- Fernando



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
