From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 0/3] ALSA: pcm: add 'applptr' event of
	tracepoint
Date: Mon, 12 Jun 2017 09:41:43 +0900
Message-ID: <20170612004146.28835-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 12F79266D83
 for <alsa-devel@alsa-project.org>; Mon, 12 Jun 2017 02:41:52 +0200 (CEST)
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
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

This is an update version of my previous patchset.

[alsa-devel] [PATCH 0/3] ALSA: pcm: add 'applptr' event of tracepoint
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-June/121657.html

Chagnes from v1:
 - rewrite change log for second patch, including content of cover letter
   in my previous patchset, according to advice from maintainer.

In design of ALSA PCM core, both of hardware-side and application-side
position on PCM buffer are maintained as a part of information for
runtime of PCM substream. In a view of ALSA PCM application, these two
positions can be updated by executing ioctl(2) with some commands.

There's an event of tracepoint for hardware-side position; 'hwptr'.
On the other hand, no events for application-side position.

This patchset adds a new event for this purpose; 'applptr'. When
the application-side position is changed in kernel space, this event
is probed with useful information for developers.

The event is not probed for all of ALSA PCM applications, In detail,
please read second patch.

Takashi Sakamoto (3):
  ALSA: pcm: unify codes to operate application-side position on PCM
    buffer
  ALSA: pcm: add 'applptr' event of tracepoint
  ALSA: pcm: use %s instead of %c for format of PCM buffer tracepoints

 sound/core/pcm_lib.c    | 31 +++++++++++++++++++++++++++---
 sound/core/pcm_local.h  |  2 ++
 sound/core/pcm_native.c | 28 ++++-----------------------
 sound/core/pcm_trace.h  | 50 +++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 78 insertions(+), 33 deletions(-)

-- 
2.11.0
