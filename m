From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Allow source specification for CODEC
 level sysclk
Date: Tue, 30 Aug 2011 16:58:02 +0100
Message-ID: <20110830155802.GN2061@opensource.wolfsonmicro.com>
References: <1314212978-18293-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4E5D07E7.80305@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1F0C8246EB
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Aug 2011 17:58:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E5D07E7.80305@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 30, 2011 at 05:55:19PM +0200, Lars-Peter Clausen wrote:

> > Add a source argument to the CODEC driver set_sysclk() operation to
> > reflect this. As this operation is not as widely used as the DAI
> > set_sysclk() operation the change is not very invasive. We probably
> > ought to go and make the same alternation for DAIs at some point.

> If we also want to change the DAI driver's set_sysclck we should probably do
> this better now than later, because the number of affected drivers is probably
> not going to decline.

At some point; at any rate we don't need to do both in the same commit.

> The adau1701 and adav80x drivers also implement the CODEC driver set_sysclk.

I've actually fixed this up already in my local copy.
