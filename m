From: Kai Vehmanen <kvehmanen@eca.cx>
Subject: [PATCH 0/1] alsa-lib: pcm_hw: Always use delay ioctl
 in snd_pcm_delay()
Date: Fri, 11 Sep 2009 01:07:06 +0300 (EEST)
Message-ID: <alpine.DEB.1.10.0909110058130.3417@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gw01.mail.saunalahti.fi (gw01.mail.saunalahti.fi
	[195.197.172.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 173992440A
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Sep 2009 00:06:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hello all,

this is a updated version of the alsa-lib patch I mentioned in
the earlier thread:
http://mailman.alsa-project.org/pipermail/alsa-devel/2009-August/020377.html

That was meant to just describe the possible problem, but now I'm more 
confident that this should be considered for merging. The related 
alsa-kernel patch is 'ALSA: Add extra delay count in PCM', which added the 
'runtime->delay' property.

Please review if this patch makes sense.

Kai Vehmanen (1):
   pcm_hw: Always use delay ioctl in snd_pcm_delay()

  src/pcm/pcm_hw.c |   22 ----------------------
  1 files changed, 0 insertions(+), 22 deletions(-)
