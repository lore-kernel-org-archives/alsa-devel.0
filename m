From: Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 09/11] ASoC: Intel: hdac_hdmi: Set ops
 to NULL on remove
Date: Wed, 19 Jun 2019 10:38:59 +0200
Message-ID: <20190619103859.15bf51c5@xxx>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
        <20190617113644.25621-10-amadeuszx.slawinski@linux.intel.com>
        <75be86354032f4886cbaf7d430de2aa89eaab573.camel@linux.intel.com>
        <20190618130015.0fc388b4@xxx>
        <bd8855a7ab7a9958113631b76706120fd4427631.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bd8855a7ab7a9958113631b76706120fd4427631.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Cezary Rojewski <cezary.rojewski@intel.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Jun 2019 08:58:22 -0700
Ranjani Sridharan <ranjani.sridharan@linux.intel.com> wrote:

> On Tue, 2019-06-18 at 13:00 +0200, Amadeusz Sławiński wrote:
> > On Mon, 17 Jun 2019 13:51:42 -0700
> > Ranjani Sridharan <ranjani.sridharan@linux.intel.com> wrote:
> >   
> > > On Mon, 2019-06-17 at 13:36 +0200, Amadeusz Sławiński wrote:  
> > > > When we unload Skylake driver we may end up calling
> > > > hdac_component_master_unbind(), it uses acomp->audio_ops, which
> > > > we
> > > > set
> > > > in hdmi_codec_probe(), so we need to set it to NULL in
> > > > hdmi_codec_remove(),
> > > > otherwise we will dereference no longer existing pointer.    
> > > 
> > > Hi Amadeusz,
> > > 
> > > It looks like the audio_ops should be deleted
> > > snd_hdac_acomp_exit().
> > > Also, this doesnt seem to be the case with when the SOF driver is
> > > removed.
> > > Could you please give a bit more context on what error you see
> > > when this happens?  
> > 
> > Hi,
> > 
> > I get Oops. This is what happens with all other patches in this
> > series and only this one reverted:
> > 
> > root@APL:~# rmmod snd_soc_sst_bxt_rt298
> > root@APL:~# rmmod snd_soc_hdac_hdmi
> > root@APL:~# rmmod snd_soc_skl  
> 
> Thanks, Amadeusz. I think the order in which the drivers are removed
> is what's causing the oops in your case. With SOF, the order we
> remove is
> 
> 1. rmmod sof_pci_dev
> 2. rmmod snd_soc_sst_bxt_rt298
> 3. rmmod snd_soc_hdac_hdmi
> 

Well, there is nothing enforcing the order in which modules can be
unloaded (and I see no reason to force it), as you can see from
following excerpt, you can either start unloading from
snd_soc_sst_bxt_rt298 or snd_soc_skl, and yes if you start from
snd_soc_skl, there is no problem.

snd_soc_sst_bxt_rt298    40960  0
snd_soc_hdac_hdmi      45056  1 snd_soc_sst_bxt_rt298
snd_soc_dmic           16384  1
snd_soc_rt298          65536  2 snd_soc_sst_bxt_rt298
snd_soc_rt286          61440  0
snd_soc_rl6347a        16384  2 snd_soc_rt298,snd_soc_rt286
snd_soc_skl           372736  0
snd_soc_sst_ipc        20480  1 snd_soc_skl
snd_soc_sst_dsp        36864  1 snd_soc_skl
snd_hda_ext_core       28672  2 snd_soc_hdac_hdmi,snd_soc_skl
snd_hda_core          139264  3
snd_hda_ext_core,snd_soc_hdac_hdmi,snd_soc_skl
snd_soc_acpi_intel_match    53248  1 snd_soc_skl snd_soc_acpi
16384  2 snd_soc_acpi_intel_match,snd_soc_skl snd_soc_core
405504  6
snd_soc_rt298,snd_soc_rt286,snd_soc_hdac_hdmi,snd_soc_skl,snd_soc_dmic,snd_soc_sst_bxt_rt298
snd_compress           36864  2 snd_soc_core,snd_soc_skl
snd_pcm_dmaengine      16384  1 snd_soc_core snd_pcm
163840  10
snd_soc_rt298,snd_soc_rt286,snd_hda_ext_core,snd_soc_hdac_hdmi,snd_compress,snd_soc_core,snd_soc_skl,snd_hda_core,snd_soc_sst_bxt_rt298,snd_pcm_dmaengine
snd_timer              53248  1 snd_pcm

Amadeusz
