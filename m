From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH V2 1/3] ASoC: tegra: add tegra30-ahub driver
Date: Fri, 13 Apr 2012 09:54:17 -0600
Message-ID: <4F884C29.9060307@wwwdotorg.org>
References: <1334097121-18897-1-git-send-email-swarren@wwwdotorg.org>
	<20120413101748.GO3168@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 027B0244B0
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Apr 2012 17:54:24 +0200 (CEST)
In-Reply-To: <20120413101748.GO3168@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 04/13/2012 04:17 AM, Mark Brown wrote:
> On Tue, Apr 10, 2012 at 04:31:59PM -0600, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> The AHUB (Audio Hub) is a mux/crossbar which links all audio-related
>> devices except the HDA controller on Tegra30. The devices include the
>> DMA FIFOs, DAM (Digital Audio Mixers), I2S controllers, and SPDIF
>> controller. Audio data may be routed between these devices in various
>> combinations as required by board design/application.
> 
> Applied all, thanks.  I'd have been slightly happier if we'd had the
> machine driver to show how this is used but there's enough plans to
> continue updating the code anyway so it doesn't seem like a big deal.

Thanks.

The existing tegra_wm8903.c machine driver works fine with these Tegra30
modules, so there is a machine driver in place. Or, were you referring
to something more advanced that exposed the AHUB's routing capabilities?

BTW, you'll notice that the AHUB driver uses the same REG_IN_ARRAY macro
as I used in the Tegra20 DAS driver's regmap rework earlier. I'd like to
just use the same macro in both places for consistency. Are you OK with
the DAS driver based on that, or do you still want me to rework the
macro in the DAS driver since the use-case is a little simpler there?

Thanks again.
