From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: wm8995: Remove unnecessary
	suspend/resume	bias level changes
Date: Wed, 3 Sep 2014 09:22:19 +0100
Message-ID: <20140903082219.GM12043@opensource.wolfsonmicro.com>
References: <1409689234-14774-1-git-send-email-lars@metafoo.de>
 <1409689234-14774-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E9CDD26563D
 for <alsa-devel@alsa-project.org>; Wed,  3 Sep 2014 10:22:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1409689234-14774-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, Mark Brown <broonie@kernel.org>, M R Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 02, 2014 at 10:20:34PM +0200, Lars-Peter Clausen wrote:
> The ASoC core will only call the suspend/resume callbacks when the device's
> DAPM context is idle. Since this driver sets idle_bias_off to true this
> means that the device is already in SND_SOC_BIAS_OFF when the suspend
> callback is called, so there is no need to manually set this state again.
> There is also no need to go to SND_SOC_BIAS_STANDBY in the resume callback
> since the core will go right back to SND_SOC_BIAS_OFF.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
