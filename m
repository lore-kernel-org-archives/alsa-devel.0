From: Johannes Stezenbach <js@sig21.net>
Subject: [PATCH v2 0/3] ASoC: sta32x improvements
Date: Mon, 14 Nov 2011 17:23:15 +0100
Message-ID: <1321287798-20462-1-git-send-email-js@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id EC56924719
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 17:30:52 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a rework of the "ASoC: sta32x: add workaround for ESD reset issue"
patch posted on Nov 9.  Since the review of that patch discovered
a general issue with the coefficient RAM, I split the patch into
three parts: the first fixes the coef reload after power up,
the second adds the missing platform configuration (in place of
hard-coded values), and the third has the ESD workaround.

I think I followed all review comments, except for the ESD
workaround where I decided it is much clearer to call 
sta32x_cache_sync() directly instead of messing around
with sta32x_set_bias_level().

The patches apply to
git://opensource.wolfsonmicro.com/linux-2.6-asoc.git for-3.2
and for-3.3.  checkpatch.pl result is clean.

 include/sound/sta32x.h    |   35 +++++++++++
 sound/soc/codecs/sta32x.c |  143 +++++++++++++++++++++++++++++++++++++++++----
 sound/soc/codecs/sta32x.h |    1 +
 3 files changed, 168 insertions(+), 11 deletions(-)


Thanks
Johannes
