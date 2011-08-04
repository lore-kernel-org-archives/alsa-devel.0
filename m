From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH v3] pass ELD to HDMI/DP audio driver
Date: Thu, 4 Aug 2011 17:40:24 +0800
Message-ID: <20110804094024.GB21137@localhost>
References: <yunk4atlwnr.fsf@aiko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 8440B1037F5
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 11:40:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <yunk4atlwnr.fsf@aiko.keithp.com>
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

> On Mon, 1 Aug 2011 21:51:40 +0800, Wu Fengguang <fengguang.wu@intel.com> wrote:
> 
> > 1) intel_write_eld() is not called at all
> >    It seems we need to call intel_write_eld() in other places besides
> >    inside ->mode_set(). Is ->detect() the right place to do so? In
> >    other words, are there established connector<=>encoder mapping
> >    that can be queried inside intel_hdmi_detect()/intel_dp_detect()?
> 
> The connector has a link to the encoder (struct intel_connector contains a
> pointer to a struct intel_encoder).

Right. I actually have this chunk. dmesg shows that in intel_hdmi_detect(),  
the drm_encoder object is there, however encoder->crtc is NULL at the time.

@@ -269,6 +271,12 @@ intel_hdmi_detect(struct drm_connector *
                        status = connector_status_connected;
                        intel_hdmi->has_hdmi_sink = drm_detect_hdmi_monitor(edid);
                        intel_hdmi->has_audio = drm_detect_monitor_audio(edid);
+                       drm_edid_to_eld(connector, edid);
+                       if (intel_hdmi->base.base.crtc)
+                               intel_write_eld(&intel_hdmi->base.base,
+                                               &intel_hdmi->base.base.crtc->mode);
+                       else
+                               printk("intel_hdmi_detect: cannot write eld: NULL crtc\n");
                }       
                connector->display_info.raw_edid = NULL;
                kfree(edid);                                                                                    

You may wonder why the mode parameter is needed in intel_write_eld().
This is because the ELD field aud_synch_delay (ie. A/V sync delay) may
have different values in progressive/interleaved display modes.


> > 2) intel_dp_detect() is called even though it's an HDMI monitor
> >    connected to an HDMI jack.. It may be a bug specific to the
> >    hardware I'm testing (attached its full dmesg).
> 
> We run all of the hotplug functions when any connector change is
> detected; easier than trying to track what happened from the bits
> visible from the interrupt.

Ah yes. I figured it out later.

> I note that this patch does not include the necessary hooks for
> Ivybridge; we'll need that included (and tested) for this to be
> considered for kernel 3.1. I'd be surprised if it couldn't use
> ironlake_write_eld just fine, so it should just be a matter of setting
> the write_eld field and testing it on actual hardware.

I tested Ivybridge yesterday and ironlake_write_eld seems to not work
properly for Ivybridge. Need to double check its spec.

Thanks,
Fengguang
