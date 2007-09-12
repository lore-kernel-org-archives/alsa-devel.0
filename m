From: Mike Gorse <mgorse@mgorse.dhs.org>
Subject: snd_pcm_drain and lock-ups
Date: Wed, 12 Sep 2007 18:52:23 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0709121739280.26129@mgorse.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sccrmhc14.comcast.net (sccrmhc14.comcast.net [204.127.200.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 24F572449B
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Sep 2007 00:51:27 +0200 (CEST)
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

Hi all,

I've followed Arve Knudsen over here.  I am getting a lock-up when calling 
snd_pcm_drain().  This happens when 
using espeak, which is using portaudio.  Portaudio calls snd_pcm_drain 
while trying to recover from a XRUN.  snd_pcm_drain is calling 
snd_pcm_rate_drain in my case. snd_pcm_rate_drain then calls snd_pcm_wait. 
snd_pcm_wait first checks if snd_pcm_mmap_avail(pcm) >= pcm->avail_min. 
snd_pcm_map_avail is returning a number less than 300, often between 135 
and 140 but not always, where pcm->avail_min == 1024.  So it does not 
check for the XRUN state since it is conditional on snd_pcm_mmap_avail 
returning >= 1024.  This is on my laptop, which is running Linux 2.6.22 
and alsa-lib 1.0.15-rc1 and uses the snd-intel8x0 driver.

Does this give people enough information to tell what might be going on? 
I have a small test program that causes the lock-up on my laptop where the 
rate plugin gets used (it sometimes locks up immediately, sometimes after 
a few seconds), but it needs espeak and portaudio to be installed.

Thanks,

-- Mike Gorse / AIM:linvortex / http://mgorse.freeshell.org --
