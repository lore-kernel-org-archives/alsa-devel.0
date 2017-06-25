From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 alsa-lib 0/6] pcm: hw: maintain fallback
	mode for status/control data separately
Date: Sun, 25 Jun 2017 13:41:18 +0900
Message-ID: <20170625044124.22234-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id EDA72266B55
 for <alsa-devel@alsa-project.org>; Sun, 25 Jun 2017 06:41:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is a revised version for a part of my previous RFC:
[alsa-devel] [alsa-lib][RFC][PATCH 0/9] pcm: handle status/control mapping independently
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-June/122130.html

As I described, we found an advantage to handle results of page mapping
for status/control data separately in a discussion about ALSA PCM protocol
v2.0.14.

In this version, when kernel-land drivers support
SNDRV_PCM_INFO_SYNC_APPLPTR for a certain design of hardware, userspace
applications are expected to issue current position of applptr for several
merits. This should be performed even if applications are programmed to run
with mmap operation for PCM buffer. In the above discussion, the way to
take applications to perform it is one of important issues.

On platforms without enough cache coherency support such as ARM, this
doesn't matter. On the platforms, ALSA PCM core already disallows any
of mappings for the status/control data of runtime of PCM substream.
For this case, userland stuffs were already programmed to go to fallback
mode, in which ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR is used to
issue/query the status/control data. Even if handling PCM frames on PCM
buffer by mmap operation, the position of applptr is issues into ALSA
PCM core by a call of ioctl(2) with the command.

As a solution for old stuffs in userland, the above mechanism is used
for cache coherent architecture such as x86. A patch was already merged
into kernel land[1]. This patch changes behaviours of ALSA PCM core to
disallow userland to map the status/control data according to drivers'
support for SNDRV_PCM_INFO_SYNC_APPLPTR.

However, disallowing mappings for both of status/control data has a slight
overhead to increase calls of ioctl(2), than usual operation on x86. As
I reported[2]. Furthermore, it's clear that current proposals make no
sense for drivers because 'struct snd_pcm_ops.ack' in driver implementation
is not called expectedly due to a commit[4]. Even if the applptr is
issued by ioctl(2), the callback is skipped as long as mapped status
includes the updated value for the applptr.

In the above discussion, some solutions were suggested[5]. One of them
is to enable map of the status data and disable map of the control data.
This idea can archive both of the aim of v2.0.14 protocol and reduction
of calls for status data, for newer userland stuffs. 

This patchset for alsa-lib is a preparation for the idea. In current
implementation of this library, results of mapping operation for
status/control data are not handled separately. This patchset is a
similar to code refactoring, thus this includes no essential behaviour
changes against released kernel lands.

[1] ALSA: pcm: Add the explicit appl_ptr sync support
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?id=42f945970af9df6216e3d771b4df371d02d8742c
[2] ALSA: pcm: add 'applptr' event of tracepoint
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?h=for-next&id=fccf53881e9b564321326f62ed5f85130fa6e569
[3] [alsa-devel] [PATCH 0/3] ALSA: Add the explicit appl_ptr sync support
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-June/122092.html
[4] ALSA: pcm: Skip ack callback without actual appl_ptr update
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/commit/?h=for-next&id=f8ff2f28ba49fa41a06215ac3187dede347bc9a7
[5] [alsa-devel] [PATCH 0/3] ALSA: Add the explicit appl_ptr sync support
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-June/122093.html

Takashi Sakamoto (6):
  pcm: hw: add helper functions to map/unmap status/control data for
    runtime of PCM substream
  pcm: hw: add an arrangement for initialization of appl_ptr/avail_min
  pcm: hw: deallocate fallback buffer when trials of unmapping finished
  pcm: hw: allocate fallback buffer in advance of trials of mapping
  pcm: hw: maintain fallback mode for status data mapping
  pcm: hw: maintain fallback mode for control data mapping independently

 src/pcm/pcm_hw.c | 192 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 115 insertions(+), 77 deletions(-)

-- 
2.11.0
