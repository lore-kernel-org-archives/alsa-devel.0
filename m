From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: add Wolfson WM8973 codec driver
Date: Tue, 1 Jul 2014 12:05:00 +0100
Message-ID: <20140701110500.GA19534@opensource.wolfsonmicro.com>
References: <1403852955-18974-1-git-send-email-xavier.hsu@linaro.org>
 <53AD7ABB.7010201@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 511782619D8
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 13:05:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <53AD7ABB.7010201@metafoo.de>
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
Cc: andy.green@linaro.org, Xavier Hsu <xavier.hsu@linaro.org>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, patches@linaro.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 27, 2014 at 04:07:55PM +0200, Lars-Peter Clausen wrote:
> On 06/27/2014 09:09 AM, Xavier Hsu wrote:
>> This patch adds support for the wm8973 codec, based on the
>> existing wm8971 codec driver.
>>
>
> Those two look really similar. Do you think they can both be supported by 
> the same driver, rather than duplicating most of the code?
>
> - Lars

I am not super familiar with these two devices but looking
through the two datasheets it certainly seems they should be
supported by the same driver. I would like to see some reason if
we were to not go down this route.

Thanks,
Charles
