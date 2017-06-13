From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/6] Misc PCM fixes
Date: Tue, 13 Jun 2017 16:18:06 +0200
Message-ID: <20170613141812.21220-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EB28F266F04
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 16:18:14 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2E120AE84
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 14:18:14 +0000 (UTC)
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

this is a kind of gleaning work, a collection of small cleanups of
ALSA PCM implementations.


Takashi

===

Takashi Iwai (6):
  ALSA: pcm: Clean up SNDRV_PCM_IOCTL_PAUSE code
  ALSA: pcm: Apply power lock globally to common ioctls
  ALSA: pcm: Allow dropping stream directly after resume
  ALSA: pcm: Preprocess PAUSED or SUSPENDED stream before PREPARE
  ALSA: pcm: Use common PCM_RUNTIME_CHECK() for sanity checks
  ALSA: pcm: Skip ack callback without actual appl_ptr update

 sound/core/pcm_lib.c    |  3 ++
 sound/core/pcm_native.c | 84 +++++++++++++++++++++----------------------------
 2 files changed, 39 insertions(+), 48 deletions(-)

-- 
2.13.1
