From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH v5] drm/i915: pass ELD to HDMI/DP audio
	driver
Date: Mon, 5 Sep 2011 09:14:00 +0800
Message-ID: <20110905011400.GB24561@localhost>
References: <20110902081428.GA19621@localhost>
	<20110903211510.GA11600@localhost>
	<aefc95$1b1bat@orsmga001.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D1101037EE
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Sep 2011 03:14:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <aefc95$1b1bat@orsmga001.jf.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Keith Packard <keithp@keithp.com>, "Wang,
	Zhenyu Z" <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>, Jeremy Bush <contractfrombelow@gmail.com>, Christopher White <c.white@pulseforce.com>, "Fu,
	Michael" <michael.fu@intel.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 04, 2011 at 08:08:37PM +0800, Chris Wilson wrote:
> On Sun, 4 Sep 2011 05:15:10 +0800, Wu Fengguang <fengguang.wu@intel.com> wrote:
> > Changes from v4: remove a debug call to dump_stack().
> > Thanks to Bossart for catching this!
> > ---
> > 
> > Add ELD support for Intel Eaglelake, IbexPeak/Ironlake,
> > SandyBridge/CougarPoint and IvyBridge/PantherPoint chips.
> > 
> > ELD (EDID-Like Data) describes to the HDMI/DP audio driver the audio
> > capabilities of the plugged monitor. It's built and passed to audio
> > driver in 2 steps:
> > 
> > (1) at get_modes time, parse EDID and save ELD to drm_connector.eld[]
> > 
> > (2) at mode_set time, write drm_connector.eld[] to the Transcoder's hw
> >     ELD buffer and set the ELD_valid bit to inform HDMI/DP audio driver
> > 
> > ELD selection policy: it's possible for one encoder to be associated
> > with multiple connectors (ie. monitors), in which case the first found
> > ELD will be used. This policy may not be suitable for all users, but
> > let's start it simple first.
> > 
> > The impact of ELD selection policy: assume there are two monitors, one
> > supports stereo playback and the other has 8-channel output; cloned
> > display mode is used, so that the two monitors are associated with the
> > same internal encoder. If only the stereo playback capability is reported,
> > the user won't be able to start 8-channel playback; if the 8-channel ELD
> > is reported, then user space applications may send 8-channel samples
> > down, however the user may actually be listening to the 2-channel
> > monitor and not connecting speakers to the 8-channel monitor. Overall,
> > it's more safe to report maximum profiles to the user space, so that
> > the user can at least be able to do 8-channel playback if he want to.
> > 
> > This patch is tested OK on G45/HDMI, IbexPeak/HDMI and IvyBridge/HDMI+DP.
> > 
> > Minor imperfection: the GEN6_AUD_CNTL_ST/DIP_Port_Select field always
> > reads 0 (reserved). Without knowing the port number, I worked it around
> > by setting the ELD_valid bit for ALL the three ports. It's tested to not
> > be a problem, because the audio driver will find invalid ELD data and
> > hence rightfully abort, even when it sees the ELD_valid indicator.
> > 
> 
> > --- linux-next.orig/drivers/gpu/drm/i915/intel_display.c	2011-09-02 15:59:31.000000000 +0800
> > +++ linux-next/drivers/gpu/drm/i915/intel_display.c	2011-09-04 05:11:44.000000000 +0800
> > +static void ironlake_write_eld(struct drm_connector *connector,
> > +				     struct drm_crtc *crtc)
> > +{
> > +	struct drm_i915_private *dev_priv = connector->dev->dev_private;
> > +	uint8_t *eld = connector->eld;
> > +	uint32_t eldv;
> > +	uint32_t i;
> > +	int len;
> > +	int hdmiw_hdmiedid;
> > +	int aud_cntl_st;
> > +	int aud_cntrl_st2;
> > +
> > +	if (IS_IVYBRIDGE(connector->dev)) {
> > +		hdmiw_hdmiedid = GEN7_HDMIW_HDMIEDID_A;
> > +		aud_cntl_st = GEN7_AUD_CNTRL_ST_A;
> > +		aud_cntrl_st2 = GEN7_AUD_CNTRL_ST2;
> > +	} else {
> > +		hdmiw_hdmiedid = GEN6_HDMIW_HDMIEDID_A;
> > +		aud_cntl_st = GEN6_AUD_CNTL_ST_A;
> > +		aud_cntrl_st2 = GEN6_AUD_CNTL_ST2;
> > +	}
> 
> This register naming is inconsistent with its intent. If these registers
> were indeed introduced on Ironlake as you seem to imply by using them
> with Ironlake, you should label them as GEN5 and not GEN6.

Yeah, I admit that I'm a bit confused in choosing the exact names.
I'll fix that.

> This patch should be split between adding the core drm functionality to
> build the ELD and the introduction of i915 support.

OK. I didn't do this because I was not sure if it's OK to just add the
drm_*() functions without any code to call them..

Thanks,
Fengguang
