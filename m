From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Constify snd_soc_dai_ops structs
Date: Wed, 23 Nov 2011 10:47:28 +0000
Message-ID: <20111123104728.GL4332@opensource.wolfsonmicro.com>
References: <1322044840-32709-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17EEE103C6C
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 11:47:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322044840-32709-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 23, 2011 at 11:40:40AM +0100, Lars-Peter Clausen wrote:
> Commit 1ee46ebd("ASoC: Make the DAI ops constant in the DAI structure")
> introduced the possibility to have constant DAI ops structures, yet this is
> barley used in both existing drivers and also new drivers being submitted,
> although none of them modifies its DAI ops structure. The later is not
> surprising since existing drivers are often used as templates for new drivers.
> So this patch just constifies all existing snd_soc_dai_ops structs to eliminate
> the issue altogether.

Applied, thanks.
