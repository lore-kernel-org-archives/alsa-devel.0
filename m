From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: undefined reference to `snd_pcm_hw_params_sizeof'
Date: Wed, 17 Mar 2004 12:20:49 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403171220350.1829@pnote.perex-int.cz>
References: <1078416129.1865.868.camel@renegade>
 <0CC09933-7805-11D8-A740-000A95AB8A40@hollingsworth.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <0CC09933-7805-11D8-A740-000A95AB8A40@hollingsworth.com.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tim Hollingsworth <tim@hollingsworth.com.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 17 Mar 2004, Tim Hollingsworth wrote:

> Hi
> 
> I'm a newbie with alsa and rusty with c.  I am trying to get a basic 
> pcm application going.  I have:
> 
> 	#include <alsa/asoundlib.h>
> 
> but when I try to:
> 
> 	snd_pcm_hw_params_alloca(&hwparams);
> 
> I get:
> 
> /tmp/ccJB6E1d.o(.text+0x18): In function `initSound':
> : undefined reference to `snd_pcm_hw_params_sizeof'
> /tmp/ccJB6E1d.o(.text+0x31): In function `initSound':
> : undefined reference to `snd_pcm_hw_params_sizeof'
> collect2: ld returned 1 exit status

gcc -lasound <your_c_file>

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
