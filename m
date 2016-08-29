From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 02/12] ALSA: hda - Add macro to test pin
 widget's input capability
Date: Mon, 29 Aug 2016 18:31:37 +0530
Message-ID: <20160829130136.GB28002@subhransu-desktop>
References: <1472451806-10605-1-git-send-email-subhransu.s.prusty@intel.com>
 <1472451806-10605-3-git-send-email-subhransu.s.prusty@intel.com>
 <s5hpoost18s.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id B8C08266B44
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 18:33:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpoost18s.wl-tiwai@suse.de>
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

On Mon, Aug 29, 2016 at 10:42:27AM +0200, Takashi Iwai wrote:
> On Mon, 29 Aug 2016 08:23:16 +0200,
> Subhransu S. Prusty wrote:
> > 
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> 
> .... missing the reason why?

This macro will be used to identify pins input capability and create DAPM
widgets. Also based on input capability widget parsing is done for DAPM
graph creation.

Will add these details in the commit message.

> 
> 
> > ---
> >  sound/hda/local.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/sound/hda/local.h b/sound/hda/local.h
> > index 0d5bb15..a51f5f6 100644
> > --- a/sound/hda/local.h
> > +++ b/sound/hda/local.h
> > @@ -8,6 +8,16 @@
> >  #define get_wcaps(codec, nid) \
> >  	snd_hdac_read_parm(codec, nid, AC_PAR_AUDIO_WIDGET_CAP)
> >  
> > +#define get_pcaps(codec, nid) \
> > +	snd_hdac_read_parm(codec, nid, AC_PAR_PIN_CAP)
> > +
> > +static inline int is_input_pin(struct hdac_device *codec, hda_nid_t nid)
> 
> Better to make it bool.

Sure.

Regards,
Subhransu

> 
> 
> thanks,
> 
> Takashi

-- 
