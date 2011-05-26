From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: wm1250-ev1: Define "WM1250 Output"
	with SND_SOC_DAPM_OUTPUT
Date: Thu, 26 May 2011 12:04:08 +0100
Message-ID: <4DDE33A8.3090609@ti.com>
References: <1306378452.10398.9.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id AE1AB103ACC
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 13:04:11 +0200 (CEST)
In-Reply-To: <1306378452.10398.9.camel@phoenix>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 26/05/11 03:54, Axel Lin wrote:
> Codec output pin should be defined with SND_SOC_DAPM_OUTPUT.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> Note: 
> Just found this bug while reading the code.
> I don't have this hardware handy. I appreciate if someone can test it.
> 
> Axel
> 

The fix does look correct.

Acked-by: Liam Girdwood <lrg@ti.com>
