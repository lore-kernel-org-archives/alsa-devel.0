From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [alsa-cvslog] CVS: alsa-kernel/core/oss
	mixer_oss.c,1.38,1.39
Date: Wed, 09 Mar 2005 15:22:30 -0500
Message-ID: <1110399750.10129.1.camel@mindpipe>
References: <E1D8x4I-0002D2-PI@sc8-pr-cvs1.sourceforge.net>
	 <s5hhdjl5gv6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hhdjl5gv6.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <cladisch@users.sourceforge.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-03-09 at 10:05 +0100, Takashi Iwai wrote:
> At Wed, 09 Mar 2005 01:01:26 -0800,
> Clemens Ladisch wrote:
> > 
> > Update of /cvsroot/alsa/alsa-kernel/core/oss
> > In directory sc8-pr-cvs1.sourceforge.net:/tmp/cvs-serv8486
> > 
> > Modified Files:
> > 	mixer_oss.c 
> > Log Message:
> > Summary: fix forgotten release of semaphore in error path
> > 
> > In snd_mixer_oss_get_volume1_vol and snd_mixer_oss_put_volume1_vol,
> > card->controls_rwsem wouldn't be released if the boolean type
> > check fails.

Clemens, should this patch fix OSDL bug 4282?  You mentioned that was
related to a forgotten semaphore release in the same code.

Lee





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
