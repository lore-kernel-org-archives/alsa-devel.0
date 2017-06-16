From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] ALSA: Follow standard EXPORT_SYMBOL()
	declarations
Date: Fri, 16 Jun 2017 17:56:35 +0200
Message-ID: <20170616155639.5427-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AE773266CF6
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 17:56:43 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2775FAD8C
 for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2017 15:56:43 +0000 (UTC)
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

this is a very very trivial cleanup, to make EXPORT_SYMBOL*()
declarations to follow the standard style, i.e. right after the
function definition.

I didn't want this kind of changes because it makes the backporting
difficult in general.  But recently we've changed the core stuff
enough, so it's good time to stir the code for this kind of cleanups,
too.


thanks,

Takashi

===

Takashi Iwai (4):
  ALSA: pcm: Follow standard EXPORT_SYMBOL() declarations
  ALSA: seq: Follow standard EXPORT_SYMBOL() declarations
  ALSA: timer: Follow standard EXPORT_SYMBOL() declarations
  ALSA: core: Follow standard EXPORT_SYMBOL() declarations

 sound/core/info.c               |  6 ------
 sound/core/info_oss.c           |  1 -
 sound/core/init.c               |  8 +-------
 sound/core/isadma.c             |  3 ---
 sound/core/memalloc.c           | 13 ++++---------
 sound/core/memory.c             |  2 --
 sound/core/misc.c               |  1 -
 sound/core/oss/mixer_oss.c      |  3 +--
 sound/core/pcm_lib.c            | 21 ---------------------
 sound/core/pcm_memory.c         |  6 ------
 sound/core/pcm_misc.c           | 11 -----------
 sound/core/pcm_native.c         |  7 -------
 sound/core/seq/seq_clientmgr.c  |  8 --------
 sound/core/seq/seq_lock.c       |  1 -
 sound/core/seq/seq_memory.c     |  2 --
 sound/core/seq/seq_midi_emul.c  |  9 ++++-----
 sound/core/seq/seq_midi_event.c | 21 ++++++++-------------
 sound/core/seq/seq_ports.c      |  2 --
 sound/core/seq/seq_virmidi.c    |  3 +--
 sound/core/sound.c              |  2 --
 sound/core/sound_oss.c          |  3 ---
 sound/core/timer.c              | 27 +++++++++++++--------------
 22 files changed, 32 insertions(+), 128 deletions(-)

-- 
2.13.1
