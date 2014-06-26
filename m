From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 10/19] ASoC: Intel: add mrfld DSP registers
Date: Thu, 26 Jun 2014 15:52:49 +0530
Message-ID: <20140626102249.GV22053@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <1402662848-24534-11-git-send-email-vinod.koul@intel.com>
 <53A3EF46.9000704@metafoo.de> <20140620113219.GI22053@intel.com>
 <53A42A0F.5070806@metafoo.de> <20140621062234.GK22053@intel.com>
 <53A52CAA.2030101@metafoo.de> <20140623042746.GO22053@intel.com>
 <53AA5095.1080206@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A1DFA261734
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 12:23:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <53AA5095.1080206@metafoo.de>
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

On Wed, Jun 25, 2014 at 06:31:17AM +0200, Lars-Peter Clausen wrote:
> On 06/23/2014 06:27 AM, Vinod Koul wrote:
> >On Sat, Jun 21, 2014 at 08:56:42AM +0200, Lars-Peter Clausen wrote:
> >>On 06/21/2014 08:22 AM, Vinod Koul wrote:
> >>>On Fri, Jun 20, 2014 at 02:33:19PM +0200, Lars-Peter Clausen wrote:
> >>>>On 06/20/2014 01:32 PM, Vinod Koul wrote:
> >>>>>On Fri, Jun 20, 2014 at 10:22:30AM +0200, Lars-Peter Clausen wrote:
> >>>>>>On 06/13/2014 02:33 PM, Vinod Koul wrote:
> >>>>>>>+unsigned int sst_soc_read(struct snd_soc_platform *platform,
> >>>>>>>+			unsigned int reg)
> >>>>>>>+{
> >>>>>>>+	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
> >>>>>>>+
> >>>>>>>+	pr_debug("%s: reg[%d] = %#x\n", __func__, reg, drv->widget[reg]);
> >>>>>>>+	BUG_ON(reg > (SST_NUM_WIDGETS - 1));
> >>>>>>>+	return drv->widget[reg];
> >>>>>>>+}
> >>>>>>>+
> >>>>>>>+int sst_soc_write(struct snd_soc_platform *platform,
> >>>>>>>+		  unsigned int reg, unsigned int val)
> >>>>>>>+{
> >>>>>>>+	struct sst_data *drv = snd_soc_platform_get_drvdata(platform);
> >>>>>>>+
> >>>>>>>+	pr_debug("%s: reg[%d] = %#x\n", __func__, reg, val);
> >>>>>>>+	BUG_ON(reg > (SST_NUM_WIDGETS - 1));
> >>>>>>>+	drv->widget[reg] = val;
> >>>>>>>+	return 0;
> >>>>>>>+}
> >>>>>>
> >>>>>>These seem to be purely virtual registers, what is this about? The
> >>>>>>DAPM core is able to handle widgets and controls without any
> >>>>>>register backing just fine. There is no need to emulate virtual
> >>>>>>registers.
> >>>>>But we need to store the mixer configuration for sending IPCs to DSP. So virtual
> >>>>>register file is very much required
> >>>>
> >>>>Hm, ok. But how does this work, when is the IPC triggered and why
> >>>>can't the IPC be done from within the write function?
> >>>Write can come at any time, even when DSP is inactive. Also we want to tell DSP
> >>>about the paths which are active
> >>>
> >>>So most of IPCs are sent from DAPM widget handlers with exception of controls
> >>>which are active. For those we send IPC during get/put handlers.
> >>
> >>This sounds very similar to the auto-mute controls that are
> >>supported by the ASoC core. Auto-mute controls will update the value
> >>in the put handler, but only if the widget it is attached to is
> >>powered up. If the widget is not powered up the value is stored and
> >>will be written once the widget powers up. Try to see if you can
> >>adopt the auto-mute controls for your usecase. I think this should
> >>allow to remove some of the parts from the driver that peek into
> >>core internal data structures.
> >
> >Do you mean autodisable bit? Btw this seems to be used only in kcontrol creation
> >and not in runtime. Actually I wont find using this feature if we have it :)
> >
> 
> Auto-disable is also used at runtime. If the auto-disable bit in a
> control is set to 1, the control will have the behavior as described
> above.

Ah now understood it, took a while and git history helped :)

Yes this is indeed very interesting, will explore it now

Thanks

-- 
~Vinod
