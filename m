From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] ALSA: Remove superfluous
	snd_info_register() calls
Date: Tue,  5 Feb 2019 17:05:24 +0100
Message-ID: <20190205160527.8815-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BC8A3267471
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 17:05:32 +0100 (CET)
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

this is a fallout of the previous patchset, covering more places that
call snd_info_register() unnecessarily.  These should be applied on
top of my previous patchset.

The complete patches are found in topic/proc-fixes branch of sound git
tree.


thanks,

Takashi

===

Takashi Iwai (3):
  ALSA: firewire: Remove superfluous snd_info_register() calls
  ALSA: opl4: Remove superfluous snd_info_register() calls
  ALSA: emux: Remove superfluous snd_info_register() calls

 sound/drivers/opl4/opl4_proc.c            |  4 ----
 sound/firewire/bebob/bebob_proc.c         | 12 ++----------
 sound/firewire/dice/dice-proc.c           | 12 ++----------
 sound/firewire/digi00x/digi00x-proc.c     | 16 ++--------------
 sound/firewire/fireface/ff-proc.c         | 12 ++----------
 sound/firewire/fireworks/fireworks_proc.c | 12 ++----------
 sound/firewire/motu/motu-proc.c           | 12 ++----------
 sound/firewire/oxfw/oxfw-proc.c           | 12 ++----------
 sound/firewire/tascam/tascam-proc.c       | 12 ++----------
 sound/synth/emux/emux_proc.c              |  4 ----
 10 files changed, 16 insertions(+), 92 deletions(-)

-- 
2.16.4
