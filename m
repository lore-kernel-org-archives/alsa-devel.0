From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 24/44] fireworks: Add MIDI interface
Date: Mon, 07 Apr 2014 21:59:35 +0900
Message-ID: <5342A137.9000003@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
	<1395400229-22957-25-git-send-email-o-takashi@sakamocchi.jp>
	<533DD083.10506@ladisch.de> <53414287.4050801@sakamocchi.jp>
	<53416A36.6060603@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <53416A36.6060603@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

(Apr 6 2014 23:52), Clemens Ladisch wrote:
> The fast path of mutex_(un)lock already is quite heavily optimized.
> Optimizations should not be added unless they are actually needed; in
> this case, the difference would not be noticeable, especially because
> none of these functions are called frequently.  (But if the code using
> atomic_t ends up being simpler, there's no reason not to use it.)

OK. I should not have mentioned about optimization.

My intent to add stream.c is to make it simple for PCM/MIDI 
functionalities to handle streams.

When needing to start streams, PCM/MIDI functionalities increment 
reference counter and call stream_start_duplex(). Then needed streams 
are started.

When needing to stop streams, PCM/MIDI functionalities decrement 
reference counter and call stream_stop_duplex(). Then needless streams 
are stopped.

In both cases, function call following to changing reference counter. 
But for PCM functionality, these must be separated because of .prepare() 
call at XRUN. When XRUN occurs, application may call snd_pcm_prepare(). 
Then reference counter should not be incremented.

I use this way for fireworks/bebob drivers. So I hope to keep the codes 
simple and safe to avoid large mistakes.

In this reason, I prefer to use mutex for function itself and atomic_t 
for reference counter. If both of them must protected with mutex, it 
brings more codes for PCM/MIDI functionalities. I want to avoid this.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp


------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees_APR
