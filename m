From: Martin Langer <martin-langer@gmx.de>
Subject: Re: bugs in usb midi alsa code?
Date: Thu, 7 Nov 2002 10:37:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021107093720.GB541@tuba.home>
References: <20021106114346.GA541@tuba.home> <Pine.HPX.4.33n.0211070857080.1450-100000@studcom.urz.uni-halle.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id KAA15995
	for <alsa-devel@alsa-project.org>; Thu, 7 Nov 2002 10:35:54 +0100
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0211070857080.1450-100000@studcom.urz.uni-halle.de>
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

On Thu, Nov 07, 2002 at 09:10:33AM +0100, Clemens Ladisch wrote:
> 
> I don't think the bug is in the snd-usb-audio driver because OSS input
> seems to be working.
> 
> Please try the following with the rawmidi program in alsa-lib/test:
> OSS:         rawmidi -v -I /dev/midix
> ALSA direct: rawmidi -v -I /dev/snd/midiCxD0
> ALSA Lib:    rawmidi -v -i hw:x,0
> ALSA Lib:    rawmidi -v -i hw:x,0,0
> 

it starts correctly and hangs finally after the Output line: 

tuba:/usr/local/src/alsa-cvs/alsa-lib/test# ./rawmidi -v -i hw:2,0
Using: 
Input: device hw:2,0
Output: NONE

> Did you update alsa-lib together with alsa-kernel? Are you sure you have
> the correct version of libasound installed, and your programs are using
> it?
> 

yes, I'm always doing a "make build" which is diving in each directory and
executing ./cvscompile. So I think everything is freshly build on my machine.
If not correct me please.

tuba:/usr/local/src/alsa-cvs/alsa-lib/test# ldconfig -v|grep libasound
        libasound.so.2 -> libasound.so.2.0.0
	libasound.so.1 -> libasound.so.1.0.1

The program I was using is aconnect doing a simple connection between OPL3
and my keyboard. Aconnect was even freshly build and the opl3 works fine
playing midi files with pmidi.

Sorry, but I can't find another interesting information. The interfaces are
there. The only thing I miss is some data from midi input, but the hanging
rawmidi process is a good starting point.


martin


-- 
"2b|!2b"


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
