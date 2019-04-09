From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] ALSA: timer: cleanups
Date: Tue,  9 Apr 2019 19:02:33 +0200
Message-ID: <20190409170235.20783-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C562F89625
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 19:02:39 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 334DAAF81
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2019 17:02:39 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is just a minor cleanup sereies of ALSA timer code.
No functional changes.


Takashi

===

Takashi Iwai (2):
  ALSA: timer: Simplify error path in snd_timer_open()
  ALSA: timer: Coding style fixes

 sound/core/timer.c | 57 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 22 deletions(-)

-- 
2.16.4
