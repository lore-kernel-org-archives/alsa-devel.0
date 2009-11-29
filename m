From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: AC97 slot information
Date: Sun, 29 Nov 2009 16:50:58 +0000
Message-ID: <20091129165058.GA15959@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 55D0024415
	for <alsa-devel@alsa-project.org>; Sun, 29 Nov 2009 17:51:06 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When opening an AC'97 codec under ALSA using snd_ac97_pcm_open(),
specifying the number of channels desired (2, 4 or 6) is there a
way to read back which slots will be in use?

Currently, in the AACI driver, I use a lookup table to convert from
channels to a slot mask - if this information is already available
from ALSA, I'd much rather use it rather than inventing keeping my
own solution.

Also, should the 'slots' value passed to snd_ac97_pcm_open() be
those in pcm->r[].slots or should it be selected from the number
of channels?
