From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Lock the CODEC in PXA external jack
 controls
Date: Sat, 6 Nov 2010 11:16:27 -0400
Message-ID: <20101106151627.GC26711@opensource.wolfsonmicro.com>
References: <1288979601-9105-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1289040909.3318.7.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 27766103803
	for <alsa-devel@alsa-project.org>; Sat,  6 Nov 2010 16:16:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1289040909.3318.7.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Eric Miao <eric.y.miao@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 06, 2010 at 10:55:09AM +0000, Liam Girdwood wrote:

> I'm fine for this atm, but obviously we need to rework the DAPM locking
> a little as we dont want developers to have to care about locking
> internals.

It's not just DAPM, either - there's the CODEC register maps as well.
