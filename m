From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: alc5623: Convert codec->hw_read
	to regmap_read
Date: Thu, 13 Oct 2011 23:52:37 +0100
Message-ID: <20111013225237.GA2952@opensource.wolfsonmicro.com>
References: <1318490575.2857.8.camel@phoenix>
	<20111013165129.GO5193@opensource.wolfsonmicro.com>
	<CAF+7xWkVLNgToGiEn+xqgnii7QozNu0QAf2U-kXRNRtVK0dkqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E33A72433E
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 00:52:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAF+7xWkVLNgToGiEn+xqgnii7QozNu0QAf2U-kXRNRtVK0dkqA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnaud Patard <arnaud.patard@rtp-net.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2011 at 06:39:43AM +0800, Axel Lin wrote:
> 2011/10/14 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > Probably the best thing here is to convert all these drivers to use
> > cache_bypass to read directly through the cache - the same thing will
> > then work with direct regmap usage.

> I don't complete understand "use cache_bypass to read directly through
> the cache".

Set the cache_bypass flag in the device struct.

> Or do you mean changes like below instead of calling regmap_read directly?

No, this isn't going to work.  snd_soc_read() will use the cache.
