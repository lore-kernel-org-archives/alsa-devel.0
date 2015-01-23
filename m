From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 0/2] ASoC: Fix wm97xx touchscreen driver
Date: Fri, 23 Jan 2015 16:21:35 +0100
Message-ID: <1422026497-23180-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-206.synserver.de
 [212.40.185.206])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FCC7265654
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:59:14 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The wm97xx touchscreen driver will bind itself to the snd_ac97 device
registered by CODEC drivers and expects that the device has already been
reset by the CODEC driver. Previous to commit 6794f709b712 ("ASoC: ac97:
Drop delayed device registration") the snd_ac97 device was only registered
after the CODEC driver probe function had finished running, but starting
with the commit it is registered within snd_soc_new_ac97_codec(). This
breaks the touchscreen driver as the reset is no longer performed before the
touchscreen driver probe function runs. This patch series introduces a new
function snd_soc_alloc_ac97_codec() which allocates the snd_ac97 device, but
does not yet register it yet. This allows the CODEC drivers to perform the
reset before the device is registered.

The series is meant to perform a minimum amount of changes while fixing the
issue to prevent introducing other regressions. I have a few more patches
that consolidate the reset handling in the drivers and puts it into the core
in snd_soc_new_ac97_codec() which makes the split in the drivers
unnecessary, but that's something for next and not for stable.

Manuel can you give this another round of testing?

Thanks,
- Lars

Lars-Peter Clausen (2):
  ASoC: Add support for allocating AC'97 device before registering it
  ASoC: wm97xx: Reset AC'97 device before registering it

 include/sound/soc.h       |  1 +
 sound/soc/codecs/wm9705.c | 16 ++++++++++------
 sound/soc/codecs/wm9712.c | 12 ++++++++----
 sound/soc/codecs/wm9713.c | 12 ++++++++----
 sound/soc/soc-ac97.c      | 34 +++++++++++++++++++++++++++++-----
 5 files changed, 56 insertions(+), 19 deletions(-)

-- 
1.8.0
