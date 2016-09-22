From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 4/5] ASoC: fsl_ssi: use flat regmap cache
Date: Fri, 23 Sep 2016 01:38:24 +0200
Message-ID: <57E46B70.2070005@maciej.szmigiero.name>
References: <20160919193029.8119-1-marex@denx.de>
 <20160919193029.8119-4-marex@denx.de>
 <57E2B53C.6080708@maciej.szmigiero.name>
 <b54cd59a-97d0-e02d-16be-7aa6752bbb35@denx.de>
 <57E3074E.4070601@maciej.szmigiero.name>
 <8d5ad78b-3850-93bd-e299-215f001da9c2@denx.de>
 <57E318DB.3040600@maciej.szmigiero.name>
 <20160922104530.GL7994@sirena.org.uk>
 <0ae54910-0712-006c-0afa-a59b63a904be@maciej.szmigiero.name>
 <5506d5e4-4480-3a7d-9455-b314070bda7c@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 5864226697F
 for <alsa-devel@alsa-project.org>; Fri, 23 Sep 2016 01:38:30 +0200 (CEST)
In-Reply-To: <5506d5e4-4480-3a7d-9455-b314070bda7c@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On 22.09.2016 17:27, Marek Vasut wrote:
> On 09/22/2016 04:37 PM, Maciej S. Szmigiero wrote:
>> On 22.09.2016 12:45, Mark Brown wrote:
>>> On Thu, Sep 22, 2016 at 01:33:47AM +0200, Maciej S. Szmigiero wrote:
>>>
(..)
>> It looks to me 1) is an easier and safer solution, especially that
>> the driver previously worked fine with RB tree cache.
>> I would test this myself but unfortunately I don't have access to
>> hardware this week.
> 
> I believe switching to flat cache is harmless and it should be a better
> mode for devices with small mmio address spaces. After some discussion
> on IRC, I believe [1] should resolve the RBTREE crash (?).
> 
> [1]
> http://git.kernel.org/cgit/linux/kernel/git/broonie/regmap.git/commit/?h=for-next&id=b2c7f5d9c939a37c1ce7f86a642de70e3033ee9e

I assume you meant "flat cache crash" not "RBTREE crash".

I will test flat cache version with this patch as soon as I get
my UDOO board back (probably next week) - maybe everything will be
fine.

Maciej
