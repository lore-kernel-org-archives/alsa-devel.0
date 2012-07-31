From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 1/2] ALSA: ASoC: add DT bindings for
	cs4270
Date: Tue, 31 Jul 2012 17:00:23 +0100
Message-ID: <20120731160023.GA11892@opensource.wolfsonmicro.com>
References: <1343222915-26108-1-git-send-email-zonque@gmail.com>
 <5016F1B7.6070109@freescale.com>
 <20120731140950.GQ4468@opensource.wolfsonmicro.com>
 <5017F08C.9010209@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3CF5E265D2A
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 18:00:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5017F08C.9010209@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 31, 2012 at 09:49:48AM -0500, Timur Tabi wrote:
> Mark Brown wrote:

> > Probe deferral is related to the "No soundcards found" since the
> > deferred probe runs start after the init completes. 

> Is there anything I can do to fix this?

It's not a problem.  If you ensure that all the dependencies for the
card are registered before the card it won't happen but that'll depend
on the order people have in their DT.

> > The lack of an
> > update to snd_soc_register_card() isn't related.

> Are you planning on removing support for soc-audio (thereby forcing me to
> update to snd_soc_register_card), or can I just ignore the warning?

You should update.
