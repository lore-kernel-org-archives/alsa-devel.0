From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 12/14] ASoC: wm8978: Use
	devm_regmap_init_i2c()
Date: Thu, 6 Dec 2012 10:13:22 +0530
Message-ID: <CAK9yfHyWLH2yo2ARYdhFEUoKts1GS2OCFfwn+c=H7oBzU9u8-Q@mail.gmail.com>
References: <1353930587-12907-1-git-send-email-sachin.kamat@linaro.org>
 <1353930587-12907-13-git-send-email-sachin.kamat@linaro.org>
 <20121202040743.GP17981@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f50.google.com (mail-vb0-f50.google.com
 [209.85.212.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 5105C2615CF
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 05:43:24 +0100 (CET)
Received: by mail-vb0-f50.google.com with SMTP id fr13so5566274vbb.9
 for <alsa-devel@alsa-project.org>; Wed, 05 Dec 2012 20:43:23 -0800 (PST)
In-Reply-To: <20121202040743.GP17981@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

On 2 December 2012 09:37, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Nov 26, 2012 at 05:19:45PM +0530, Sachin Kamat wrote:
>> devm_regmap_init_i2c() is device managed and makes error
>> handling and code cleanup simpler.
>
> Applied, thanks.

Mark,
Looks like this patch is missed out in your tree.
Please let me know if you want me to re-send this.

-- 
With regards,
Sachin
