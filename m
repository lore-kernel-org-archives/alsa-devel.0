From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/6] HD-audio modalias support patchset
Date: Tue, 20 Oct 2015 11:46:40 +0530
Message-ID: <20151020061640.GA27370@localhost>
References: <1445012458-3337-1-git-send-email-tiwai@suse.de>
 <20151018151154.GQ27370@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E630E265FAE
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 08:13:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20151018151154.GQ27370@localhost>
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
Cc: Jeeja Kp <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, Subhransu S Prusty <subhransu.s.prusty@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 18, 2015 at 08:41:54PM +0530, Vinod Koul wrote:
> On Fri, Oct 16, 2015 at 06:20:52PM +0200, Takashi Iwai wrote:
> > Hi,
> > 
> > this is a patchset to add the support of automatic modalias creation
> > for HD-audio codec drivers like other standard drivers.  Currently,
> > the HDA codec driver has put module alias manually due to ugly
> > historical reasons.  This patch finally moves to the saner way.
> > 
> > Also it adds the udev modalias support so that it can be autoloaded in
> > udev.
> > 
> > The patchset was initiated by Intel people for SKL ASoC drivers.  Now
> > I brushed up and made it working for legacy drivers.
> > 
> > The current patchset is found in topic/hda-modalias branch of sound
> > git tree, too.
> 
> Thanks for posting this,
> 
> This series looks great to me. Me and Subhransu will test it out in next day
> or so and will get back with results on ASoC side :)

Hi Takashi,

For the whole series

Reviewed-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Subhransu S Prusty <subhransu.s.prusty@intel.com>

Also please apply below patch which adds HDA_CODEC_EXT_ENTRY. We have tested
HDMI patches with this

-----------------><8----------------><8----------------

>From 79f4fb6600810103737939c186f928c74ed058fe Mon Sep 17 00:00:00 2001
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Date: Mon, 19 Oct 2015 16:58:46 +0530
Subject: [PATCH] ALSA: hdac: Add macro for hda ext devices entry

With the new modalias infrastructure support added for hda, create a macro
for ext devices similar to legacy to add the device entry.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 719edff2a77b..425af0674557 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -40,6 +40,13 @@ void snd_hdac_ext_bus_device_remove(struct hdac_ext_bus *ebus);
 #define hbus_to_ebus(_bus) \
 	container_of(_bus, struct hdac_ext_bus, bus)
 
+#define HDA_CODEC_REV_EXT_ENTRY(_vid, _rev, _name, drv_data) \
+	{ .vendor_id = (_vid), .rev_id = (_rev), .name = (_name), \
+	  .api_version = HDA_DEV_ASOC, \
+	  .driver_data = (unsigned long)(drv_data) }
+#define HDA_CODEC_EXT_ENTRY(_vid, _revid, _name, _drv_data) \
+	HDA_CODEC_REV_EXT_ENTRY(_vid, _revid, _name, _drv_data)
+
 int snd_hdac_ext_bus_parse_capabilities(struct hdac_ext_bus *sbus);
 void snd_hdac_ext_bus_ppcap_enable(struct hdac_ext_bus *chip, bool enable);
 void snd_hdac_ext_bus_ppcap_int_enable(struct hdac_ext_bus *chip, bool enable);


-- 
~Vinod
