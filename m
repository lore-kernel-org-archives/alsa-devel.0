From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: don't try to resume
 uninstantiated a soc-audio devices
Date: Wed, 23 Nov 2011 21:51:40 +0000
Message-ID: <20111123215139.GA32201@opensource.wolfsonmicro.com>
References: <1322076250-22203-1-git-send-email-zonque@gmail.com>
	<20111123212650.GC8901@opensource.wolfsonmicro.com>
	<4ECD67A7.5000300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CDC1E103D61
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 22:51:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4ECD67A7.5000300@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 23, 2011 at 10:37:43PM +0100, Daniel Mack wrote:
> On 11/23/2011 10:26 PM, Mark Brown wrote:
> > On Wed, Nov 23, 2011 at 08:24:10PM +0100, Daniel Mack wrote:
> >> The code tries to schedule a work item from the resume context, which
> >> will crash the kernel if snd_soc_instantiate_card() has not been called
> >> for the card before.

> > Eric already sent a slightly different fix for this which is applied.

> Could you give me a pointer to this patch? I had this problem today with
> Linus' latest git tip.

It's the tip of my for-3.2.  Slightly different fix but the effect
should be the same.
