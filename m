From: "J. Scott Merritt" <alsauser@pragmasoft.com>
Subject: SALSA-Lib: snd_pcm_hw_params_any clobbers memory
Date: Wed, 27 Jun 2007 16:33:52 -0400
Message-ID: <20070627163352.2559a026.alsauser@pragmasoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp6.server.rpi.edu (smtp6.server.rpi.edu [128.113.2.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 8ECD624524
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2007 22:30:49 +0200 (CEST)
Received: from RPI02.localdomain (voiceflight.inc.rpi.edu [128.113.36.139])
	by smtp6.server.rpi.edu (8.13.1/8.13.1) with SMTP id l5RKUm5k001671
	for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2007 16:30:48 -0400
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
List-Id: alsa-devel@alsa-project.org

Dear list,

Using SALSA-Lib 0.0.2, I call
   snd_pcm_open
   snd_pcm_hw_params_malloc
   snd_pcm_hw_params_any

The call to snd_pcm_hw_params_any appears to clobber memory beyond the
end of the hw_params allocated by snd_pcm_hw_params_malloc (as reported
by linking in -lmcheck).

The code is being cross-compiled and tested on an ARM processor
(PXA270) which is running linux kernel 2.6.21.   This same code sequence
-does- operate properly (in the same ARM test environment) when compiled
against AlsaLib 1.0.13.

I got "lost" somewhere around the hw_refine IOCTL ....  Any suggestions
appreciated :)

Thanks, Scott.
