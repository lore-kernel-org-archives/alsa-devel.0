From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: problem while opening device
Date: Tue, 06 Apr 2004 14:19:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4072AE77.8060109@superbug.demon.co.uk>
References: <028301c41bc8$650f30c0$f8b6a8c0@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <028301c41bc8$650f30c0$f8b6a8c0@ent.ti.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: pavans@india.ti.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pavana Sharma wrote:
> Hi,
> 
> 	I am running a test application on my alsa driver for arm platform.Driver
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
> 	FYI ..when I use
> 
> 	 cat test.raw > /dev/dsp
> 
> 	 is working.
> 
> 	Thanks
> 	Pavana S
> 

cat /proc/asound/cards

Sounds like your kernel is using low level oss drivers and not alsa for 
that card.

Cheers
James



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
