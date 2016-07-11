From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [alsa-lib][PATCH 0/7] fix compiler warnings
Date: Mon, 11 Jul 2016 21:05:56 +0900
Message-ID: <1468238763-15547-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id D97642654D5
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 14:06:08 +0200 (CEST)
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

This patchset is just for fixes of compiler warnings. Nothing others.

Takashi Sakamoto (7):
  topology: remove unused variable in tplg_parse_fe_dai()
  topology: remove unused variable in get_tokens()
  topology: apply the same type to compared two variables
  topology: initialize variable for error output
  pcm: set error code at failure path
  mixer: remove assignment to unused variable
  pcm: add 'default' case for switch statement

 modules/mixer/simple/sbase.c |  2 --
 src/pcm/pcm_direct.c         |  2 ++
 src/pcm/pcm_hw.c             |  1 +
 src/topology/data.c          | 10 +++++-----
 src/topology/pcm.c           |  1 -
 5 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.7.4
