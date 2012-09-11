From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: use snd_soc_register_card
 to register the card
Date: Tue, 11 Sep 2012 08:13:31 +0800
Message-ID: <20120911001330.GD30699@opensource.wolfsonmicro.com>
References: <1347314576-13832-1-git-send-email-timur@freescale.com>
 <1347314576-13832-2-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 40132260784
 for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2012 02:13:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347314576-13832-2-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 10, 2012 at 05:02:56PM -0500, Timur Tabi wrote:

> We also transition the module initialize to late_initcall(), so that
> the machine driver loads last.  Although this is technically not
> necessary, it does avoid this error message at boot time:
> 
> 	ALSA device list:
> 	  No soundcards found.

This should've been a separate patch...  if we we're going to do this we
really should be doing it for all cards, not just this one, though it'd
be better to either remove or fix the logging itself.
