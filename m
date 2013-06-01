From: o-takashi@sakamocchi.jp
Subject: [PATCH 0/2] snd-firewire-lib: add MIDI stream support
Date: Sun,  2 Jun 2013 00:25:35 +0900
Message-ID: <1370100337-22463-1-git-send-email-o-takashi@sakamocchi.jp>
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
To: perex@perex.cz, clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

This series of patch add MIDI stream support to snd-firewire-lib according to
IEC 61883-6 and MMA/AMEI RP-027.

This series of patch is based on my previous patches for snd-firewire-lib.

[PATCH v2 0/3] snd-firewire-lib: add handling CMP output connection
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-April/061607.html

[PATCH v2 0/4] snd-firewire-lib: add handling AMDTP receive stream
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-April/061611.html

Takashi Sakamoto (2):
  Add amdtp_stream_running() and amdtp_stream_pcm_running()
  Add MIDI stream support with data rate restriction

 sound/firewire/amdtp.c |  171 +++++++++++++++++++++++++++++++++++++++++++-----
 sound/firewire/amdtp.h |   37 +++++++++++
 2 files changed, 193 insertions(+), 15 deletions(-)

-- 
1.7.10.4


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
