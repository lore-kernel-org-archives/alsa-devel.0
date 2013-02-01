From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASOC: imx: audmux: add a integrated
 configuration function
Date: Fri, 1 Feb 2013 21:10:09 +0800
Message-ID: <20130201131007.GA23922@S2101-09.ap.freescale.net>
References: <1359614566-4660-1-git-send-email-b13634@freescale.com>
 <20130131142243.GE2735@S2101-09.ap.freescale.net>
 <20130131163517.GC13321@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 0274C265020
 for <alsa-devel@alsa-project.org>; Fri,  1 Feb 2013 14:11:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130131163517.GC13321@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Gary Zhang <b13634@freescale.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 01, 2013 at 12:35:19AM +0800, Mark Brown wrote:
> On Thu, Jan 31, 2013 at 10:22:45PM +0800, Shawn Guo wrote:
> 
> > Mark,
> 
> > I just found there are much more code between imx_sgtl5000_probe
> > and imx_wm8962_probe than just above audmux setup.  I'm thinking
> > about consolidate them at a higher level.  But can you give it a
> > go on Gary's patch, and then I can start the consolidation from
> > there?  I promise I will send a follow-up patch to do it.
> 
> I'm not sure what you mean here?  I don't have any intention to work on
> this stuff.

You had a comment on Gary's imx-wm8962 patch, saying that the audmux
setup should become a helper.  And that's why Gary came up this patch.
But the patch does not look good.  While reviewing the patch, I found
there are much more than just audmux setup code could be shared between
imx-sgtl5000 and imx-wm8960 driver.  I'm asking if you can merge Gary's
the patch with leaving audmux setup as it is, and let me consolidate
the common part between imx-sgtl5000 and imx-wm8960 with a follow-up
patch.

In any case, I'm not expecting you work on this stuff :)

Shawn
