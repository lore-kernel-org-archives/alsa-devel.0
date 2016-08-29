From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 05/12] ALSA: hdac: Move 'to_hda_ext_device'
	helper to core
Date: Mon, 29 Aug 2016 18:36:23 +0530
Message-ID: <20160829130623.GC28002@subhransu-desktop>
References: <1472451806-10605-1-git-send-email-subhransu.s.prusty@intel.com>
 <1472451806-10605-6-git-send-email-subhransu.s.prusty@intel.com>
 <s5hoa4ct155.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id BE14026755E
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 19:06:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hoa4ct155.wl-tiwai@suse.de>
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

On Mon, Aug 29, 2016 at 10:44:38AM +0200, Takashi Iwai wrote:
> On Mon, 29 Aug 2016 08:23:19 +0200,
> Subhransu S. Prusty wrote:
> > 
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  sound/hda/ext/hdac_codec.h | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/sound/hda/ext/hdac_codec.h b/sound/hda/ext/hdac_codec.h
> > index 7f47a7e..9159139 100644
> > --- a/sound/hda/ext/hdac_codec.h
> > +++ b/sound/hda/ext/hdac_codec.h
> > @@ -46,6 +46,13 @@ struct hdac_codec_widget {
> >  	void *params;	/* Widget specific parameters */
> >  };
> >  
> > +static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
> > +{
> > +	struct hdac_device *hdac = dev_to_hdac_dev(dev);
> > +
> > +	return to_ehdac_device(hdac);
> > +}
> > +
> >  int snd_hdac_parse_widgets(struct hdac_device *hdac);
> >  int snd_hdac_codec_init(struct hdac_device *hdac);
> >  void snd_hdac_codec_cleanup(struct hdac_device *hdac);
> 
> "Move" is to move from point A to B, but you're only adding a new one
> here...

to_hda_ext_device was defined in hdac_hdmi.c. As ASoC hda codec framework
will use this, so moved this to core. The next patch removes this helper
from hdac_hdmi.c. As I didn't want intermix two different modules in the
same patch, so submitted as separate patches. May be I will rename the
commit message to "copy ... " instead of "move". What do you suggest?

Regards,
Subhransu
> 
> 
> Takashi

-- 
