From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: oxfw: implement retries for scs1x at
	transaction failure
Date: Fri, 19 Feb 2016 09:55:48 +0900
Message-ID: <1455843350-10156-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 601B32606F6
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 01:55:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

Current ALSA oxfw driver has a TODO to retry IEEE 1394 asynchronous
transactions when transaction failure occurs. This patchset is for it.
Additionally, this patchset classifies reason of the failure and stop
the retries to prevent from endless loop of scheduling work.

Regards

Takashi Sakamoto (2):
  ALSA: oxfw: retry MIDI transferring for scs1x at transaction failure
  ALSA: oxfw: discontinue MIDI substream for scs1x at transaction
    failure

 sound/firewire/oxfw/oxfw-scs1x.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

-- 
2.5.0
