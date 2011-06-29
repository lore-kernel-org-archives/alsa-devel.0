From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Rename WM8915 to WM8996
Date: Wed, 29 Jun 2011 10:31:15 +0100
Message-ID: <4E0AF0E3.2060708@ti.com>
References: <1309317832-24241-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<07ce01cc362e$7fac3710$7f04a530$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D1DE103832
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jun 2011 11:31:22 +0200 (CEST)
In-Reply-To: <07ce01cc362e$7fac3710$7f04a530$%kim@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 29/06/11 08:30, Kukjin Kim wrote:
> Mark Brown wrote:
>>
>> For marketing reasons the part will be called WM8996. In order to avoid
>> user confusion rename the driver to reflect this.
>>
>> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> ---
>>
>> The cross tree issues make this difficult to merge as there's
>> dependencies in both ASoC and Samsung trees - Kukjin, would you be OK
>> with merging this via ALSA late on in the merge window after both
>> Samsung and ASoC trees have merged?
>>
> Yes, it's ok to me :)
> 
> As a note, basically my tree will be sent to upstream via rmk during merge
> window so I'm not sure when it is merged.
> 
>> I will have a go at constructing some branches which do the right thing
>> and can be merged now (so a base rename patch then a merge of that into
>> ASoC which deals with all the work that has been done in the driver this
>> release cycle) but I wanted to get this first option out there now.
>>
>>  arch/arm/mach-s3c64xx/mach-crag6410.c |   18 +-
> 
> If required,
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 

Acked-by: Liam Girdwood <lrg@ti.com>
