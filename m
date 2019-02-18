From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH -next] ASoC: wm8741: Make function
	'wm8741_mute' static
Date: Mon, 18 Feb 2019 09:45:01 +0000
Message-ID: <20190218094501.GA27940@ediswmail.ad.cirrus.com>
References: <20190216013556.117839-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 05457266A9D
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 10:45:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20190216013556.117839-1-weiyongjun1@huawei.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.cirrus.com, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Sergej Sawazki <sergej@taudac.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 16, 2019 at 01:35:56AM +0000, Wei Yongjun wrote:
> Fixes the following sparse warning:
> 
> sound/soc/codecs/wm8741.c:371:5: warning:
>  symbol 'wm8741_mute' was not declared. Should it be static?
> 
> Fixes: 36b1599340b5 ("ASoC: wm8741: Add digital mute callback")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
