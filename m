From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 10/19] ASoC: Intel: add mrfld DSP registers
Date: Fri, 20 Jun 2014 17:02:19 +0530
Message-ID: <20140620113219.GI22053@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <1402662848-24534-11-git-send-email-vinod.koul@intel.com>
 <53A3EF46.9000704@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 28D6E261B1E
 for <alsa-devel@alsa-project.org>; Fri, 20 Jun 2014 13:32:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <53A3EF46.9000704@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 20, 2014 at 10:22:30AM +0200, Lars-Peter Clausen wrote:
> On 06/13/2014 02:33 PM, Vinod Koul wrote:
> >+unsigned int sst_soc_read(struct snd_soc_platform *platform,
> >+			unsigned int reg)
> >+{
> >+	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
> >+
> >+	pr_debug("%s: reg[%d] = %#x\n", __func__, reg, drv->widget[reg]);
> >+	BUG_ON(reg > (SST_NUM_WIDGETS - 1));
> >+	return drv->widget[reg];
> >+}
> >+
> >+int sst_soc_write(struct snd_soc_platform *platform,
> >+		  unsigned int reg, unsigned int val)
> >+{
> >+	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
> >+
> >+	pr_debug("%s: reg[%d] = %#x\n", __func__, reg, val);
> >+	BUG_ON(reg > (SST_NUM_WIDGETS - 1));
> >+	drv->widget[reg] = val;
> >+	return 0;
> >+}
> 
> These seem to be purely virtual registers, what is this about? The
> DAPM core is able to handle widgets and controls without any
> register backing just fine. There is no need to emulate virtual
> registers.
But we need to store the mixer configuration for sending IPCs to DSP. So virtual
register file is very much required

> >+
> >+unsigned int sst_reg_read(struct sst_data *drv, unsigned int reg,
> >+			  unsigned int shift, unsigned int max)
> >+{
> [...]
> >+}
> >+
> >+unsigned int sst_reg_write(struct sst_data *drv, unsigned int reg,
> >+			   unsigned int shift, unsigned int max, unsigned int val)
> >+{
> [..]
> >+}
> 
> How are these functions different from snd_soc_platform_{read,update_bits}()?
Should be possible, I will check!

-- 
~Vinod
