From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH] ASoC: sam9g20ek: Let device core handle
	pinctrl
Date: Tue, 7 May 2013 17:27:20 +0800
Message-ID: <5188C8F8.3020807@atmel.com>
References: <1367868508-12329-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <51886282.8060106@atmel.com> <20130507090116.GO7478@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.243])
 by alsa0.perex.cz (Postfix) with ESMTP id BB62026262D
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2013 11:27:57 +0200 (CEST)
In-Reply-To: <20130507090116.GO7478@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 5/7/2013 17:01, Mark Brown wrote:
> On Tue, May 07, 2013 at 10:10:10AM +0800, Bo Shen wrote:
>> On 5/7/2013 03:28, Mark Brown wrote:
>
>>> Since commit ab78029 (drivers/pinctrl: grab default handles from device
>>> core) we can rely on device core for handling pinctrl so remove
>>> devm_pinctrl_get_select_default() from the driver.
>
>> I have one question: with this patch, if lose default pinctrl
>> configuration in dts/dtsi file, how should we know that?
>
> I'd hope the core does something sensible with this, though I've not
> checked.

except this consideration.

Tested-by: Bo Shen <voice.shen@atmel.com>
Acked-by: Bo Shen <voice.shen@atmel.com>

Best Regards,
Bo Shen
