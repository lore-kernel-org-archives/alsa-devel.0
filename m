From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] ALSA: rawmidi cleanups
Date: Tue, 17 Jul 2018 23:19:45 +0200
Message-ID: <20180717211949.689-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A1C4026782E
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 23:19:51 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 04987AD25
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 21:19:50 +0000 (UTC)
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

this is a patchset mainly as a cleanup of rawmidi code, and most of
them are just coding style or readability fixes without functional
behavior changes.  The last patch replaces kmalloc() with kvmalloc()
for buffer allocations, which may fail frequently as is.


Takashi

===

Takashi Iwai (4):
  ALSA: rawmidi: Tidy up coding styles
  ALSA: rawmidi: Simplify error paths
  ALSA: rawmidi: Minor code refactoring
  ALSA: rawmidi: Use kvmalloc() for buffers

 sound/core/rawmidi.c | 248 ++++++++++++++++++++++---------------------
 1 file changed, 128 insertions(+), 120 deletions(-)

-- 
2.18.0
