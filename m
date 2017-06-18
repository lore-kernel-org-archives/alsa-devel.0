From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH] ALSA: pcm: introduce ACK_APPLPTR flag and
	bump up interface version to v2.0.14
Date: Mon, 19 Jun 2017 01:49:18 +0900
Message-ID: <20170618164921.9881-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id C20C6266D55
 for <alsa-devel@alsa-project.org>; Sun, 18 Jun 2017 18:49:26 +0200 (CEST)
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
Cc: vinod.koul@intel.com, subhransu.s.prusty@intel.com, alsa-devel@alsa-project.org, clemens@ladisch.de, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset includes commits for both kernel/user land for an issue
addressed in this message thread[1].

In a development period for v4.13, it's clear that there's a type of
devices which demand userspace applications to change their behaviour.
These devices can take care of application-side pointer on PCM buffer
for their data transmission. As a result, these devices achieve some
advantages. For these devices, drivers need to get feedback about
current position of the pointer from applications when they
queue/dequeue PCM frames on the buffer.

ALSA PCM core partly assist the above design. The core can call a
handler in driver side when applications operate PCM frames by
ioctl(2) with SNDRV_PCM_IOCTL_[READ|WRITE][N|I] command. However,
when operating for mapped PCM buffer, it can't assist applications
for the above design. In this scenario, applications should call
ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR after handle any PCM frames on
the buffer.

This patchset bumps up interface version with new info flag to
notify the above change to user land developers. This patchset is
written with below ideas:

1. Stuffs in user land can tell their assists for the above design
   to kernel land by using hw_param flag. When they don't assist,
   they see on hw_params data that mmap operation is not supported.
2. Drivers can acknowledge the above flag. When registering
   appropriate PCM rules in advance, they can calculate values for
   each parameters in both cases that stuffs in user land can/cannot
   assist it. This is useful for packet-oriented drivers to judge
   utilizing any interrupt context for packetization.
3. This is device-specific issue, independently of platform
   architecture. On x86/ppc/alpha platforms, status/control data of
   PCM substream is still available in process' VMA of application via
   page frame mapping.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2017-June/121438.html

For kernel land:
Takashi Sakamoto (1):
  ALSA: pcm: introduce ACK_APPLPTR flag and bump up interface version to
    2.0.14

 include/uapi/sound/asound.h | 11 ++++++++++-
 sound/core/pcm_native.c     | 25 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)

For user land:
Takashi Sakamoto (2):
  ALSA: pcm: introduce ACK_APPLPTR flag and bump up interface version to
    2.0.14
  pcm: add support for interface version 2.0.14

 include/sound/asound.h | 11 ++++++++++-
 src/pcm/pcm_hw.c       | 43 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 47 insertions(+), 7 deletions(-)

-- 
2.11.0
