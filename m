From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] PCM OSS fixes
Date: Mon,  8 Jan 2018 15:25:39 +0100
Message-ID: <20180108142541.18098-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 97B5326698E
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 15:25:49 +0100 (CET)
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
Cc: Dmitry Vyukov <dvyukov@google.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this contains two fixes for PCM OSS bugs that have been triggered by
syzbot.  These are simple and straightforward, and I'm going to queue
for 4.15-rc8.


thanks,

Takashi

===

Takashi Iwai (2):
  ALSA: pcm: Abort properly at pending signal in OSS read/write loops
  ALSA: pcm: Allow aborting mutex lock at OSS read/write loops

 sound/core/oss/pcm_oss.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

-- 
2.15.1
