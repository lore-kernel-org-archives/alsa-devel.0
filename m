From: Raymond <rayau@netvigator.com>
Subject: PCM Sample Rate
Date: Fri, 15 Jul 2005 19:25:10 +0800
Message-ID: <42D79D16.40200@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

According to the press release of au8810

Sample Rate Converter:
The AU8810 sample rate converter handles 16 independent audio streams at 
ratios ranging from 8:1 to 1:8. The converter can automatically track 
the conversion ratio between two independent sample rates or can convert 
to a fixed frequency locking to either its input or output.

6000 : 48000 = 1 : 8

It seem to me that the .rate_min is 6000 instead of 5000 in
snd_vortex_playback_hw_adb

Is there any tool/test to verify that sample rate of 5000 Hz is 
supported or not ?





-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
