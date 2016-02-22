From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 2/3] ALSA: hda - Move chmap support
 helpers/structures to core
Date: Mon, 22 Feb 2016 16:23:34 +0530
Message-ID: <20160222105330.GA8048@subhransu-desktop>
References: <1456128040-12141-1-git-send-email-subhransu.s.prusty@intel.com>
 <1456128040-12141-3-git-send-email-subhransu.s.prusty@intel.com>
 <s5hwppx2i5i.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EC9E2661CF
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 11:52:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hwppx2i5i.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 22, 2016 at 10:44:57AM +0100, Takashi Iwai wrote:
> On Mon, 22 Feb 2016 09:00:39 +0100,
> Subhransu S. Prusty wrote:
> > +void snd_hdmi_init_channel_allocations(void);
> > +int snd_hdmi_get_channel_allocation_order(int ca);
> > +int snd_hdmi_get_active_channels(int ca);
> > +struct cea_channel_speaker_allocation *snd_hdmi_get_ch_alloc_from_ca(int ca);
> > +void snd_hdmi_print_channel_allocation(int spk_alloc, char *buf, int buflen);
> > +int snd_hdmi_channel_allocation(struct hdac_device *codec,
> > +		   int spk_alloc, int channels);
> > +int snd_hdmi_to_spk_mask(unsigned char c);
> > +int snd_hdmi_spk_to_chmap(int spk);
> > +int snd_hdmi_manual_channel_allocation(int chs, unsigned char *map);
> > +void snd_hdmi_setup_channel_mapping(struct hdmi_chmap *chmap,
> > +		       hda_nid_t pin_nid, bool non_pcm, int ca,
> > +		       int channels, unsigned char *map,
> > +		       bool chmap_set);
> > +int snd_hdmi_pin_set_slot_channel(struct hdac_device *codec, hda_nid_t pin_nid,
> > +					     int asp_slot, int channel);
> > +int snd_hdmi_pin_get_slot_channel(struct hdac_device *codec, hda_nid_t pin_nid,
> > +					     int asp_slot);
> > +void snd_hdmi_set_channel_count(struct hdac_device *codec,
> > +			   hda_nid_t cvt_nid, int chs);
> > +int snd_hdmi_chmap_cea_alloc_validate_get_type(
> > +		struct cea_channel_speaker_allocation *cap,
> > +		int channels);
> > +void snd_hdmi_cea_alloc_to_tlv_chmap(
> > +		struct cea_channel_speaker_allocation *cap,
> > +		unsigned int *chmap, int channels);
> > +int snd_hdmi_add_chmap_ctls(struct snd_pcm *pcm, int pcm_idx,
> > +				struct hdmi_chmap *chmap);
> 
> Do we really need to export all these?  Can't be they somehow
> self-contained?

Yes, I think we can do this by using common chmap ops instance and driver
can override the specific handlers. Will check for other APIs as well.

> 
> 
> Takashi

-- 
