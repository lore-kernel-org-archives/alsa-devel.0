From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 0/3] snd-firewire-lib: add handling CMP
	output connection
Date: Mon, 29 Apr 2013 18:44:00 +0900
Message-ID: <1367228643-8451-1-git-send-email-o-takashi@sakamocchi.jp>
References: <1367125189-377-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id A8736261A08
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 11:44:09 +0200 (CEST)
In-Reply-To: <1367125189-377-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
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

 sound/firewire/cmp.c      |  188 +++++++++++++++++++++++++++++++++------------
 sound/firewire/cmp.h      |   13 +++-
 sound/firewire/speakers.c |    2 +-
 3 files changed, 148 insertions(+), 55 deletions(-)

-- 
1.7.10.4
