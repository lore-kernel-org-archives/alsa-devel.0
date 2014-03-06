From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: ASoC: wm5110: Extend SYSCLK patch file for rev D
Date: Thu, 6 Mar 2014 09:32:47 +0000
Message-ID: <20140306093247.GI8570@opensource.wolfsonmicro.com>
References: <1394070425.2861.35.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0FE132658DC
 for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2014 10:32:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1394070425.2861.35.camel@deadeye.wl.decadent.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Debian kernel maintainers <debian-kernel@lists.debian.org>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 06, 2014 at 01:47:05AM +0000, Ben Hutchings wrote:
> I'm looking at commit 34354792432b6e0a3b156819a1a19716c50d3473 and
> include/linux/mfd/arizona/registers.h, and wondering what exactly this
> the register patch is changing.
> 
> It looks like there are some registers not named elsewhere (addresses
> 0x0049, 0x004a, 0x0057, 0x0058).  What about the higher addresses?  Are
> these more registers, or is this patching firmware in device memory?

These are all internal registers that we don't usually expose, in
the case of the Rev D some of these are not initialised to
optimum values by the hardware the patch provides better audio
performance and path transitions.

Thanks,
Charles
