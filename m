From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 0/3] ALSA: possible race fixes for timer
	resolution callback
Date: Thu, 17 May 2018 10:49:08 +0200
Message-ID: <20180517084911.11868-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D249267046
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 10:49:15 +0200 (CEST)
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
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a revised patchset for fixing the possible races among timer
resolution callback and other operations.  The first two are code
cleanups and the last one actually covers it.

v1->v2:
- Fix bogus return value from snd_timer_resolution()
- Split the change in seq_timer.c to an individual patch


Takashi

===

Takashi Iwai (3):
  ALSA: timer: Simplify timer hw resolution calls
  ALSA: seq: Avoid open-code for getting timer resolution
  ALSA: timer: Assure timer resolution access always locked

 sound/core/seq/seq_timer.c |  4 +---
 sound/core/timer.c         | 48 ++++++++++++++++++++++++----------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

-- 
2.16.3
