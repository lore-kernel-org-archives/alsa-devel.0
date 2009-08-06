From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: change set_tdm_slot api to allow
 slot_width override.
Date: Thu, 6 Aug 2009 16:01:36 +0100
Message-ID: <20090806150135.GA32298@rakim.wolfsonmicro.main>
References: <1245113071.24109.559.camel@brutus>
	<20090804205545.GB29518@sirena.org.uk> <4A7AEA66.5010408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4A00824487
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Aug 2009 17:01:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A7AEA66.5010408@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Philipp Zabel <philipp.zabel@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Daniel Ribeiro <drwyrm@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 06, 2009 at 10:36:22PM +0800, Eric Miao wrote:

> I seem to remember this failed on Littleton - playback just doesn't work
> any more, and DMA looks to be inactive. Didn't follow this thread for a
> long time, but Daniel, could you repost the whole series if you have any
> update

I don't think anyone actually reported that on the list at the time.
Actually, speaking of Littleton it'd be good to get at least the CODEC
driver merged - ISTR the issues with that should all be fairly simple to
resolve and there's no need to wait for the machine support before
merging the CODEC driver.

I've pushed the patches to a branch on my ASoC git:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

and reposted them a minute ago.
