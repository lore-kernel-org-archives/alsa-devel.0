From: yesanishhere@gmail.com
Subject: [Resend] [PATCH 0/4] ASoC: dapm: Avoid creating
	kcontrol for params
Date: Wed, 20 Sep 2017 01:28:32 -0700
Message-ID: <1505896116-43310-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id CCD27267227
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 10:28:46 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id i23so933110pfi.2
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 01:28:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ckeepax@opensource.cirrus.com, broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org, tiwai@suse.com
Cc: anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: anish kumar <yesanishhere@gmail.com>

Currently in codec to codec dai link if there are multiple
params defined then dapm can use created kcontrol to
decide which param to apply at runtime.

However, in case there is only single param configuration
then there is no point in creating the kcontrol and also there
is no point in allocating memory for kcontrol.

In the snd_soc_dapm_new_pcm function, there is memory
allocation happening for kcontrol which is later used
or not used based on num_param. It is better to not
allocate memory when there is only a single configuration.
This change is to remedy that anomaly.

This code change doesn't do much except just refactor
snd_soc_dapm_new_pcm function. Now the part of allocating
memory for kcontrol is allocated to a new function and it
is called only in the case it is needed.

anish kumar (4):
  ASoC: dapm: fix error path in snd_soc_dapm_new_pcm
  ASoC: dapm: Refactor the code in snd_soc_dapm_new_pcm
  ASoC: dapm: Avoid creating kcontrol for params
  ASoC: dapm: Remove the redundant check

 sound/soc/soc-dapm.c | 122 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 56 deletions(-)

-- 
2.5.4 (Apple Git-61)
