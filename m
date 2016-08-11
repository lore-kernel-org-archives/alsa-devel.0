From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v3 0/4] ALSA: seq: obsolete change of address
	limit
Date: Thu, 11 Aug 2016 17:58:30 +0900
Message-ID: <1470905914-16382-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id BBE5F266BA9
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 10:58:39 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

ALSA sequencer core has two types of clients; application and kernel.
For kernel clients, the core should handle data in kernel space, meanwhile
this is achieved with a hack of change of address limit. This should be
purged.

This patchset is a revised version of my previous one:
[alsa-devel] obsolete change of address limit
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/110937.html

Changes in v2:
 - Use '_IOC_SIZE' macro to calculate the size of argument of ioctl command.
 - Keep redundant longer name.
 - Improve comments.
 - Merge some patches relevant to the same features.

Changes in v3:
 - Improve series of patch
 - Use 'dir' field of ioctl command to detect the length of argument

Regards

Takashi Sakamoto (4):
  ALSA: seq: add documentation for snd_seq_kernel_client_ctl
  ALSA: seq: add an alternative way to handle ioctl requests
  ALSA: seq: change ioctl command operation to get data in kernel space
  ALSA: seq: obsolete change of address limit

 sound/core/seq/seq_clientmgr.c | 721 ++++++++++++++++++-----------------------
 sound/core/seq/seq_compat.c    |   7 +-
 2 files changed, 317 insertions(+), 411 deletions(-)

-- 
2.7.4
