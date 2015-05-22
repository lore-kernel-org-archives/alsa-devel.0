From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5 v2] ALSA: firewire-lib: purge restriction of
	synchronization for non-blocking mode
Date: Fri, 22 May 2015 23:00:49 +0900
Message-ID: <1432303254-4192-1-git-send-email-o-takashi@sakamocchi.jp>
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

This patchset renews my previous one.

[alsa-devel] [PATCH 0/4] firewire-lib: purge restriction of synchronization for non-blocking mode
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-May/092086.html

Changes:
 * Use stack to keep calculation result per callback of isochronous receive context.
 * Fix my stupid mistake to compare byte count to quadlet count. (oh...)
 * Rename flag to proper name.
 * Add 4th patch newly for better reading.


Takashi Sakamoto (5):
  ALSA: firewire-lib: add buffer-over-run protection at receiving more
    data blocks than expected
  ALSA: firewire-lib: simplify function to calculate the number of data
    blocks
  ALSA: firewire-lib: pass the number of data blocks in incoming packets
    to outgoing packets
  ALSA: firewire-lib: set streaming error outside of packetization
  ALSA: firewire-lib: remove restriction for non-blocking mode

 sound/firewire/amdtp.c            | 151 ++++++++++++++++++++++++--------------
 sound/firewire/amdtp.h            |   4 +
 sound/firewire/oxfw/oxfw-stream.c |  10 ++-
 3 files changed, 106 insertions(+), 59 deletions(-)

-- 
2.1.4


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
