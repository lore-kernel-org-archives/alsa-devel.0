From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v2 2/9] ALSA: hda - add helper to get
 channels from cap bits
Date: Tue, 12 Apr 2016 19:08:07 +0530
Message-ID: <20160412133807.GC8655@subhransu-desktop>
References: <1460454977-30057-1-git-send-email-subhransu.s.prusty@intel.com>
 <1460454977-30057-3-git-send-email-subhransu.s.prusty@intel.com>
 <s5hfuur16jb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 497D2265189
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 15:39:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfuur16jb.wl-tiwai@suse.de>
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

On Tue, Apr 12, 2016 at 12:10:48PM +0200, Takashi Iwai wrote:
> On Tue, 12 Apr 2016 11:56:10 +0200,
> Subhransu S. Prusty wrote:
> > 
> > This helper is copied from legacy hda driver.
> > 
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  sound/hda/local.h | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/sound/hda/local.h b/sound/hda/local.h
> > index d692f41..57f07d7 100644
> > --- a/sound/hda/local.h
> > +++ b/sound/hda/local.h
> > @@ -16,6 +16,16 @@ static inline int get_wcaps_type(unsigned int wcaps)
> >  	return (wcaps & AC_WCAP_TYPE) >> AC_WCAP_TYPE_SHIFT;
> >  }
> >  
> > +static inline unsigned int get_wcaps_channels(u32 wcaps)
> > +{
> > +	unsigned int chans;
> > +
> > +	chans = (wcaps & AC_WCAP_CHAN_CNT_EXT) >> 13;
> > +	chans = ((chans << 1) | 1) + 1;
> 
> Let's make it simple.  This is equivalent with
> 	chans = (chans + 1) * 2;

Sure.

Regards,
Subhransu
> 
> 
> Takashi

-- 
