From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH alsa-lib 0/2] pcm: minor code cleanup
Date: Fri, 23 Jun 2017 22:09:22 +0900
Message-ID: <20170623130924.19620-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 25B3A266C27
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 15:09:29 +0200 (CEST)
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

This includes two patches from my previous RFC for minor code
cleanup:
[alsa-devel] [alsa-lib][RFC][PATCH 0/9] pcm: handle status/control mapping independently
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-June/122130.html

Takashi Sakamoto (2):
  pcm: obsolete 'mmap_emulation' parameter of snd_pcm_hw_open_fd()
  pcm: minor code cleanup for ioctl call

 src/pcm/pcm_direct.c | 2 +-
 src/pcm/pcm_hw.c     | 9 +++------
 src/pcm/pcm_local.h  | 3 ++-
 3 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.11.0
