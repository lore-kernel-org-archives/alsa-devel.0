From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 10/11] ASoC: hda - add Skylake HD audio driver
Date: Tue, 14 Apr 2015 10:14:58 +0530
Message-ID: <20150414044458.GJ2963@intel.com>
References: <1428842178-7105-1-git-send-email-subhransu.s.prusty@intel.com>
 <1428842178-7105-11-git-send-email-subhransu.s.prusty@intel.com>
 <s5ha8ycp7aw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A3D6261A73
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 06:49:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5ha8ycp7aw.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 13, 2015 at 02:00:07PM +0200, Takashi Iwai wrote:
> At Sun, 12 Apr 2015 18:06:17 +0530,
> Subhransu S. Prusty wrote:
> > 
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > Add ASoC Skylake HD audio controller driver
> > 
> > Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  include/sound/hdaudio.h |  11 +
> >  sound/soc/hda/hda_skl.c | 829 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  sound/soc/hda/hda_skl.h |  49 +++
> >  3 files changed, 889 insertions(+)
> >  create mode 100644 sound/soc/hda/hda_skl.c
> >  create mode 100644 sound/soc/hda/hda_skl.h
> > 
> > diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
> > index 2d62410..1ef0b79 100644
> > --- a/include/sound/hdaudio.h
> > +++ b/include/sound/hdaudio.h
> > @@ -197,6 +197,11 @@ struct hda_rb {
> >  	u32 res[HDA_MAX_CODECS];	/* last read value */
> >  };
> >  
> > +typedef unsigned int (*hdac_stream_get_pos_callback_t)(struct hdac_bus *,
> > +			struct hdac_stream *);
> > +typedef int (*hdac_stream_get_delay_callback_t)(struct hdac_bus *,
> > +		struct hdac_stream *, unsigned int pos);
> > +
> >  struct hdac_bus {
> >  	struct device *dev;
> >  	const struct hdac_bus_ops *ops;
> > @@ -233,6 +238,10 @@ struct hdac_bus {
> >  	struct snd_dma_buffer rb;
> >  	struct snd_dma_buffer posbuf;
> >  
> > +	/* position adjustment callbacks */
> > +	hdac_stream_get_pos_callback_t get_position[2];
> > +	hdac_stream_get_delay_callback_t get_delay[2];
> 
> So, do you still need the dynamic switch of get_position and get_delay
> functions on SKL?  These are basically for old platforms that have no
> position buffer support or unstable reads.
> 
> Otherwise you can use always LPIB and position buffers for position
> and delay calculations.  That's why I didn't put them at the first
> place.
Jeeja tested this last evening so we dont need this on SKL and will remove,
and you were right :)

> 
> > +
> >  	/* hdac_stream linked list */
> >  	struct list_head stream_list;
> >  
> > @@ -330,6 +339,8 @@ struct hdac_stream {
> >  
> >  	unsigned int opened:1;
> >  	unsigned int running:1;
> > +	unsigned int prepared:1;
> > +	unsigned int irq_pending:1;
> 
> The irq_pending is also another question.  This was a workaround, and
> whether it's still needed for the modern chips is not sure.
nope, will drop this patch

-- 
~Vinod
