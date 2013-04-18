From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 10/17] ASoC: mxs: Use generic dmaengine PCM
Date: Thu, 18 Apr 2013 17:04:56 +0200
Message-ID: <51700B98.9030502@metafoo.de>
References: <1366046404-8759-1-git-send-email-lars@metafoo.de>
 <1366046404-8759-11-git-send-email-lars@metafoo.de>
 <20130417084304.GK11245@S2101-09.ap.freescale.net>
 <516E6B2B.5000805@metafoo.de>
 <20130417135003.GA20563@S2101-09.ap.freescale.net>
 <516FB726.4080304@metafoo.de>
 <20130418150050.GE2222@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-200.synserver.de (smtp-out-202.synserver.de
 [212.40.185.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 69303264F00
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 17:05:45 +0200 (CEST)
In-Reply-To: <20130418150050.GE2222@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, Sebastien Guiriec <s-guiriec@ti.com>, Markus Pargmann <mpa@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 04/18/2013 05:00 PM, Shawn Guo wrote:
> On Thu, Apr 18, 2013 at 11:04:38AM +0200, Lars-Peter Clausen wrote:
>> On 04/17/2013 03:50 PM, Shawn Guo wrote:
>>> On Wed, Apr 17, 2013 at 11:28:11AM +0200, Lars-Peter Clausen wrote:
>>>> Can you see whether the patch below fixes it?
>>>>
>>> No, it does not fix the problem.
>>>
>>> Shawn
>>
>> Could you try the other patch plus this one:
>>
> Yes, it works now.  Thanks for the fixing, Lars.
> 
> One small correction below on the first patch.
> 

Ok, thanks for testing. Will resent it with the two other patches later today.

- Lars
