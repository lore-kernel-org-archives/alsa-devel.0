From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] ASoC: tpa6130a2: Use devm_* APIs
Date: Wed, 12 Dec 2012 16:58:48 +0530
Message-ID: <CAK9yfHxAnv4FcLBqRsaMg-ZovbeyOZKs2N3ciVL5wZfFDn0_Zw@mail.gmail.com>
References: <1354878146-28222-1-git-send-email-sachin.kamat@linaro.org>
 <20121209151752.GE6511@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vc0-f179.google.com (mail-vc0-f179.google.com
 [209.85.220.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AA04261662
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 12:28:49 +0100 (CET)
Received: by mail-vc0-f179.google.com with SMTP id p1so569373vcq.38
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 03:28:48 -0800 (PST)
In-Reply-To: <20121209151752.GE6511@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@linaro.org, tiwai@suse.de, Peter Ujfalusi <peter.ujfalusi@ti.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 9 December 2012 20:47, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Dec 07, 2012 at 04:32:26PM +0530, Sachin Kamat wrote:
>> Converted to use devm_gpio_request and devm_regulator_get APIs.
>> These are device managed and make error handling and cleanup
>> a bit simpler.
>
> Applied, thanks.

This patch is missing in your tree.


-- 
With warm regards,
Sachin
