From: anish kumar <yesanishhere@gmail.com>
Subject: [patch 0/4] ASoC: dapm: Avoid creating kcontrol for
	params
Date: Sat, 26 Aug 2017 01:29:02 -0700
Message-ID: <20170826082902.35422-1-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id A644A267414
 for <alsa-devel@alsa-project.org>; Sat, 26 Aug 2017 10:29:09 +0200 (CEST)
Received: by mail-pg0-f68.google.com with SMTP id 63so2431372pgc.1
 for <alsa-devel@alsa-project.org>; Sat, 26 Aug 2017 01:29:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: anish kumar <yesanishhere@gmail.com>, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

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

 sound/soc/soc-dapm.c | 123 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 67 insertions(+), 56 deletions(-)

-- 
2.10.1 (Apple Git-78)
