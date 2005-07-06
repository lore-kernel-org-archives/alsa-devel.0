From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: memory leaks
Date: Wed, 06 Jul 2005 13:34:36 -0400
Message-ID: <1120671276.10268.6.camel@mindpipe>
References: <Pine.HPX.4.33n.0507061005010.28308-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0507061005010.28308-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-07-06 at 10:06 +0200, Clemens Ladisch wrote:
> Lee Revell wrote:
> > WHen reloading ALSA modules I got this message:
> > ALSA sound/core/memory.c:80: kmalloc(164) from dc8506f9 not freed
> > ALSA sound/core/memory.c:80: kmalloc(268) from dc850606 not freed
> >
> > These are the closest symbols:
> >
> > dc850590 t snd_hwdep_ioctl      [snd_hwdep]
> > dc850630 t snd_hwdep_mmap       [snd_hwdep]
> > dc850660 t snd_hwdep_control_ioctl      [snd_hwdep]
> >
> > AFAICT this means the leaks are in snd_hwdep_ioctl and control_ioctl.
> 
> These functions don't directly allocate memory, the leak is probably
> in some driver function.  What hwdep device is this?

snd_emu10k1_synth I think.

Lee



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
