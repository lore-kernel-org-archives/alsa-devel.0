From: Ben Zhang <benzh@chromium.org>
Subject: ASoC suspend resume question
Date: Tue, 12 May 2015 19:08:13 -0700
Message-ID: <CAOV7ByJ+R1df0HgCB-w5zW9re5rE8abNFw5_of8ZRobcdiMP5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 60BAC2658ED
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 04:08:14 +0200 (CEST)
Received: by pacwv17 with SMTP id wv17so34016313pac.0
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 19:08:13 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Dylan Reid <dgreid@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I have a question about the design of ASoC suspend/resume path. Who
should call snd_soc_suspend() and snd_soc_resume()?

They are part of the soc-audio driver's dev_pm_ops, but some ASoC
platform drivers also calls them. For example,

hsw_pcm_prepare() in sound/soc/intel/haswell/sst-haswell-pcm.c
sst_soc_prepare() in sound/soc/intel/atom/sst-mfld-platform-pcm.c

Thanks,
Ben
