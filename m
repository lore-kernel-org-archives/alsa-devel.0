From: Kovalyev Sergey <randoman@list.ru>
Subject: Repost about fm801 tea575x_tuner in 2.6 kernels
Date: Tue, 15 Feb 2005 15:50:33 +0600
Message-ID: <4211C5E9.5010708@list.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
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
List-Id: alsa-devel@alsa-project.org

Hello all!

When I trying to do

#modprobe snd_fm801 tea575x_tuner=1

I see this thing in my syslog:

kernel: videodev: "TEA5757 radio" has no release callback. Please fix 
your driver for proper sysfs
support, see http://lwn.net/Articles/36850/

As far as I understand, this module is not compatible with linux-2.6 
kernels, so, how to fix this problem?


WBR, RandoMan.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
