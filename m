From: "Gupta, Kshitij" <kshitij@ti.com>
Subject: RE: problem while opening device
Date: Tue, 6 Apr 2004 18:33:29 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <F509E6111989D311B63700805FA761DA0D82DF50@DBDE01>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Jaroslav Kysela' <perex@suse.cz>, Pavana Sharma <pavans@india.ti.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi Jaroslav,
	This file is present.  The only other thing which I wanted to bring
into your notice is that the file system we are using is a busybox file
system, with no bash.  Instead it has smaller shell ash.  Will that make a
difference.
And this file /usr/share/alsa/alsa.conf is only meant to be read ??? 
Some other points :
- Alsa driver is statically loaded into the kernel.  We are also able to see
that /proc/asound directory is being populated correctly.
- the /dev/snd nodes are like this 
 
hwC0D0     midiC0D1   midiC2D2   pcmC0D1p   pcmC1D2c   pcmC2D2p   pcmC3D3c
hwC0D1     midiC0D2   midiC2D3   pcmC0D2c   pcmC1D2p   pcmC2D3c   pcmC3D3p
hwC0D2     midiC0D3   midiC2D4   pcmC0D2p   pcmC1D3c   pcmC2D3p   pcmC3D4c
hwC0D3     midiC0D4   midiC2D5   pcmC0D3c   pcmC1D3p   pcmC2D4c   pcmC3D4p
hwC1D0     midiC0D5   midiC2D6   pcmC0D3p   pcmC1D4c   pcmC2D4p   pcmC3D5c
hwC1D1     midiC0D6   midiC2D7   pcmC0D4c   pcmC1D4p   pcmC2D5c   pcmC3D5p
hwC1D2     midiC0D7   midiC3D0   pcmC0D4p   pcmC1D5c   pcmC2D5p   pcmC3D6c
hwC1D3     midiC1D0   midiC3D1   pcmC0D5c   pcmC1D5p   pcmC2D6c   pcmC3D6p
hwC2D0     midiC1D1   midiC3D2   pcmC0D5p   pcmC1D6c   pcmC2D6p   pcmC3D7c
hwC2D1     midiC1D2   midiC3D3   pcmC0D6c   pcmC1D6p   pcmC2D7c   pcmC3D7p
hwC2D2     midiC1D3   midiC3D4   pcmC0D6p   pcmC1D7c   pcmC2D7p   seq
hwC2D3     midiC1D4   midiC3D5   pcmC0D7c   pcmC1D7p   pcmC3D0c   timer

Do some older versions use hw00 as nodes ???

- Is there a way around these aliases "hw:0,0" ....like can;t we open the
device without this alias ???

warm regards
-kshitij

-----Original Message-----
From: alsa-devel-admin@lists.sourceforge.net
[mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Jaroslav
Kysela
Sent: Tuesday, April 06, 2004 6:20 PM
To: Pavana Sharma
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] problem while opening device


On Tue, 6 Apr 2004, Pavana Sharma wrote:

> Hi,
> 
> 	I am running a test application on my alsa driver for arm
platform.Driver
> is statically built.
> 	The test application calls the snd_pcm_open.
> 	With device hw:0,0
> 
> 	At the target I have created sound driver files with snddevices.sh
> 	In /proc/asound i have the soundcard registered as card0 .
> 	Can anyone give ideas where can be the problem ..??
> 
> 	this is the error msg I am getting..
> ----------------snip-----------
> ALSA lib pcm.c:1947:(snd_pcm_open_noupdate) Unknown PCM hw:0,0
> --------------------------------

/usr/share/alsa/alsa.conf is missing.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
