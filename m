From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Fix compilation error
 due to leftover code
Date: Thu, 6 Sep 2012 07:37:22 +0800
Message-ID: <20120905233716.GE10580@opensource.wolfsonmicro.com>
References: <1346335575-1592-1-git-send-email-peter.ujfalusi@ti.com>
 <20120830180219.GI4356@opensource.wolfsonmicro.com>
 <504470B5.20404@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 21B13264EF5
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 01:37:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <504470B5.20404@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, linux-next@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 03, 2012 at 11:56:21AM +0300, Peter Ujfalusi wrote:

> So how can we resolve this?
> Are you going to rebase or update your 3.7, for-next topic/omap branches on
> mainline so they will contain the mainline patch (d0db84e)?

So, I think I figured out what you're talking about here.  Check -next.
Please if you're going to do stuff like this in future:

 - Talk about the actual code we've got.  It's OK to explain the history
   but it's very important to explain the concrete problem - that was
   missing from your mails (the closest we got was "compilation problem").

 - Discuss changes to what's there, starting off with "let's throw
   everything away" doesn't help with clarity especially with a missing
   problem description.

The problem description is especially critical.
