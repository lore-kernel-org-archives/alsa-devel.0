From: Martin Langer <martin-langer@gmx.de>
Subject: Re: bugs in usb midi alsa code?
Date: Thu, 7 Nov 2002 11:21:36 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021107102136.GD541@tuba.home>
References: <20021107093720.GB541@tuba.home> <Pine.HPX.4.33n.0211071107080.7735-100000@studcom.urz.uni-halle.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id LAA16649
	for <alsa-devel@alsa-project.org>; Thu, 7 Nov 2002 11:20:01 +0100
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0211071107080.7735-100000@studcom.urz.uni-halle.de>
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

On Thu, Nov 07, 2002 at 11:09:51AM +0100, Clemens Ladisch wrote:
> Martin Langer wrote:
> > On Thu, Nov 07, 2002 at 09:10:33AM +0100, Clemens Ladisch wrote:
> > > Please try the following with the rawmidi program in alsa-lib/test:
> > > OSS:         rawmidi -v -I /dev/midix
> > > ALSA direct: rawmidi -v -I /dev/snd/midiCxD0
> > > ALSA Lib:    rawmidi -v -i hw:x,0
> > > ALSA Lib:    rawmidi -v -i hw:x,0,0
> >
> > it starts correctly and hangs finally after the Output line:
> >
> > tuba:/usr/local/src/alsa-cvs/alsa-lib/test# ./rawmidi -v -i hw:2,0
> > Using:
> > Input: device hw:2,0
> > Output: NONE
> 
> rawmidi only checks for Ctrl+C after some data has been output.
> 
> Does it work with /dev/midi2 and /dev/snd/midiC2D0?
> 

not really. 

martin



tuba:/usr/local/src/alsa-cvs/alsa-lib/test# ./rawmidi -v -i /dev/midi2
Using: 
Input: device /dev/midi2
Output: NONE
ALSA lib rawmidi.c:278:(snd_rawmidi_open_noupdate) Unknown RawMidi /dev/midi2
snd_rawmidi_open /dev/midi2 failed: -2
Closing

tuba:/usr/local/src/alsa-cvs/alsa-lib/test# ./rawmidi -v -i
/dev/snd/midiC2D0  
Using: 
Input: device /dev/snd/midiC2D0
Output: NONE
ALSA lib rawmidi.c:278:(snd_rawmidi_open_noupdate) Unknown RawMidi
/dev/snd/midiC2D0
snd_rawmidi_open /dev/snd/midiC2D0 failed: -2
Closing



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
