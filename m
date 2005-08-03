From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Problem in testing ALSA
Date: Tue, 02 Aug 2005 21:55:03 -0400
Message-ID: <1123034103.6189.1.camel@mindpipe>
References: <20050803012126.87440.qmail@web54607.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050803012126.87440.qmail@web54607.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chow Raymond <usher_raymond82@yahoo.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-08-02 at 18:21 -0700, Chow Raymond wrote:
> [root@ARMCore /]$ aplay /home/test/decoded_4350.wav
> ALSA lib pcm.c:1962:(snd_pcm_open_noupdate) Unknown
> PCM default
> aplay: main:507: audio open error: No such file or
> directory
> 

No, that probably just means that the default pcm is not defined.  This
is actually a userspace (alsa-lib) problem, it sounds like the kernel
side might be OK.

But, please repost your query, and cc: alsa-devel, because I don't know
that much about the ARM drivers.

Lee



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
