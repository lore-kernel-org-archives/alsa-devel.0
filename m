From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: alsa dma transfer
Date: Wed, 29 Jun 2005 03:21:50 -0400
Message-ID: <1120029711.1330.4.camel@mindpipe>
References: <9AEDBAA573BBD346BCF9637D80097D911DCCE9@greysvr02.GreyInnovation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <9AEDBAA573BBD346BCF9637D80097D911DCCE9@greysvr02.GreyInnovation.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tehn-Yit Chin <Tehn-Yit.Chin@greyinnovation.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-06-29 at 16:35 +1000, Tehn-Yit Chin wrote:
> And how do I tell pcm layer that the device does not support recording?

I'll let someone else field the first question...

If you don't implement capture in your driver, the PCM layer will not
present any capture devices to userspace.

Lee



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
