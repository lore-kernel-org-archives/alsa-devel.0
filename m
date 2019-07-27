From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 0/2] ALSA: usb-audio: fix PCM device order
Date: Sat, 27 Jul 2019 11:30:04 +0200
Message-ID: <20190727093006.9870-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 58F9BF80134
 for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2019 11:30:15 +0200 (CEST)
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
Cc: Tanu Kaskinen <tanuk@iki.fi>, Alexander Tsoy <alexander@tsoy.me>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a rewrite of the old USB-audio fix patch I obviously
overlooked to adapt to 5.3 kernel with a preliminary cleanup patch.

Totally untested, so any test / feedback would be appreciated.


thanks,

Takashi

===

Alexander Tsoy (1):
  ALSA: usb-audio: fix PCM device order

Takashi Iwai (1):
  ALSA: usb-audio: Unify audioformat release code

 sound/usb/stream.c | 64 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 17 deletions(-)

-- 
2.16.4
