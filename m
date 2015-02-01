From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 0/2] Remove unused functions
Date: Sun,  1 Feb 2015 01:01:07 -0600
Message-ID: <1422774069-17328-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f178.google.com (mail-ie0-f178.google.com
 [209.85.223.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C2BB2604E3
 for <alsa-devel@alsa-project.org>; Sun,  1 Feb 2015 08:01:23 +0100 (CET)
Received: by mail-ie0-f178.google.com with SMTP id rd18so2494723iec.9
 for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2015 23:01:21 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org, Chris Rorvick <chris@rorvick.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Found a couple more things to rip out.

Regards,

Chris

Chris Rorvick (2):
  ALSA: line6: Remove unused line6_midibuf_status()
  ALSA: line6: Remove unused line6_midibuf_skip_message()

 sound/usb/line6/midibuf.c | 18 ------------------
 1 file changed, 18 deletions(-)

-- 
2.1.0
