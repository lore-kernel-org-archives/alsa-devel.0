From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH 2/3] ASoC: SOF: Intel: hda: Enable jack
 detection in sof hda driver
Date: Wed, 26 Jun 2019 22:36:05 -0700
Message-ID: <c7d866c6289956df7152f57dbe0108001752bb8a.camel@linux.intel.com>
References: <20190626202229.16312-1-ranjani.sridharan@linux.intel.com>
 <20190626202229.16312-3-ranjani.sridharan@linux.intel.com>
 <388c2dce-a235-c592-b88e-0f6deca76220@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B58F4F806F0
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 07:36:08 +0200 (CEST)
In-Reply-To: <388c2dce-a235-c592-b88e-0f6deca76220@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@linux.intel.com, Rander Wang <rander.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2019-06-26 at 23:03 +0200, Cezary Rojewski wrote:
> On 2019-06-26 22:22, Ranjani Sridharan wrote:
> > From: Rander Wang <rander.wang@linux.intel.com>
> > 
> > In commit 7d4f606c50ff ("ALSA: hda - WAKEEN feature enabling for
> > runtime pm"), legacy HD-A driver sets hda controller in reset mode
> > after
> > entering runtime-suspend. And when resuming from suspend mode, it
> > checks
> > hda controller & codec status to detect headphone hotplug event.
> > Now
> > this patch does the same job in SOF runtime pm functions.
> > 
> > And we need to check all the non-hdmi codecs for some cases like
> > playback
> > with HDMI or capture with DMIC connected to dsp. In these cases,
> > only
> > controller is active and codecs are suspended, so codecs can't send
> > unsolicited event to controller. The jack polling operation will
> > activate
> > codecs and unsolicited event can work even codecs become suspended
> > later.
> > 
> > Tested on whiskylake with hda codecs.
> > 
> > Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
> > Signed-off-by: Pierre-Louis Bossart <
> > pierre-louis.bossart@linux.intel.com>
> > Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
> > >
> > ---
> >   sound/soc/sof/intel/hda-codec.c | 45
> > +++++++++++++++++++++++++++++++--
> >   sound/soc/sof/intel/hda-dsp.c   | 29 ++++++++++++++++-----
> >   sound/soc/sof/intel/hda.h       |  4 +++
> >   3 files changed, 70 insertions(+), 8 deletions(-)
> > 
> > diff --git a/sound/soc/sof/intel/hda-codec.c
> > b/sound/soc/sof/intel/hda-codec.c
> > index b8b37f082309..c711792534da 100644
> > --- a/sound/soc/sof/intel/hda-codec.c
> > +++ b/sound/soc/sof/intel/hda-codec.c
> > @@ -10,6 +10,7 @@
> >   
> >   #include <linux/module.h>
> >   #include <sound/hdaudio_ext.h>
> > +#include <sound/hda_register.h>
> >   #include <sound/hda_codec.h>
> >   #include <sound/hda_i915.h>
> >   #include <sound/sof.h>
> > @@ -37,16 +38,55 @@ static void hda_codec_load_module(struct
> > hda_codec *codec)
> >   static void hda_codec_load_module(struct hda_codec *codec) {}
> >   #endif
> >   
> > +/* check jack status after resuming from suspend mode */
> > +void hda_codec_jack_check(struct snd_sof_dev *sdev, int status)
> > +{
> > +	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
> > +	struct hda_bus *hbus = sof_to_hbus(sdev);
> > +	struct hdac_bus *bus = sof_to_bus(sdev);
> > +	struct hda_codec *codec;
> > +	int mask;
> > +
> > +	/*
> > +	 * there are two reasons for runtime resume
> > +	 * (1) waken up by interrupt triggered by WAKEEN feature
> > +	 * (2) waken up by pm get functions for some audio operations
> > +	 * For case (1), the bits in status mean which codec triggers
> > +	 * the interrupt and jacks will be checked on these codecs.
> > +	 * For case (2), we need to check all the non-hdmi codecs for
> > some
> > +	 * cases like playback with HDMI or capture with DMIC. In these
> > +	 * cases, only controller is active and codecs are suspended,
> > so
> > +	 * codecs can't send unsolicited event to controller. The jack
> > polling
> > +	 * operation will activate codecs and unsolicited event can
> > work
> > +	 * even codecs become suspended later.
> > +	 */
> 
> This block is huge. I'd suggest entering some whitespaces to make it 
> more readable.
> 
> On the second thought, I bet this stuff is not SOF specific and if
> so, 
> being more strict may prove more informative than being so explicit
> - 
> reference to HDA spec/ kernel HDA documentation etc.
> 
> > +	mask = status ? status : hda->hda_codec_mask;
> > +
> > +	list_for_each_codec(codec, hbus)
> > +		if (mask & BIT(codec->core.addr))
> > +			schedule_delayed_work(&codec->jackpoll_work,
> > +					      codec-
> > >jackpoll_interval);
> > +
> > +	/* disable controller Wake Up event*/
> > +	snd_hdac_chip_writew(bus, WAKEEN,
> > +			     snd_hdac_chip_readw(bus, WAKEEN) &
> > +			     ~hda->hda_codec_mask);
> 
> Any reason for not using snd_hdac_chip_updatew?
Thanks, Cezary for the feedback. We're working to optimize the jack
detection logic during runtime suspend. Let me get back with a v2 and
address your concerns.

Thanks,
Ranjani
