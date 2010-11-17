From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: Cyclic dependency between soc.h and
	soc-dapm.h
Date: Wed, 17 Nov 2010 18:44:11 +0000
Message-ID: <20101117184411.GE19488@rakim.wolfsonmicro.main>
References: <4CE3E7AE.7040308@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D7BF7103894
	for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2010 19:44:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CE3E7AE.7040308@metafoo.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 17, 2010 at 03:33:18PM +0100, Lars-Peter Clausen wrote:

[Reflowed into 80 columns, please look into your MUA configuration.]

> So I wonder if soc-dapm.h should be made completely internal and not
> be included anywhere else but soc.h anymore?

I think this is the simplest approach - the separation is useful for
code legibility but I don't think it's going to make a meanigful
difference if you always end up with both at compile time.
