From: gpe <gpe92@free.fr>
Subject: need information about dapm events,
	bias and mute management
Date: Tue, 5 May 2015 02:58:17 +0200
Message-ID: <20150505025817.08d30abbfa6902ce287ed217@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp21.services.sfr.fr (smtp21.services.sfr.fr [93.17.128.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D43D2606E2
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 02:58:18 +0200 (CEST)
Received: from filter.sfr.fr (localhost [79.82.41.4])
 by msfrf2104.sfr.fr (SMTP Server) with ESMTP id F3EC97000375
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 02:58:17 +0200 (CEST)
Received: from reveillon (4.41.82.79.rev.sfr.net [79.82.41.4])	(using TLSv1
 with cipher AES128-SHA (128/128 bits))	(No client certificate requested)
 by msfrf2104.sfr.fr (SMTP Server) with ESMTP id DB118700034D
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 02:58:17 +0200 (CEST)
Received: from localhost ([::1] helo=reveillon.localdomain)	by reveillon
 with smtp (Exim 4.84)	(envelope-from <gpe92@free.fr>)	id 1YpRBh-0005OT-Fl
 for alsa-devel@alsa-project.org; Tue, 05 May 2015 02:58:17 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm working on an asoc codec but I'm facing some problems with the DAPM events
the bias and the mute management.
The kernel is a 3.4.91.
Globally my codec is functionnal but I've some glitch.
By using DAPM events (PRE_PMU, POST_PMU) and bias management I've suppressed
the glitchs at the start but I've always some glitchs at the end of a playback.
I'm trying to suppress them with PRE_PMD but it not works.
When I test my code I see that some power off are done before the call of the
SND_SOC_DAPM_PRE_PMD event. Is it normal ?

Another question is regarding the mute management (snd_soc_dai_digital_mute)
which is done after all the power off ... I expected it to be done just at
the end of the playback.

Last question about the bias management (set_bias_level in
snd_soc_codec_driver). During the start I see the bias level incrementing but
during the stop there is no action on the bias level. Why ?

Regards.

PS: I'm a newbie on codec development so don't hit to hard on my head if my
questions are stupid. I've read many docs but I don't found a doc which
describes the interactions between the APIs.
PS2: sorry for my bad english.

-- 
+-------+
| gpe92 |
+-------+
