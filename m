From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/3] Yet more cleanups for intel-lpe-audio
Date: Sun,  5 Feb 2017 09:04:55 +0100
Message-ID: <20170205080458.15927-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8097A266CF3
 for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2017 09:05:00 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B779AABD3
 for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2017 08:04:59 +0000 (UTC)
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

Yet another cleanup patchset, only cosmetic, no real functional
changes.


Takashi

===

Takashi Iwai (3):
  ALSA: x86: Minor cleanup of reset buffer procedure
  ALSA: x86: Unify local function prefix
  ALSA: pcm: Define dummy snd_pcm_suspend() for CONFIG_PM=n

 include/sound/pcm.h          |   9 +++
 sound/x86/intel_hdmi_audio.c | 140 ++++++++++++++++++++-----------------------
 2 files changed, 75 insertions(+), 74 deletions(-)

-- 
2.11.0
