From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][RFC][PATCH 0/9] pcm: handle status/control
	mapping independently
Date: Thu, 22 Jun 2017 23:43:25 +0900
Message-ID: <20170622144334.1306-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id D026F266D8B
 for <alsa-devel@alsa-project.org>; Thu, 22 Jun 2017 16:43:43 +0200 (CEST)
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

This RFC patchset is for recent discussion about new version of PCM
protocol/interface (2.0.14). This is accumulated on the below patchset.
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-June/122066.html

In the discussion, we found an advantage to handle page mapping for
status/control data of runtime of PCM substream independently. Aim of
this patchset is a proof-of-concept for alsa-lib.

I tested this patchset with two machines based on x86/armv7a architectures.
This looks work well without any regression. But I've never tested a case
in which mapping is failed for one of the status/control data.

For your information.

Takashi Sakamoto (9):
  pcm: obsolete 'mmap_emulation' parameter of snd_pcm_hw_open_fd()
  pcm: minor code refactoring for ioctl call
  pcm: handle status/control mapping independently
  pcm: add a helper function to query status of PCM substream
  pcm: add a helper function to query hwptr
  pcm: add a helper function to query applptr
  pcm: add a helper function to issue avail_min
  pcm: add a helper function to issue applptr
  pcm: code refactoring to use helper functions

 src/pcm/pcm_direct.c |   2 +-
 src/pcm/pcm_hw.c     | 324 +++++++++++++++++++++++++++++++++------------------
 src/pcm/pcm_local.h  |   3 +-
 3 files changed, 214 insertions(+), 115 deletions(-)

-- 
2.11.0
