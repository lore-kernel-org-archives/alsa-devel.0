From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Remove redundant freq assignment for
	max98095->sysclk/max98088->sysclk
Date: Fri, 27 May 2011 22:13:50 +0100
Message-ID: <4DE0140E.6050905@ti.com>
References: <1306510253.19556.36.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id EA17D24466
	for <alsa-devel@alsa-project.org>;
	Fri, 27 May 2011 23:13:56 +0200 (CEST)
In-Reply-To: <1306510253.19556.36.camel@phoenix>
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
Cc: Peter Hsiang <peter.hsiang@maxim-ic.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Hsiang <cdefgab1288@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 27/05/11 16:30, Axel Lin wrote:
> Current implementation set max98095->sysclk/max98088->sysclk to freq twice.
> Set it once is enough, this patch removes the first assignment in case
> we may set invalid clock frequency to max98095->sysclk/max98088->sysclk.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> hi Peter,
> I don't have this hardware handy. Can you help to test it?
> Thanks,
> Axel
> 

Acked-by: Liam Girdwood <lrg@ti.com>
