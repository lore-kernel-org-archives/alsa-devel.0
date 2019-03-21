From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 -next] ASoC: wm_adsp: Make some
	variables static
Date: Thu, 21 Mar 2019 09:10:57 +0000
Message-ID: <20190321091057.GW46536@ediswmail.ad.cirrus.com>
References: <20190321020106.11096-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 19795F80C0F
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 10:11:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20190321020106.11096-1-yuehaibing@huawei.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, tiwai@suse.com, rf@opensource.cirrus.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 21, 2019 at 10:01:06AM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warnings:
> 
> sound/soc/codecs/wm_adsp.c:309:20: warning: symbol 'wm_adsp1_ops' was not declared. Should it be static?
> sound/soc/codecs/wm_adsp.c:310:20: warning: symbol 'wm_adsp2_ops' was not declared. Should it be static?
> sound/soc/codecs/wm_adsp.c:311:20: warning: symbol 'wm_halo_ops' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Thanks for the patch but afraid a fix for this was merged
yesterday.

Thanks,
Charles
