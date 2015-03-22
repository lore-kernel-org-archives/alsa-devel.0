From: Sergej Sawazki <ce3a@gmx.de>
Subject: Re: [PATCH] ASoC: wm8741: Fix rates constraints values
Date: Sun, 22 Mar 2015 13:15:43 +0100
Message-ID: <550EB26F.8070603@gmx.de>
References: <1426281614-12147-1-git-send-email-ce3a@gmx.de>
 <20150316145739.GJ17136@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FC4826087F
 for <alsa-devel@alsa-project.org>; Sun, 22 Mar 2015 13:15:49 +0100 (CET)
In-Reply-To: <20150316145739.GJ17136@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, liam.r.girdwood@linux.intel.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> On Fri, Mar 13, 2015 at 10:20:14PM +0100, Sergej Sawazki wrote:
>> According to table 11 in the datasheet (Rev 4.3):
>> Example: With a master clock (MCLK) of 11.2896MHz, the following sampling rates (LRCLK) are supported:
>>    44.1kHz (MCLK/256), 88.2kHz (MCLK/128)
>>
>> For the rates lists, we should use 82000 instead of 88235 and 176400 instead of 1764000 (seems to be a typo).
>>
>> Signed-off-by: Sergej Sawazki <ce3a@gmx.de>
>> ---
>
> Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
>
> Thanks,
> Charles
>
Thanks,
Sergej
