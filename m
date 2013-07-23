From: Daniel Mack <zonque@gmail.com>
Subject: Ambiguous DAPM widget names and DPCM
Date: Tue, 23 Jul 2013 10:30:16 +0200
Message-ID: <51EE3F18.3030207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f178.google.com (mail-ea0-f178.google.com
 [209.85.215.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E3FD261AFE
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 10:29:54 +0200 (CEST)
Received: by mail-ea0-f178.google.com with SMTP id l15so4258408eak.23
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 01:29:53 -0700 (PDT)
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,
Hi Liam,

I spent some hours reverse-engineering the DPCM code, and I plan to
prepare a patch to add some documentation once I've assembled a fully
working setup. However, I have a general question regarding DAPM widget
names.

DPCM uses DAPM widgets and routes in order to determine the FE <-> BE
connections at runtime. The problem with this is that widget names are
very ambiguous, as the automatically created widgets for DAIs are named
after their stream_name properties, which contain "Playback" or
"Capture" for all components in my case. Hence, the code which walks the
connections (snd_soc_dapm_dai_get_connected_widgets()) will most likely
match the wrong one (which has empty sound/sink lists), which results in
a failure like this:

[   16.606268]  fe: ASoC: fe no valid playback route

I hacked the names of all components so they are unique, but even then,
the problem is that snd_soc_dapm_new_dai_widgets() is called twice for
the CPU DAI, once from soc_probe_platform(), and later from
soc_probe_link_dais(), and both calls would create DAPM widgets with
identical names, resulting in the same problem as described above.

I don't know how to handle this, but I believe that nobody was really
hit by this issue yet, as DPCM doesn't seem to be used widely, at least
not by any machine code in mainline.

One idea would be to change the automatically generated names of DAI
widgets in order to make them unique, or re-factor the lookup routines.

Any opinion on that? Do I miss a general consideration here?

With more hacks in place, the setup somehow succeeds, but when the
stream is opened, we'll hit a BUG() in sound/core/pcm_memory.c, because
the FE device's DMA type is undefined. But that's another topic I'll
address later.


Thanks,
Daniel
