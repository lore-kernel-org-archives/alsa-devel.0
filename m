From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 0/2 v2] alsa-lib: dynamically adapt the
	avail_min on the slave
Date: Mon, 19 Dec 2016 12:37:49 +0900
Message-ID: <20161219033751.30848-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 876F5266499
 for <alsa-devel@alsa-project.org>; Mon, 19 Dec 2016 04:37:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, lgirdwood@gmail.com, broonie@kernel.org, wens@csie.org
Cc: jiada_wang@mentor.com, alsa-devel@alsa-project.org, apape@de.adit-jv.com
List-Id: alsa-devel@alsa-project.org

When configuring avail_min to multiple of slave period size it can happen
that user waits one slave period longer than needed for available data. 
Root cause is implicit grabbing of slave samples in avail_update operation. 
On next entering poll, the slave will wait for the avail_min threshold 
reached again, as he is not aware that there are already pending samples 
in the above layer which are not yet provided to user. 
Solution is to dynamically adapt the avail_min on the slave. 

Andreas Pape (2):
  plugin: dynamically update avail_min on slave
  rate: dynamic update avail_min on slave

 src/pcm/pcm_plugin.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/pcm/pcm_plugin.h |  3 +++
 src/pcm/pcm_rate.c   |  2 +-
 3 files changed, 67 insertions(+), 2 deletions(-)

-- 
2.9.3
