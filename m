From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 04/11] ALSA: hda: corrected
 snd_hdac_stream_init() declaration
Date: Tue, 14 Apr 2015 10:06:03 +0530
Message-ID: <20150414043603.GE2963@intel.com>
References: <1428842178-7105-1-git-send-email-subhransu.s.prusty@intel.com>
 <1428842178-7105-5-git-send-email-subhransu.s.prusty@intel.com>
 <s5hd238p7ns.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E4A17260478
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 06:40:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd238p7ns.wl-tiwai@suse.de>
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

On Mon, Apr 13, 2015 at 01:52:23PM +0200, Takashi Iwai wrote:
> At Sun, 12 Apr 2015 18:06:11 +0530,
> Subhransu S. Prusty wrote:
> > 
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > Corrected snd_hdac_stream_init() declaration in header file.
> > 
> > Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  include/sound/hdaudio.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
> > index 247c4a7..bffb2a9 100644
> > --- a/include/sound/hdaudio.h
> > +++ b/include/sound/hdaudio.h
> > @@ -340,7 +340,7 @@ struct hdac_stream {
> >  	struct mutex dsp_mutex;
> >  };
> >  
> > -void snd_hdac_bus_stream_init(struct hdac_bus *bus, struct hdac_stream *azx_dev,
> > +void snd_hdac_stream_init(struct hdac_bus *bus, struct hdac_stream *azx_dev,
> >  			      int idx, int direction, int tag);
> >  struct hdac_stream *snd_hdac_stream_assign(struct hdac_bus *bus,
> >  					   struct snd_pcm_substream *substream);
> 
> I suppose you're referring to the code in topic/hda-dev2 branch of
> sound-unstable git tree?  Then I'll fold the fix into it.
Yes all the code is based on 7 patches you had posted plus the patch series
V3 I had sent (which is based on hda-dev2). Please do fold this up and push
updated barcnh for me so that I cna rebase these

-- 
~Vinod
