From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib 0/3] Misc fix and pcm-multi-thread test
Date: Thu,  7 Jul 2016 16:30:06 +0200
Message-ID: <20160707143009.23550-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9125C26584A
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 16:30:11 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 5BC80AC35
 for <alsa-devel@alsa-project.org>; Thu,  7 Jul 2016 14:30:11 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is an excerpt from my previous RFC patchset for thread safety,
containing a trivial cleanup and an addition of pcm-multi-thread test
program, where both can be applied generically without thread-safe
patches.

It's just a resend, as these have no changes from the previous post.


Takashi

===

Takashi Iwai (3):
  pcm: Remove superfluous rmb() from PCM meter plugin
  test: Add pcm-multi-thread program
  Add pcm-multi-thread to .gitignore

 .gitignore              |   1 +
 src/pcm/pcm_meter.c     |   1 -
 test/Makefile.am        |   3 +-
 test/pcm-multi-thread.c | 263 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 266 insertions(+), 2 deletions(-)
 create mode 100644 test/pcm-multi-thread.c

-- 
2.9.0
