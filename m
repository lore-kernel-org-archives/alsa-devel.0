From: Adam Tla/lka <atlka@pg.gda.pl>
Subject: Re: Re: The obsolence of OSS, Was: big smile
Date: Wed, 25 Feb 2004 14:20:37 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040225132037.GG8820@sunrise.pg.gda.pl>
References: <Pine.LNX.4.58.0402241536450.1883@pnote.perex-int.cz> <403BC832.4080404@gardena.net> <20040225112021.GE8820@sunrise.pg.gda.pl> <s5hhdxfnzn8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Resent-Message-Id: <200402251321.i1PDL7cL014353@sunrise.pg.gda.pl>
Content-Disposition: inline
In-Reply-To: <s5hhdxfnzn8.wl@alsa2.suse.de>
Resent-To: Alsa-devel@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 25, 2004 at 12:53:47PM +0100, Takashi Iwai wrote:
> oh well, this thread can be a troll...
maybe, but all this is for targeting your attention to some weak points
of ALSA ;-(. I am using ALSA on 2.6.3 kernel and testing it all the time.

> - PCM mixing and software MIDI rendering in the kernel space are
>   evil.  if you doubt it, ask on LKML :)
It's just my personal opinion. I am using ALSA mixing in lib and can
observe that this solution is not perfect. Also synchronizing PCM
streams at the sample position means that we couldn't use
MMX or other streaming CPU extensions to optimize mixing.
If you don't want kernel sound mixing then just don't load appropriate
module - and don't use it!! But I do need this possibility.
Generally we could have any device which needs adequate access timing
(video grabber, digital oscilloscope, etc..) so if we could have
appropriate designed kernel interface for this type of devices
using them would be easy. Now any of them need an additional suid daemon
process which is working in realtime. It is a security risk and deadlock
risk also. Generally there should be an ioctl in kernel by which process
could inform scheduler how often it wants to get CPU and how long should
it process its data. Now scheduler (read kernel) should decide if this is
possible to honour such request and treat it appropriatelly.
This approach could be applied to any critical data timing device
access not only sound ones. It is better general approach then working
on many deamon processes.

Also if a process is doing another open call on sound device it should get
additional virtual channel.

 
> 
> - xmms's throughput problem is because of implementation of ALSA
>   plugin.  it has no intermediate buffer and no dedicated audio
>   thread. 
>   it has nothing to do with the design of ALSA itself.
maybe but while using apps working with aoss in dma mode I could 
observe same effect - badly written aoss-lib ;-) ?!

Regards
-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
