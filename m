From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: does snd_pcm_info_get_sync work at all?
Date: Fri, 18 May 2012 15:46:25 -0500
Message-ID: <4FB6B521.4000901@linux.intel.com>
References: <1337323363-11449-1-git-send-email-ricardo.neri@ti.com>
	<1337323363-11449-4-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DFEB2435C
	for <alsa-devel@alsa-project.org>;
	Fri, 18 May 2012 22:46:28 +0200 (CEST)
In-Reply-To: <1337323363-11449-4-git-send-email-ricardo.neri@ti.com>
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

Hi list,
After looking a number of times at the code to start multiple devices at
the same time, I wonder if the alsa-lib snd_pcm_info_get_sync() routine
works at all.

The documentation says "Because the drivers cannot guarantee the
synchronization (sample resolution) on hardware lacking this feature,
the #snd_pcm_info_get_sync() function returns synchronization ID,
which is equal for hardware synchronized streams".

It seems some drivers set a value when opening the stream using the
snd_pcm_set_sync() helper. What exactly is the purpose of this id and
what should it be used for in user-space? The value returned seems to
be the card#, the same value no matter if streams are synchronized or
not.

This is confirmed by a simple experiment, When I tried with a test
program on my HDAudio laptop, the ID is consistently zero, no matter if
I called snd_pcm_link() to synchronize devices or not. That doesn't seem
right. If two devices aren't linked, the information reported my the 
kernel should be clearly invalid.

What exactly was this intent of this routine, why would a sync_id be
needed anyway and has anyone used it successfully?

Thanks,
-Pierre
