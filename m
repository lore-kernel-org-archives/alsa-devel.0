From: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Subject: Re: Question regarding current ESS Maestro 3M soundcard support
Date: Tue, 12 Feb 2002 12:04:53 +0000
Message-ID: <20020212120453.E30307@ecs.soton.ac.uk>
References: <000101c1b36d$036851a0$ac1f830a@ico>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from ecs.soton.ac.uk (inanna.ecs.soton.ac.uk [152.78.65.48])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA21741
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2002 13:04:56 +0100
Received: (from swh@localhost)
	by ecs.soton.ac.uk (8.11.6/8.11.2) id g1CC4sc31688
	for alsa-devel@alsa-project.org; Tue, 12 Feb 2002 12:04:54 GMT
Content-Disposition: inline
In-Reply-To: <000101c1b36d$036851a0$ac1f830a@ico>; from ico@fuse.net on Mon, Feb 11, 2002 at 09:28:53 -0500
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 11, 2002 at 09:28:53 -0500, Ivica Bukvic wrote:
> Hi all!
> 
> I have an Dell Inspiron 8K and my question is whether the current
> Maestro M3 chip is fully supported or does it currently only furnish
> SB16 compatibility mode (I might be talking nonsense here, but this is

I have an 8100 (Maestro 3i). The ALSA support is basicly OK, but things
like jack cause some problems with CPU use, I haven't been able to track it
down, but it might be something simple.

The OSS emaultion layer and simplex playback seem to work fine however.

I suspect that the output only alsa driver for jack would solve a lot of
my problems, and the mic/line input on the M3 is terrible anyway.

My medium term plan is to write a raw ethernet/IEEE-1394 driver+client
pair for jack that allows you to shunt float audio data over to the laptop
from a desktop (with some useful audio hardware in it) and back again.  I
will probably start with raw ethernet packets as I know how to do that, it
may have latency problems though. I have tried IP packets (with ll patched
linux 2.4 and 3com 905's) and that was no good.

The driver would run on the laptop and provide sync'd audio to the jack
clients and the client would run on the desktop machine as a sync slave of
the audio hardware.

- Steve

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
