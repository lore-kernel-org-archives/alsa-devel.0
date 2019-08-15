From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH -next] ASoC: wm8737: Fix copy-paste error
 in wm8737_snd_controls
Date: Thu, 15 Aug 2019 11:08:11 +0100
Message-ID: <20190815100811.GO54126@ediswmail.ad.cirrus.com>
References: <20190815091920.64480-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7F4AF801DF
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 12:08:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190815091920.64480-1-yuehaibing@huawei.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: YueHaibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, patches@opensource.cirrus.com, tglx@linutronix.de, info@metux.net
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 15, 2019 at 05:19:20PM +0800, YueHaibing wrote:
> sound/soc/codecs/wm8737.c:112:29: warning:
>  high_3d defined but not used [-Wunused-const-variable=]
> 
> 'high_3d' should be used for 3D High Cut-off.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 2a9ae13a2641 ("ASoC: Add initial WM8737 driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
