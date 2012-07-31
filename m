From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3 1/2] ALSA: ASoC: add DT bindings for
	cs4270
Date: Tue, 31 Jul 2012 11:02:48 -0500
Message-ID: <501801A8.2000203@freescale.com>
References: <1343222915-26108-1-git-send-email-zonque@gmail.com>
 <5016F1B7.6070109@freescale.com>
 <20120731140950.GQ4468@opensource.wolfsonmicro.com>
 <5017F08C.9010209@freescale.com>
 <20120731160023.GA11892@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id 75745265DC8
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 18:02:51 +0200 (CEST)
In-Reply-To: <20120731160023.GA11892@opensource.wolfsonmicro.com>
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

> It's not a problem.  If you ensure that all the dependencies for the
> card are registered before the card it won't happen but that'll depend
> on the order people have in their DT.

Well, it may not be a real problem, but it is disconcerting.  I can
imagine a bunch of bogus bug reports coming my way because people think
the drivers have not loaded properly.

>>> The lack of an
>>> update to snd_soc_register_card() isn't related.
> 
>> Are you planning on removing support for soc-audio (thereby forcing me to
>> update to snd_soc_register_card), or can I just ignore the warning?
> 
> You should update.

I know, but is it urgent that I update?  How much time do I have?  If
you're telling me that you're going to yank it in 3.7, then I need to
re-prioritize my work.

-- 
Timur Tabi
Linux kernel developer at Freescale
