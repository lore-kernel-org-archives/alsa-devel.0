From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: dapm: Allow DAPM registers to be
 unsigned int
Date: Thu, 08 Mar 2012 14:10:23 +0100
Message-ID: <4F58AFBF.3060609@metafoo.de>
References: <1331210912-8106-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CAOMZO5DHp3HegJ3C_HFj+M=amd6LdTtUcaXigG=ZpmPHG_TJ9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-091.synserver.de (smtp-out-091.synserver.de
	[212.40.185.91])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CB1F10BA85
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 14:08:31 +0100 (CET)
In-Reply-To: <CAOMZO5DHp3HegJ3C_HFj+M=amd6LdTtUcaXigG=ZpmPHG_TJ9g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 03/08/2012 01:52 PM, Fabio Estevam wrote:
> On Thu, Mar 8, 2012 at 9:48 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
> 
>>        /* dapm control */
>> -       short reg;                                              /* negative reg = no direct dapm */
>> +       unsigned int reg;                       /* negative reg = no direct dapm */
> 
> Maybe you should update the comment now that this is unsigned int.

There are also a few places in soc-dapm.c which check for reg >= 0 to handle
SND_SOC_NOPM, those need to be updated as well.
