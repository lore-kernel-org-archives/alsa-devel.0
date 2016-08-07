From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 00/39] seq: obsolete change of address limit
Date: Sun,  7 Aug 2016 18:48:36 +0900
Message-ID: <1470563355-18368-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 722A826589D
 for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2016 11:49:36 +0200 (CEST)
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

ALSA sequencer core has two types of client; user application and kernel
driver. The core allows both types of client to do relevant operations,
thus it's required for the core to handle data in both user and kernel
spaces.

Currently, this is achieved by changing address limit of running task.
This is a well-known technique to suppress address check, while it's
just a suppression and unfriendly to readers or static code parsers. 

This patchset obsoletes the usage. In process context, data in user space
is once copied to kernel space, then operated and copied to user space.
As a result, actual operations for each ioctl command handle data in kernel
space, and '__user' qualifier is useless.

In this series, patch 1-8 just apply above design. The rest changes each
operation following to the design. Therefore, static code parser like
sparce generates warnings temporarily in a way to apply these patches.

There's a concern of this solution. The data for ioctl is always copied to
kernel space or to kernel space even when it's read-only or write-only. But
this brings no severe issue as long as I read ALSA sequencer core.

(This patchset is a part of my work to introduce EPIPE into ALSA rawmidi
core.)

Takashi Sakamoto (39):
  ALSA: seq: add const qualifier to table of functions for ioctl
  ALSA: seq: apply shorter name for file local functions
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
  ALSA: seq: optimize client_info function to new design
  ALSA: seq: optimize set_client_info function to new design
  ALSA: seq: optimize create_port function to new design
  ALSA: seq: optimize delete_port function to new design
  ALSA: seq: optimize get_port_info function to new design
  ALSA: seq: optimize seq_port_info function to new design
  ALSA: seq: optimize subscribe_port function to new design
  ALSA: seq: optimize unsubscribe_port function to new design
  ALSA: seq: optimize create_queue function to new design
  ALSA: seq: optimize delete_queue function to new design
  ALSA: seq: optimize get_queue_info function to new design
  ALSA: seq: optimize seq_queue_info function to new design
  ALSA: seq: optimize get_named_queue function to new design
  ALSA: seq: optimize get_queue_status function to new design
  ALSA: seq: optimize get_queue_tempo function to new design
  ALSA: seq: optimize set_queue_tempo function to new design
  ALSA: seq: optimize get_queue_timer function to new design
  ALSA: seq: optimize seq_queue_timer function to new design
  ALSA: seq: optimize get_queue_client function to new design
  ALSA: seq: optimize set_queue_client function to new design
  ALSA: seq: optimize get_client_pool function to new design
  ALSA: seq: optimize seq_client_pool function to new design
  ALSA: seq: optimize remove_events function to new design
  ALSA: seq: optimize get_subscription function to new design
  ALSA: seq: optimize query_subs function to new design
  ALSA: seq: optimize query_next_client function to new design
  ALSA: seq: optimize query_next_port function to new design

 sound/core/seq/seq_clientmgr.c | 854 +++++++++++++++++++----------------------
 sound/core/seq/seq_compat.c    |  26 +-
 2 files changed, 407 insertions(+), 473 deletions(-)

-- 
2.7.4
