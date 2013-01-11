From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/8] ASoC: Add support for virtual switch
	controls
Date: Fri, 11 Jan 2013 16:05:53 +0100
Message-ID: <50F02A51.3010108@metafoo.de>
References: <1357833977-3682-1-git-send-email-lars@metafoo.de>
 <1357833977-3682-2-git-send-email-lars@metafoo.de>
 <20130111121912.GY20956@opensource.wolfsonmicro.com>
 <50F007DF.9000606@metafoo.de>
 <20130111124535.GZ20956@opensource.wolfsonmicro.com>
 <50F00BF1.6090702@metafoo.de>
 <20130111135754.GB20956@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-055.synserver.de (smtp-out-055.synserver.de
 [212.40.185.55])
 by alsa0.perex.cz (Postfix) with ESMTP id 4ECE1264ED1
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2013 16:05:12 +0100 (CET)
In-Reply-To: <20130111135754.GB20956@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 01/11/2013 02:57 PM, Mark Brown wrote:
> On Fri, Jan 11, 2013 at 01:56:17PM +0100, Lars-Peter Clausen wrote:
>> On 01/11/2013 01:45 PM, Mark Brown wrote:
> 
>>> Virtual enums do actually end up routing, that's not what a mute control
>>> usually does.  You can do the above in the manner I suggested, just have
>>> the register forced to a particular value when the DAC is disabled.
> 
>> Well, that's what the code does. The alternative is to implement more or
> 
> No, it's not (at least not according to the changelog).  It implements a
> totally separate virtual control.

What do you mean by 'separate'? Maybe this is was causes the confusion. Do
you mean a separate DAPM control, like DAPM_SWITCH? That's not what the
patch does it creates a virtual kcontrol, which can be used to control a
mixers input. It's the pendant to SOC_DAPM_ENUM_VIRT not to
SND_SOC_DAPM_VIRT_MUX. I realize that the commit message may have been a bit
ambiguous in that regard.

- Lars
