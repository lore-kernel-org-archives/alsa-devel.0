From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] ASoC: mpc8610: tell the CS4270 codec that
 it's the master
Date: Wed, 23 Nov 2011 05:30:08 +0000
Message-ID: <4ECC84DE.6010802@freescale.com>
References: <1321994339-21906-1-git-send-email-timur@freescale.com>
	<20111122230558.GC3005@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BA29103822
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 06:30:16 +0100 (CET)
In-Reply-To: <20111122230558.GC3005@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <5B76D02302A91043B07C46CA815F2506@freescale.net>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, Nov 22, 2011 at 02:38:59PM -0600, Timur Tabi wrote:
>> Commit ac601555 ("ASoC: Return early with -EINVAL if invalid dai format is
>> detected") requires the machine driver to tell the CS4270 codec driver
>> whether the CS4270 should be configured for master or slave operation.
>
> Applied, thanks.

So it turns out that the commit message for this patch is wrong.  Sorry.

The commit that broke the MPC8610 is "ASoC: Allow DAI formats to be 
specified in the dai_link", which changed the definition of 
SND_SOC_DAIFMT_CBM_CFM to a non-zero value.  Patch "ASoC: Return early 
with -EINVAL if invalid dai format is detected" doesn't really do anything.

I don't know if it's too late to amend the commit, but if it isn't, the 
proper message is:

Commit 4eae080d ("ASoC: Add cs4270 support for slave mode configurations") 
requires the machine driver to set one of the SND_SOC_DAIFMT_CBx_xxx 
values.  The MPC8610 machine driver should be setting 
SND_SOC_DAIFMT_CBM_CFM, but since that value is zero, no one noticed.

Commit 75d9ac46 ("ASoC: Allow DAI formats to be specified in the 
dai_link"), however, changed the value of SND_SOC_DAIFMT_CBM_CFM from zero 
to a non-zero value, which means that it now needs to be specifically set 
by the machine driver.

-- 
Timur Tabi
Linux kernel developer at Freescale
