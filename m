From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] ASoC: rt5640: enable LDO1 before
	creating regmap
Date: Thu, 13 Jun 2013 09:09:53 -0600
Message-ID: <51B9E0C1.4040601@wwwdotorg.org>
References: <1371072864-13205-1-git-send-email-swarren@wwwdotorg.org>
 <1371072864-13205-2-git-send-email-swarren@wwwdotorg.org>
 <20130613093038.GW1403@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 46D122651E4
 for <alsa-devel@alsa-project.org>; Thu, 13 Jun 2013 17:09:57 +0200 (CEST)
In-Reply-To: <20130613093038.GW1403@sirena.org.uk>
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
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 06/13/2013 03:30 AM, Mark Brown wrote:
> On Wed, Jun 12, 2013 at 03:34:24PM -0600, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>> 
>> Enable the LDO1_EN GPIO to the CODEC, which enables the device to
>> show up on the I2C bus, before creating the regmap object. This
>> guarantees that if devm_regmap_init_i2c() were to attempt to
>> communicate with the device, it would be able to.
> 
> Is this an actual issue?  Unless specifically asked to the regmap
> code really shouldn't be interacting with the hardware and the
> ordering the code currently has is the standard one so if we're
> having problems then a number of other drivers ought to be fixed.

This doesn't solve a current failure. It just seems to me that one
shouldn't create the regmap object until it's actually possible to use it.
