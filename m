From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCHv3 7/9] WM8971 improves the function of
	regmap
Date: Thu, 11 Sep 2014 09:06:27 +0200
Message-ID: <541149F3.4070404@metafoo.de>
References: <1409628470-13059-1-git-send-email-xavier.hsu@linaro.org>
 <1409628470-13059-7-git-send-email-xavier.hsu@linaro.org>
 <540769BA.8010606@metafoo.de>
 <CAHa2TOYKfTqZZ-ejpNT=5ga5uOASCOZnKbnWUCXB33QPCA+MSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-130.synserver.de (smtp-out-130.synserver.de
 [212.40.185.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C973262631
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 09:06:23 +0200 (CEST)
In-Reply-To: <CAHa2TOYKfTqZZ-ejpNT=5ga5uOASCOZnKbnWUCXB33QPCA+MSA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xavier Hsu <xavier.hsu@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Andy Green <andy.green@linaro.org>, patches@opensource.wolfsonmicro.com, Patch Tracking <patches@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 09/11/2014 05:21 AM, Xavier Hsu wrote:
> Hi Charles and Lars-Peter:
> Thanks for your feedback.
> I will modify our patch as below.
> 1. Using (codec->control_data = wm8971->regmap;) or (wm8971_get_regmap) to
> register regmap.

You should use neither. The ASoC core is able to get the regmap instance by 
calling dev_get_regmap(), no changes are necessary to the driver.

- Lars
