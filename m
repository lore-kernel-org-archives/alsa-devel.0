From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3 1/2] ALSA: ASoC: add DT bindings for
	cs4270
Date: Tue, 31 Jul 2012 09:49:48 -0500
Message-ID: <5017F08C.9010209@freescale.com>
References: <1343222915-26108-1-git-send-email-zonque@gmail.com>
 <5016F1B7.6070109@freescale.com>
 <20120731140950.GQ4468@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 by alsa0.perex.cz (Postfix) with ESMTP id D4EB8265D06
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 16:49:52 +0200 (CEST)
In-Reply-To: <20120731140950.GQ4468@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> Probe deferral is related to the "No soundcards found" since the
> deferred probe runs start after the init completes. 

Is there anything I can do to fix this?

> The lack of an
> update to snd_soc_register_card() isn't related.

Are you planning on removing support for soc-audio (thereby forcing me to
update to snd_soc_register_card), or can I just ignore the warning?

-- 
Timur Tabi
Linux kernel developer at Freescale
