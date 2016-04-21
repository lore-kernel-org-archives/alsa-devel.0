From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] Yet more hardening of ALSA hrtimer races
Date: Thu, 21 Apr 2016 16:13:39 +0200
Message-ID: <1461248021-22624-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AB4F726683D
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 16:13:42 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 496EFAD95
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 14:13:40 +0000 (UTC)
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

this is a resubmission of patches for hardening the ALSA hrtimer
backend against open/close races.


Takashi

===

Takashi Iwai (2):
  ALSA: timer: Allow backend disabling start/stop from handler
  ALSA: hrtimer: Use manual start/stop in callback

 include/sound/timer.h | 12 +++++++++++-
 sound/core/hrtimer.c  | 51 ++++++++++++++++++++++++++++++++++++++-------------
 sound/core/timer.c    | 24 ++++++++++++++++++------
 3 files changed, 67 insertions(+), 20 deletions(-)

-- 
2.8.1
