From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/7] ALSA: Refactoring PCM locking code
Date: Tue, 22 Jan 2019 17:19:08 +0100
Message-ID: <20190122161915.8445-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 385912674BA
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 17:19:18 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 4DE73B07A
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 16:19:18 +0000 (UTC)
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

this is a patch set to refactor the PCM locking code and to reduce the
global lock.  At least, this gets rid of the global rwlock, while the
global rwsem is still needed for some non-atomic ops and for avoiding
the deadlock at linking.


Takashi

===

Takashi Iwai (7):
  ALSA: pcm: Call snd_card_unref() inside in_pcm_file()
  ALSA: pcm: Unify snd_pcm_group initialization
  ALSA: pcm: Make PCM linked list consistent while re-grouping
  ALSA: pcm: Avoid confusing loop in snd_pcm_unlink()
  ALSA: pcm: More fine-grained PCM link locking
  ALSA: pcm: Remove down_write() hack for snd_pcm_link_rwsem
  ALSA: pcm: Cleanup snd_pcm_stream_lock() & co

 include/sound/pcm.h     |   3 +-
 sound/core/pcm.c        |   4 +-
 sound/core/pcm_local.h  |   1 +
 sound/core/pcm_native.c | 290 ++++++++++++++++++++++++++++--------------------
 4 files changed, 171 insertions(+), 127 deletions(-)

-- 
2.16.4
