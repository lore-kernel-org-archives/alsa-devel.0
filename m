From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: snd_soc_codec_set_cache_io does not set
 codec->hw_write callback now
Date: Tue, 4 Oct 2011 10:51:24 +0100
Message-ID: <20111004095124.GA3250@opensource.wolfsonmicro.com>
References: <1317720272.2536.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 474F9245B5
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 11:51:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317720272.2536.2.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 04, 2011 at 05:24:32PM +0800, Axel Lin wrote:

> I just found that after commit be3ea3b9e
> "SoC: Use new register map API for ASoC generic physical I/O",
> snd_soc_codec_set_cache_io does not set codec->hw_write any more.

> It is still used in some drivers. e.g.
> In wm8988_resume, we call codec->hw_write(codec->control_data, data, 2);

> For the drivers that is using snd_soc_codec_set_cache_io now,
> where is the place to set codec->hw_write callback now? 

These drivers should be using the standard I/O functions, probably
they're looking for the cache_bypass flag.  Either that or convert to
use regmap directly.
