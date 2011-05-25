From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoc: sam9g20_wm8731: use the proper
	SYSCKL value
Date: Wed, 25 May 2011 13:21:39 +0100
Message-ID: <4DDCF453.3070805@ti.com>
References: <1306230676-28688-1-git-send-email-nicolas.ferre@atmel.com>
	<20110525111545.GD10797@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id D30CE103806
	for <alsa-devel@alsa-project.org>;
	Wed, 25 May 2011 14:21:42 +0200 (CEST)
In-Reply-To: <20110525111545.GD10797@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 25/05/11 12:15, Mark Brown wrote:
> On Tue, May 24, 2011 at 11:51:16AM +0200, Nicolas Ferre wrote:
>> at91sam9g20 is providing master clock to wm8731: not using a crystal but an
>> external MCLK. We can avoid conflict and save power using WM8731_SYSCLK_MCLK as
>> we do not need oscillator to be powered.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Adding Liam.
> 

Acked-by: Liam Girdwood <lrg@ti.com>
