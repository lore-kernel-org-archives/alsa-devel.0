From: Martin Langer <martin-langer@gmx.de>
Subject: Re: bugs in usb midi alsa code?
Date: Fri, 8 Nov 2002 11:04:28 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021108100427.GA502@tuba.home>
References: <20021107231105.GC560@tuba.home> <Pine.HPX.4.33n.0211080859300.22689-100000@studcom.urz.uni-halle.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id LAA05534
	for <alsa-devel@alsa-project.org>; Fri, 8 Nov 2002 11:04:01 +0100
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0211080859300.22689-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, nando@ccrma.Stanford.EDU, ws@seh.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 08, 2002 at 09:17:45AM +0100, Clemens Ladisch wrote:
> Martin Langer wrote:
> 
> BTW: Does input through the sequencer work?

yes it's working with the same keyboard using classical MIDI OUT jack, not
USB. I have done this:

tuba:~# aconnect 64:0 73:0    /* using classical midi jack works great */
tuba:~# aconnect -x
tuba:~# aconnect 80:0 73:0    /* using usb jack doesn't work: no sound */
tuba:~# aconnect -x
tuba:~# aconnect 64:0 73:0    /* using midi jack works great as before */


> >
> > tuba:/usr/local/src/alsa-cvs/alsa-lib/test# ./rawmidi -v -i hw:2,0,0
> > Using:
> > Input: device hw:2,0,0
> > Output: NONE
> > ALSA lib rawmidi_hw.c:247:(snd_rawmidi_hw_open) SNDRV_RAWMIDI_IOCTL_INFO failed: No such device
> > snd_rawmidi_open hw:2,0,0 failed: -19
> > Closing
> 
> This happens when you remove the bugfix I mentioned yesterday. Without the
> fix, snd_rawmidi_hw_open always asks for the output stream information.
> (If you do have that bugfix, you're using some older version of alsa-lib.)
> 

ooops, my fault. now "rawmidi -v -i hw:2,0,0" runs fine.

> > Yes, "rawmidi -v -i hw:2,0" does his job without
> > problems and the message is also different to Fernando's output.
> 
> In theory, that means when you use current CVS as it is (with the bugfix),
> everything should work on your machine?
> 

Now using cvs checkout from today and it's impossible to produce an error
message with rawmidi. so far it's ok.

With rawmidi I can influence my counter at /proc/asound/card2/midi0 but not
with keyboard playing (the bytes number is constant).

martin


-- 
"2b|!2b"


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
