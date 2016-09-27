From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 4/5] ASoC: fsl_ssi: use flat regmap cache
Date: Wed, 28 Sep 2016 01:23:33 +0200
Message-ID: <57EAFF75.60903@maciej.szmigiero.name>
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
 <20160926191338.cxqqqq5eybxqxqss@sirena.org.uk>
 <4f47f4e7-2d13-93b0-52bd-c9aadc492cf8@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 75E922606F8
 for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2016 01:23:38 +0200 (CEST)
In-Reply-To: <4f47f4e7-2d13-93b0-52bd-c9aadc492cf8@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

On 26.09.2016 21:25, Marek Vasut wrote:
> On 09/26/2016 09:13 PM, Mark Brown wrote:
(..)
>> So, can we get a clear decision on this after testing?  The discussion
>> here and the discussion on IRC are a bit disjointed and I'd like to make
>> sure we end up with something that definitely works.
>>
> I think 1,2,3,4 are certainly harmless. I think even 5 is harmless (at
> least according to my testing on MX6Q and MX6SX, which is not the
> greatest sample), but can be safely reverted if there are concerns.

I've tested current sound/for-next on UDOO board and was able to reproduce
a lockup on reloading fsl sound modules.
The exact test was playing 30 second sound file and reloading modules in
a loop.
The lockup would happen sometimes almost immediately and sometimes after
~30 minutes of such testing.

When I reverted commit 7de2763d9b325ee5e7e24ac513c93394406cfefa
(that is, number 5) it seems that it no longer locks up.

> I also believe the following two patches should be backported for stable
> 4.7 (they were part of tag 'regmap-fix-v4.8-rc5' of
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap):
> 
> commit b2c7f5d9c939a37c1ce7f86a642de70e3033ee9e
> Author: Maarten ter Huurne <maarten@treewalker.org>
> Date:   Fri Jul 29 23:42:12 2016 +0200
> 
>     regmap: cache: Fix num_reg_defaults computation from reg_defaults_raw
> 
> commit 1bc8da4e143c0fd8807e061a66d91d5972601ab1
> Author: Lars-Peter Clausen <lars@metafoo.de>
> Date:   Thu Aug 4 17:22:16 2016 +0200
> 
>     regmap: rbtree: Avoid overlapping nodes
> 

I can see that
"regmap: cache: Fix num_reg_defaults computation from reg_defaults_raw" is
present in the tree that I have tested.
 
Maciej
