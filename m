From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [alsa-devel] [PATCH v2] drm/i915: HDMI - Clear
 Audio Enable bit for	Hot Plug unconditionally
Date: Mon, 17 Sep 2012 09:58:55 +0200
Message-ID: <20120917075855.GB5522@phenom.ffwll.local>
References: <1347506340-2683-1-git-send-email-xingchao.wang@intel.com>
	<s5hipbie7px.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <s5hipbie7px.wl%tiwai@suse.de>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org, michael.fu@intel.com, fengguang.wu@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 13, 2012 at 08:51:22AM +0200, Takashi Iwai wrote:
> At Thu, 13 Sep 2012 11:19:00 +0800,
> Wang Xingchao wrote:
> > 
> > Clear Audio Enable bit to trigger unsolicated event to notify Audio
> > Driver part the HDMI hot plug change. The patch fixed the bug when
> > remove HDMI cable the bit was not cleared correctly.
> > 
> > In intel_enable_hdmi(), if intel_hdmi->has_audio been true, the "Audio enable bit" will
> > be set to trigger unsolicated event to notify Alsa driver the change.
> > 
> > intel_hdmi->has_audio will be reset to false from intel_hdmi_detect() after
> > remove the hdmi cable, here's debug log:
> > 
> > [  187.494153] [drm:output_poll_execute], [CONNECTOR:17:HDMI-A-1] status updated from 1 to 2
> > [  187.525349] [drm:intel_hdmi_detect], HDMI: has_audio = 0
> > 
> > so when comes back to intel_disable_hdmi(), the "Audio enable bit" will not be cleared. And this
> > cause the eld infomation and pin presence doesnot update accordingly in alsa driver side.
> > 
> > This patch will also trigger unsolicated event to alsa driver to notify the hot plug event:
> > 
> > [  187.853159] ALSA sound/pci/hda/patch_hdmi.c:772 HDMI hot plug event: Codec=3 Pin=5 Presence_Detect=0 ELD_Valid=1
> > [  187.853268] ALSA sound/pci/hda/patch_hdmi.c:990 HDMI status: Codec=3 Pin=5 Presence_Detect=0 ELD_Valid=0
> > 
> > Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
> 
> We need the same fix for stable kernels, too, but unfortunately this
> can't be applied to 3.6 or earlier.
> 
> Greg prefers still having a Cc to stable even in such a case, and then
> send a separate patch applicable to the existing kernels.
> 	http://lwn.net/Articles/515528/
> So better to have a Cc to stable in the patch.

I've merged both this patch for -next and the previous patch for -fixes
(with cc: stable added for -fixes).  Linus/Dave will have some fun with
the conflict ;-)

Thanks, Daniel
> 
> 
> thanks,
> 
> Takashi
> 
> > ---
> >  drivers/gpu/drm/i915/intel_hdmi.c |    5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/intel_hdmi.c b/drivers/gpu/drm/i915/intel_hdmi.c
> > index 5d02aad..229897f 100644
> > --- a/drivers/gpu/drm/i915/intel_hdmi.c
> > +++ b/drivers/gpu/drm/i915/intel_hdmi.c
> > @@ -674,10 +674,7 @@ static void intel_disable_hdmi(struct intel_encoder *encoder)
> >  	struct drm_i915_private *dev_priv = dev->dev_private;
> >  	struct intel_hdmi *intel_hdmi = enc_to_intel_hdmi(&encoder->base);
> >  	u32 temp;
> > -	u32 enable_bits = SDVO_ENABLE;
> > -
> > -	if (intel_hdmi->has_audio)
> > -		enable_bits |= SDVO_AUDIO_ENABLE;
> > +	u32 enable_bits = SDVO_ENABLE | SDVO_AUDIO_ENABLE;
> >  
> >  	temp = I915_READ(intel_hdmi->sdvox_reg);
> >  
> > -- 
> > 1.7.9.5
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
