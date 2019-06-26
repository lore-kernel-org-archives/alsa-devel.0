From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 0/2] Fixes for SOF module unload/reload
Date: Wed, 26 Jun 2019 00:07:08 -0700
Message-ID: <d6868e311421d8b2e77a67787ad10b7bc4c0829b.camel@linux.intel.com>
References: <20190626062935.5549-1-ranjani.sridharan@linux.intel.com>
 <s5h7e98u9q5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C37C3F8070C
 for <alsa-devel@alsa-project.org>; Wed, 26 Jun 2019 09:07:11 +0200 (CEST)
In-Reply-To: <s5h7e98u9q5.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: libin.yang@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2019-06-26 at 08:44 +0200, Takashi Iwai wrote:
> On Wed, 26 Jun 2019 08:29:33 +0200,
> Ranjani Sridharan wrote:
> > 
> > A recent commit "ALSA: hdac: fix memory release for SST and SOF
> > drivers"
> > removed the kfree call for the hdac device in
> > snd_hdac_ext_bus_device_exit(). This requires that the SOF driver
> > also make the hdac_device and hdac_hda_priv device-managed so
> > that they can be freed when the SOF module in unloaded. The first
> > patch takes care of this change.
> > 
> > Additionally, because of the above change, the hda_codec is
> > device-managed and freeing it in snd_hda_codec_dev_release() leads
> > to kernel panic with module unload/reload stress tests. The second
> > patch includes the change to avoid freeing hda_codec for ASoC
> > driver.
> 
> In such a case, both patch need to be put into a single patch.
> Otherwise it leads to a bisection failure.
Thanks, Takashi. Just sent a v2 combining both the changes.

Thanks,
Ranjani
> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > More details for the module unload/reload test failures can be
> > found
> > here: https://github.com/thesofproject/linux/issues/966
> > 
> > Ranjani Sridharan (2):
> >   ASoC: SOF: Intel: hda: Make hdac_device device-managed
> >   ASoC: hda: don't free hda_codec for HDA_DEV_ASOC type
> > 
> >  sound/pci/hda/hda_codec.c       | 8 +++++++-
> >  sound/soc/sof/intel/hda-codec.c | 6 ++----
> >  2 files changed, 9 insertions(+), 5 deletions(-)
> > 
> > -- 
> > 2.17.1
> > 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
