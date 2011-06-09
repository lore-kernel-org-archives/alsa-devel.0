From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: snd_soc_new_{mixer, mux,
 pga} make sure to use right DAPM context
Date: Thu, 9 Jun 2011 14:56:57 +0100
Message-ID: <4DF0D129.8030301@ti.com>
References: <1307618556-32068-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id DD4B7103B52
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 15:57:02 +0200 (CEST)
In-Reply-To: <1307618556-32068-1-git-send-email-lars@metafoo.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@kernel.org" <stable@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 09/06/11 12:22, Lars-Peter Clausen wrote:
> Currently it is possible that snd_soc_new_{mixer,mux,pga} is called with a
> DAPM context not matching the widgets context. This can lead to a wrong
> prefix_len calculation, which will result in undefined behaviour. To avoid
> this always use the DAPM context from the widget itself.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: stable@kernel.org
> 

Acked-by: Liam Girdwood <lrg@ti.com>
