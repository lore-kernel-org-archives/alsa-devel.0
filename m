From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/27 v2] ALSA: seq: obsolete change of address
	limit
Date: Mon,  8 Aug 2016 23:54:26 +0900
Message-ID: <1470668093-31027-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 711FD2670F5
 for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2016 16:55:00 +0200 (CEST)
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

For purpose of this patchset, please refer to my previous post:
[alsa-devel] obsolete change of address limit
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/110937.html

Changes in v2:
 - Use '_IOC_SIZE' macro to calculate the size of argument of ioctl command.
 - Keep redundant longer name.
 - Improve comments.
 - Merge some patches relevant to the same features.

I give up using 'dir' field in each ioctl command to decide copying, because
some ioctl commands for ALSA sequencer core includes bugs against actual
implementations.

Takashi Sakamoto (27):
  ALSA: seq: add const qualifier to table of functions for ioctl
  ALSA: seq: fulfill callback entry for ioctl
  ALSA: seq: copy ioctl data from user space to kernel stack
  ALSA: seq: add documentation for snd_seq_kernel_client_ctl
  ALSA: seq: obsolete address mode in compatibility layer
  ALSA: seq: obsolete change of address limit in in-kernel path for
    ioctl
  ALSA: seq: obsolete address limit helper
  ALSA: seq: optimize pversion function to new design
  ALSA: seq: optimize client_id function to new design
  ALSA: seq: optimize system_info function to new design
  ALSA: seq: optimize running mode function to new design
  ALSA: seq: optimize get/set_client_info function to new design
  ALSA: seq: optimize create/delete_port function to new design
  ALSA: seq: optimize get/set_port_info function to new design
  ALSA: seq: optimize subscribe_port function to new design
  ALSA: seq: optimize create/delete_queue function to new design
  ALSA: seq: optimize get/set_queue_info function to new design
  ALSA: seq: optimize get/set_queue_info function to new design
  ALSA: seq: optimize get_named_queue function to new design
  ALSA: seq: optimize get_queue_status function to new design
  ALSA: seq: optimize get/set_queue_tempo function to new design
  ALSA: seq: optimize get/set_queue_timer function to new design
  ALSA: seq: optimize get/set_queue_client function to new design
  ALSA: seq: optimize get/set_client_pool function to new design
  ALSA: seq: optimize remove_events function to new design
  ALSA: seq: optimize get_subscription function to new design
  ALSA: seq: optimize query functions for subscribes, next client and
    port to new design

 sound/core/seq/seq_clientmgr.c | 750 +++++++++++++++++++----------------------
 sound/core/seq/seq_compat.c    |  26 +-
 2 files changed, 353 insertions(+), 423 deletions(-)

-- 
2.7.4
