From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: multi plugin and start_threshold = -1
Date: Sun, 6 Jun 2010 07:26:25 +0800
Message-ID: <AANLkTiklGOZDPOQVHyznuIq0Zq8Pjtcw9gZRvCQYkAZ-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f187.google.com (mail-pz0-f187.google.com
	[209.85.222.187])
	by alsa0.perex.cz (Postfix) with ESMTP id D990E24655
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Jun 2010 01:26:26 +0200 (CEST)
Received: by pzk17 with SMTP id 17so1172079pzk.5
	for <alsa-devel@alsa-project.org>; Sat, 05 Jun 2010 16:26:25 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I: core-util.c: Successfully enabled SCHED_RR scheduling for thread, with
priority 5.
I: alsa-sink.c: Starting playback.
I: (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_START failed (-77)
I: (alsa-lib)pcm_hw.c: PCM state = RUNNING

any limitation to use -1 as  start_thershold ?

why  SNDRV_PCM_IOCTL_START failed (-77) only occur with PA server when
using "multi" plugin of surround40 of ca0106 ?
other application (e.g. aplay , speaker-test and mplayer  seem work fine

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5018
