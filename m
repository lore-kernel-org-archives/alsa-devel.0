From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/6] bebob: Improvements for M-Audio specific
	operations
Date: Mon, 21 Jul 2014 11:09:59 +0900
Message-ID: <1405908605-8105-1-git-send-email-o-takashi@sakamocchi.jp>
References: <1405831835-26499-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E3762650D8
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 04:10:13 +0200 (CEST)
In-Reply-To: <1405831835-26499-1-git-send-email-weiyj_lk@163.com>
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
Cc: alsa-devel@alsa-project.org, darrena092@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This series of patch improves some control elements for M-Audio specific
operations. Current implementation includes dead lock and my misunderstanding
about hardware specification and ALSA Control interface.

Takashi Sakamoto (6):
  bebob: Arrangement for critical section to be shorter
  bebob: Reducing function callers for simplicity
  bebob: Add dev_err() for debugging
  bebob: Use different labels for digital input/output interfaces
  bebob: Correction for return value of .put callback functions
  bebob: Arrangement for a control element to which two settings relate

 sound/firewire/bebob/bebob_maudio.c | 181 ++++++++++++++++++++++--------------
 1 file changed, 111 insertions(+), 70 deletions(-)

-- 
1.9.1
