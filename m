From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 10/19] ASoC: Intel: add mrfld DSP registers
Date: Fri, 20 Jun 2014 14:33:19 +0200
Message-ID: <53A42A0F.5070806@metafoo.de>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <1402662848-24534-11-git-send-email-vinod.koul@intel.com>
 <53A3EF46.9000704@metafoo.de> <20140620113219.GI22053@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-017.synserver.de (smtp-out-018.synserver.de
 [212.40.185.18])
 by alsa0.perex.cz (Postfix) with ESMTP id F2B392650CE
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 14:33:18 +0200 (CEST)
In-Reply-To: <20140620113219.GI22053@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 06/20/2014 01:32 PM, Vinod Koul wrote:
> On Fri, Jun 20, 2014 at 10:22:30AM +0200, Lars-Peter Clausen wrote:
>> On 06/13/2014 02:33 PM, Vinod Koul wrote:
>>> +unsigned int sst_soc_read(struct snd_soc_platform *platform,
>>> +			unsigned int reg)
>>> +{
>>> +	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
>>> +
>>> +	pr_debug("%s: reg[%d] = %#x\n", __func__, reg, drv->widget[reg]);
>>> +	BUG_ON(reg > (SST_NUM_WIDGETS - 1));
>>> +	return drv->widget[reg];
>>> +}
>>> +
>>> +int sst_soc_write(struct snd_soc_platform *platform,
>>> +		  unsigned int reg, unsigned int val)
>>> +{
>>> +	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
>>> +
>>> +	pr_debug("%s: reg[%d] = %#x\n", __func__, reg, val);
>>> +	BUG_ON(reg > (SST_NUM_WIDGETS - 1));
>>> +	drv->widget[reg] = val;
>>> +	return 0;
>>> +}
>>
>> These seem to be purely virtual registers, what is this about? The
>> DAPM core is able to handle widgets and controls without any
>> register backing just fine. There is no need to emulate virtual
>> registers.
> But we need to store the mixer configuration for sending IPCs to DSP. So virtual
> register file is very much required

Hm, ok. But how does this work, when is the IPC triggered and why can't the 
IPC be done from within the write function?

- Lars
