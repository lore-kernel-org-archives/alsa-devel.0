From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] firewire-lib: purge restriction of synchronization for
	non-blocking mode
Date: Sat, 16 May 2015 20:22:41 +0900
Message-ID: <1431775365-25211-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This patchset allows non-blocking streams to use timestamp synchronization.

In full duplex synchronization mode, current implementation pass the value
of 'syt' field of CIP header in incoming packets to outgoing packet
processing, while the number of data blocks is not passed. Therefore,
this mode is allowed just to blocking streams, because of a lack of
validator for the number which actual devices transfers. As long as the
number is suspicious, it's not reused to outgoing packet processing.

To allow the synchronization mode to non-blocking streams, this patchset:
 * adds a validator for the number of data blocks in incoming packets
 * adds a flag still to support illegal models (i.e. Behringer FCA202)
 * pass the evaluated number from incoming packet processing to outgoing
 * remove the restriction


Takashi Sakamoto (4):
  ALSA: firewire-lib: add buffer-over-run protection at receiving more
    data blocks than expected
  ALSA: firewire-lib: simplify function to calculate the number of data
    blocks
  ALSA: firewire-lib: pass the number of data blocks in incoming packets
    to outgoing packets
  ALSA: firewire-lib: remove restriction for non-blocking mode

 sound/firewire/amdtp.c            | 108 ++++++++++++++++++++++++--------------
 sound/firewire/amdtp.h            |   4 ++
 sound/firewire/oxfw/oxfw-stream.c |  10 +++-
 3 files changed, 81 insertions(+), 41 deletions(-)

-- 
2.1.4


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
