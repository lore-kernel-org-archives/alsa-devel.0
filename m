From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] PCM cleanups
Date: Mon, 16 Apr 2018 14:14:14 +0200
Message-ID: <20180416121417.27452-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9865D2673D2
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 14:14:19 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C024BAEF8
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 12:14:18 +0000 (UTC)
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

this is a patch series for minor cleanups of PCM core codes.
Mostly to unify the direction-separated PCM callbacks to unified
ones.


Takashi

===

Takashi Iwai (3):
  ALSA: pcm: Clean up with snd_pcm_avail() and snd_pcm_hw_avail()
    helpers
  ALSA: pcm: Unify playback and capture poll callbacks
  ALSA: pcm: Unify delay calculation in snd_pcm_status() and
    snd_pcm_delay()

 sound/core/pcm_compat.c |  10 +--
 sound/core/pcm_lib.c    |  15 +----
 sound/core/pcm_local.h  |  18 +++++
 sound/core/pcm_native.c | 175 ++++++++++++------------------------------------
 4 files changed, 67 insertions(+), 151 deletions(-)

-- 
2.16.3
