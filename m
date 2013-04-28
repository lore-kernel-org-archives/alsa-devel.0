From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] snd-firewire-lib: add handling CMP output connection
Date: Sun, 28 Apr 2013 13:59:46 +0900
Message-ID: <1367125189-377-1-git-send-email-o-takashi@sakamocchi.jp>
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
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Current implementation of snd-firewire-lib can handle only CMP input
connection. This series of patch enable it to handle both CMP output and input
connection according to IEC 61883-1.

Note that this series of patch still supports only a point-to-point connection
without overlaying. The overlaying and any broadcast connection are not
supported. Each connections gain its own isochronous resource.

Takashi Sakamoto (3):
  rename macros, variables and functions related to CMP plug
  Add "direction" member to cmp_connection structure
  Add handling CMP output connection

 sound/firewire/cmp.c      |  192 +++++++++++++++++++++++++++++++++------------
 sound/firewire/cmp.h      |   13 ++-
 sound/firewire/speakers.c |    2 +-
 3 files changed, 152 insertions(+), 55 deletions(-)

-- 
1.7.10.4


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
