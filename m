Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 738EF2665CC
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 10:38:03 +0100 (CET)
Date: Wed, 16 Nov 2016 09:38:15 +0000
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Message-ID: <20161116093815.GR1575@localhost.localdomain>
References: <871syd9vq9.wl%kuninori.morimoto.gx@renesas.com>
 <87y40l8h47.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87y40l8h47.wl%kuninori.morimoto.gx@renesas.com>
Subject: Re: [alsa-devel] [PATCH 02/19] ASoC: wm9081: Convert to
 module_i2c_driver()
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-ID: <alsa-devel@alsa-project.org>

On Tue, Nov 15, 2016 at 05:09:39AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> wm9081 driver doesn't work without CONFIG_I2C anyway.
> Let's depend on it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Would be nice to CC patches@opensource.wolfsonmicro.com on these,
but otherwise:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
