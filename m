From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: add Wolfson WM8973 codec driver
Date: Fri, 27 Jun 2014 16:07:55 +0200
Message-ID: <53AD7ABB.7010201@metafoo.de>
References: <1403852955-18974-1-git-send-email-xavier.hsu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-029.synserver.de (smtp-out-031.synserver.de
 [212.40.185.31])
 by alsa0.perex.cz (Postfix) with ESMTP id C5D8026530C
 for <alsa-devel@alsa-project.org>; Fri, 27 Jun 2014 16:08:02 +0200 (CEST)
In-Reply-To: <1403852955-18974-1-git-send-email-xavier.hsu@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xavier Hsu <xavier.hsu@linaro.org>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
Cc: andy.green@linaro.org
List-Id: alsa-devel@alsa-project.org

On 06/27/2014 09:09 AM, Xavier Hsu wrote:
> This patch adds support for the wm8973 codec, based on the
> existing wm8971 codec driver.
>

Those two look really similar. Do you think they can both be supported by 
the same driver, rather than duplicating most of the code?

- Lars
