From: "Pavana Sharma" <pavans@india.ti.com>
Subject: RE: problem while opening device
Date: Tue, 6 Apr 2004 18:17:29 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <028601c41bd5$52ee27e0$f8b6a8c0@ent.ti.com>
References: <20040406134104.190e8c31.mista.tapas@gmx.net>
Reply-To: <pavans@india.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040406134104.190e8c31.mista.tapas@gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Florian Schmidt' <mista.tapas@gmx.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

chekout these versions ..I am using,

>> which version of alsa-drivers do you use [cat /proc/asound/version]?
Advanced Linux Sound Architecture Driver Version 1.0.2c (Thu Feb 05 15:41:49
2004 UTC).

>>which verison of alsa-utils do  you use [aplay --version]
aplay: version 1.0.3 by Jaroslav Kysela <perex@suse.cz>

>>which version of alsa-lib do you use? [$EDITOR
/usr/include/alsa/version.h]?
 SND_LIB_VERSION_STR "1.0.3"

Thanks
Pavana S

-----Original Message-----
From: Florian Schmidt [mailto:mista.tapas@gmx.net]
Sent: Tuesday, April 06, 2004 5:11 PM
To: pavans@india.ti.com
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] problem while opening device


On Tue, 6 Apr 2004 16:44:56 +0530
"Pavana Sharma" <pavans@india.ti.com> wrote:

> Hi,
>
> 	I am running a test application on my alsa driver for arm
> 	platform.Driver
> is statically built.
> 	The test application calls the snd_pcm_open.
> 	With device hw:0,0
>
> 	At the target I have created sound driver files with
> 	snddevices.sh In /proc/asound i have the soundcard registered as
> 	card0 . Can anyone give ideas where can be the problem ..??
>
> 	this is the error msg I am getting..
> ----------------snip-----------
> ALSA lib pcm.c:1947:(snd_pcm_open_noupdate) Unknown PCM hw:0,0
> --------------------------------
> 	FYI ..when I use
>
> 	 cat test.raw > /dev/dsp
>
> 	 is working.

I would think that this sounds like a version mismatch. How do i come to
this result? Well, alsamodules seem to be laoded fine [as you have
checked /proc/asound/cards]. Oss emu is working too [as you /dev/dsp
test shows]. The OSS emu [modules] don't interact with alsa-lib. But the
pcm-test program uses alsa-lib..

which version of alsa-drivers do you use [cat /proc/asound/version]?
which verison of alsa-utils do  you use [aplay --version]
which version of alsa-lib do you use? [$EDITOR
/usr/include/alsa/version.h]?

Flo

P.S.: oh i just see you use ARM. I have no idea, if that platform has
specific issues, so this post could be void afterall..

--
kT




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
