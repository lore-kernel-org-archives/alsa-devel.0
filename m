From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 4/5] ASoC: fsl_ssi: use flat regmap cache
Date: Thu, 22 Sep 2016 17:27:42 +0200
Message-ID: <5506d5e4-4480-3a7d-9455-b314070bda7c@denx.de>
References: <20160919193029.8119-1-marex@denx.de>
 <20160919193029.8119-4-marex@denx.de>
 <57E2B53C.6080708@maciej.szmigiero.name>
 <b54cd59a-97d0-e02d-16be-7aa6752bbb35@denx.de>
 <57E3074E.4070601@maciej.szmigiero.name>
 <8d5ad78b-3850-93bd-e299-215f001da9c2@denx.de>
 <57E318DB.3040600@maciej.szmigiero.name>
 <20160922104530.GL7994@sirena.org.uk>
 <0ae54910-0712-006c-0afa-a59b63a904be@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 40E57266499
 for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2016 17:27:44 +0200 (CEST)
In-Reply-To: <0ae54910-0712-006c-0afa-a59b63a904be@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On 09/22/2016 04:37 PM, Maciej S. Szmigiero wrote:
> On 22.09.2016 12:45, Mark Brown wrote:
>> On Thu, Sep 22, 2016 at 01:33:47AM +0200, Maciej S. Szmigiero wrote:
>>
>>> In you patch 5/5 there is backtrace with flat cache, but I meant a
>>> backtrace with original RB tree cache code when warning about allocation
>>> being done in atomic context was generated.
>>
>> I think the conclusion of this and some IRC discussion yesterday is that
>> removing patch 5 fixes things - is that right?
> 
> There are three possible solutions:
> 1) Go back to RB tree cache (revert patch 4) and debug the lockdep warning,
> 2) Keep the flat cache introduced by patch 4 but debug the oops at
> cache init time (while keeping defaults read from hardware),
> 3) Keep both patches and risk the same issues that were previously
> caused by hardcoded register defaults in driver.
> However, Marek says the device works fine for him with the patches.
> 
> It looks to me 1) is an easier and safer solution, especially that
> the driver previously worked fine with RB tree cache.
> I would test this myself but unfortunately I don't have access to
> hardware this week.

I believe switching to flat cache is harmless and it should be a better
mode for devices with small mmio address spaces. After some discussion
on IRC, I believe [1] should resolve the RBTREE crash (?).

[1]
http://git.kernel.org/cgit/linux/kernel/git/broonie/regmap.git/commit/?h=for-next&id=b2c7f5d9c939a37c1ce7f86a642de70e3033ee9e

> Maciej
> 


-- 
Best regards,
Marek Vasut
