From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH v3] pass ELD to HDMI/DP audio driver
Date: Fri, 5 Aug 2011 20:49:58 +0800
Message-ID: <20110805124958.GA9531@localhost>
References: <yunk4atlwnr.fsf@aiko.keithp.com>
	<20110804094024.GB21137@localhost>
	<yunsjph835u.fsf@aiko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id A98C410380E
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Aug 2011 14:50:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <yunsjph835u.fsf@aiko.keithp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Keith Packard <keithp@keithp.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
	Zhenyu Z" <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop..." <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Zhao, Yakui" <yakui.zhao@intel.com>, Ben Skeggs <bskeggs@redhat.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Christopher White <c.white@pulseforce.com>, Jeremy Bush <contractfrombelow@gmail.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 05, 2011 at 02:03:41AM +0800, Keith Packard wrote:
> On Thu, 4 Aug 2011 17:40:24 +0800, Wu Fengguang <fengguang.wu@intel.com> wrote:
> 
> > Right. I actually have this chunk. dmesg shows that in intel_hdmi_detect(),  
> > the drm_encoder object is there, however encoder->crtc is NULL at the
> > time.
> 
> Correct. encoder->crtc is set only when the output is active.

Ah OK.

> > You may wonder why the mode parameter is needed in intel_write_eld().
> > This is because the ELD field aud_synch_delay (ie. A/V sync delay) may
> > have different values in progressive/interleaved display modes.
> 
> Ok, so you can't write ELD data until the display is active, which
> happens at mode_set time.
> 
> Do you need to provide ELD when the display is inactive? Is this only to
> enable audio output when the display is not on? In that case, we will

Good questions!  In general the audio functionalities should not
depend on the display activeness. There are even audio-only HDMI
devices. So I'll need to make intel_write_eld() work even without
information about the current display mode.

> need to essentially turn enough of the output on to allow for audio
> data, picking a mode which provide sufficient bandwidth.

That would be a good feature. For one thing, I find it annoying that
the music playback fades out when the screen goes to power saving mode..

> > I tested Ivybridge yesterday and ironlake_write_eld seems to not work
> > properly for Ivybridge. Need to double check its spec.
> 
> That's unfortunate...

But fixable :)

Thanks,
Fengguang
