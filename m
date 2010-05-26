From: VDR User <user.vdr@gmail.com>
Subject: Problem with snd_hda_intel from 05-27-2010 snapshot
Date: Wed, 26 May 2010 16:40:05 -0700
Message-ID: <AANLkTilIX_UnMYcg8LAqkndS80nFppblW6erTm2e7o5X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 04B1124421
	for <alsa-devel@alsa-project.org>;
	Thu, 27 May 2010 01:40:07 +0200 (CEST)
Received: by vws8 with SMTP id 8so263305vws.38
	for <alsa-devel@alsa-project.org>; Wed, 26 May 2010 16:40:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi.  I had been mostly successfully using the snd_hda_intel driver
from the stable kernel 2.6.34 for HDMI audio with my Nvidia GT220
video card.  In an attempt to see if any recent changes to
snd_hda_intel would fix a problem I've been having with "pcm_hw.c:
snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY failed" I decided to download
the latest snapshot.  Unfortunately with these drivers I have no
audio.  All my settings, and everything have remained the same.  The
only noticable difference I've found is
/sys/module/snd_hda_intel/parameters/probe_only is 0,0,0,0,0,0,0,0 in
the snapshot drivers, and N,N,N,N,N,N,N,N in the 2.6.34 kernel drivers
(which are compiled into the kernel).

Any help?

Thanks,
Derek
