From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] snd-firewire-lib: add handling AMDTP receive stream
Date: Sun, 28 Apr 2013 14:02:10 +0900
Message-ID: <1367125334-446-1-git-send-email-o-takashi@sakamocchi.jp>
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

Current implementation of snd-firewire-lib can handle only AMDTP transmit
stream with PCM. This series of patch enable it to handle both AMDTP receive
and transmit stream with PCM according to IEC 61883-6.

I develop with Echo Audio's Fireworks (AudioFirePre8). Unfortunately it's not
fully compliant to IEC 61883-6. The last patch includes some work arounds for
Fireworks. The snd-fireworks is still under development and not prepared for
commit.


Takashi Sakamoto (4):
  Rename functions, structure and member name for AMDTP
  Add macros for fixed value related to AMDTP
  Add "direction" member to amdtp_stream structure for AMDTP
  Add handling AMDTP receive stream

 sound/firewire/amdtp.c    |  422 ++++++++++++++++++++++++++++++++++++---------
 sound/firewire/amdtp.h    |   64 +++----
 sound/firewire/speakers.c |   33 ++--
 3 files changed, 393 insertions(+), 126 deletions(-)

-- 
1.7.10.4


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
