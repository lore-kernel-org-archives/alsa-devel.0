From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 09/11] ASoC: Intel: hdac_hdmi: Set ops
 to NULL on remove
Date: Tue, 18 Jun 2019 08:58:22 -0700
Message-ID: <bd8855a7ab7a9958113631b76706120fd4427631.camel@linux.intel.com>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
         <20190617113644.25621-10-amadeuszx.slawinski@linux.intel.com>
         <75be86354032f4886cbaf7d430de2aa89eaab573.camel@linux.intel.com>
         <20190618130015.0fc388b4@xxx>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190618130015.0fc388b4@xxx>
Sender: linux-kernel-owner@vger.kernel.org
To: Amadeusz =?UTF-8?Q?S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2019-06-18 at 13:00 +0200, Amadeusz Sławiński wrote:
> On Mon, 17 Jun 2019 13:51:42 -0700
> Ranjani Sridharan <ranjani.sridharan@linux.intel.com> wrote:
> 
> > On Mon, 2019-06-17 at 13:36 +0200, Amadeusz Sławiński wrote:
> > > When we unload Skylake driver we may end up calling
> > > hdac_component_master_unbind(), it uses acomp->audio_ops, which
> > > we
> > > set
> > > in hdmi_codec_probe(), so we need to set it to NULL in
> > > hdmi_codec_remove(),
> > > otherwise we will dereference no longer existing pointer.  
> > 
> > Hi Amadeusz,
> > 
> > It looks like the audio_ops should be deleted
> > snd_hdac_acomp_exit().
> > Also, this doesnt seem to be the case with when the SOF driver is
> > removed.
> > Could you please give a bit more context on what error you see when
> > this happens?
> 
> Hi,
> 
> I get Oops. This is what happens with all other patches in this
> series and only this one reverted:
> 
> root@APL:~# rmmod snd_soc_sst_bxt_rt298
> root@APL:~# rmmod snd_soc_hdac_hdmi
> root@APL:~# rmmod snd_soc_skl

Thanks, Amadeusz. I think the order in which the drivers are removed is
what's causing the oops in your case. With SOF, the order we remove is

1. rmmod sof_pci_dev
2. rmmod snd_soc_sst_bxt_rt298
3. rmmod snd_soc_hdac_hdmi

Thanks,
Ranjani
