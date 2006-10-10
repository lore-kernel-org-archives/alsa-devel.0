From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: RFC: provide a device name list for applications
Date: Tue, 10 Oct 2006 15:55:04 +0100
Message-ID: <1160492104.24436.76.camel@localhost.localdomain>
References: <Pine.LNX.4.61.0610101530410.9410@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0610101530410.9410@tm8103.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-10-10 at 15:45 +0200, Jaroslav Kysela wrote:
> Hi,
> 
> 	here is my proposal to provide (a long waited feature) a device 
> name list for applications (especially for GUI). The work is not finished, 
> but the patch bellow gives already useful hints like (for PCM devices):
> 
> hw:CARD=Intel,DEV=0
> hw:CARD=Intel,DEV=1
> hw:CARD=Intel,DEV=2
> hw:CARD=Intel,DEV=6
> plughw:CARD=Intel,DEV=0
> plughw:CARD=Intel,DEV=1
> plughw:CARD=Intel,DEV=2
> plughw:CARD=Intel,DEV=6
> plug
> shm
> tee
> file
> null
> 
> 	Things to do:
> 
> - provide device description behind '|' separator - add this description
>   to configuration files
> - some virtual devices does not make sense without arguments (like file) -
>   add a list off switch 
> - gather virtual devices from configuration files probably from
>   namehint.pcm tree:
> 
> namehint.pcm [
> 	"file:FILE=/tmp/soundwave.raw|Save sound output to /tmp/soundwave.raw file"
> 	"plug:front|Do all conversions for front speakers"
> ]
> 
> - sorting / ordering of resulted hints? any hints from you? ;-) maybe add
>   a wieght to config files?

I'd like to be able to add hints on pcm usage. e.g. Consider an embedded
system where there is a HiFi DAC, voice DAC and Aux DAC.

00-02: WM9713 Voice WM9713 Voice-PCM-2 :  : playback 1 : capture 1
00-01: AC97 Aux AC97 Aux-AC97-1 :  : playback 1
00-00: AC97 HiFi AC97 HiFi-AC97-0 :  : playback 1 : capture 1 

The intended usage for each DAC would be as follows:-

 HiFi DAC - High quality (multimedia playback) music/video players would
use this pcm by default.

 Voice DAC - Cell/Phone/VOIP calls (lower power consumption DAC -
optimised for voice) telephony apps would use this pcm by default.

 Aux DAC - System noises/phone ringer (lower quality and power),
system/ringer would use this by default.

It would be nice if the applications could determine the best pcm to use
based upon this hint (or similar). Atm, it either has to be hard coded
or set up in the applications config/start up scripts.

This would eventually allow applications (esp in embedded space) to
become more portable between different machines (without the need to
re-configure). 

Liam 



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
