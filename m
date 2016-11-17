From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/4] ASoC: wm8523: Remove #if
	IS_ENABLED(CONFIG_I2C)
Date: Thu, 17 Nov 2016 09:29:58 +0000
Message-ID: <20161117092958.GY1575@localhost.localdomain>
References: <87d1hu7vz4.wl%kuninori.morimoto.gx@renesas.com>
 <877f827vuj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id AEDAC2614A0
 for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2016 10:29:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <877f827vuj.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, patches@opensource.wolfsonmicro.com, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 17, 2016 at 01:13:35AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> wm8523 driver doesn't work without CONFIG_I2C anyway.
> Let's remove #if IS_ENABLED(CONFIG_I2C), and use module_i2c_driver().
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
