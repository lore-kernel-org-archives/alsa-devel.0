From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v2 5/7] ALSA: hda - Use ops instead of
 directly accessing chmap helpers
Date: Thu, 3 Mar 2016 17:24:43 +0530
Message-ID: <20160303115439.GA17770@subhransu-desktop>
References: <1456920208-1172-1-git-send-email-subhransu.s.prusty@intel.com>
 <1456920208-1172-6-git-send-email-subhransu.s.prusty@intel.com>
 <s5hmvqgsw8x.wl-tiwai@suse.de> <20160303112923.GK11154@localhost>
 <s5hr3fr6bae.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D0885261537
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 12:54:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hr3fr6bae.wl-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 03, 2016 at 12:39:05PM +0100, Takashi Iwai wrote:
> On Thu, 03 Mar 2016 12:29:23 +0100,
> Vinod Koul wrote:
> > 
> > On Wed, Mar 02, 2016 at 05:03:10PM +0100, Takashi Iwai wrote:
> > > On Wed, 02 Mar 2016 13:03:26 +0100,
> > > Subhransu S. Prusty wrote:
> > > > 
> > > > Added more ops to the chmap object, so most of the helpers can be
> > > > accessed through ops instead instead of directly calling them.
> > > 
> > > Too many instead :)
> > > 
> > > > With this moving the chmap helpers to core will be easy.
> > > 
> > > Well, although I asked about reduction of exported stuff, I don't
> > > think it's worth to put everything in ops.  If any of them would be
> > > overridden, it's good to have as an ops.  If not, it's fine to have
> > > exported symbols.  These are just a few entries, not over 20.
> > 
> > I think the thought was that patch_hdmi and ASoC driver will use defaults
> > whereas the patch_nvidia etc will override with their own stuff..
> 
> Yes, but are these new ops overridden actually?

I think the new ops added with this patch can be removed. They can be kept
as exported APIs and not overriden.

basically these ones:
+	int (*get_active_channels)(int ca);
+	void (*setup_channel_mapping)(struct hdmi_chmap *chmap,
+			hda_nid_t pin_nid, bool non_pcm, int ca,
+			int channels, unsigned char *map,
+			bool chmap_set);
+	int (*channel_allocation)(struct hdac_device *hdac, int spk_alloc,
+				int channels, bool chmap_set,
+				bool non_pcm, unsigned char *map);
+	struct hdmi_cea_channel_speaker_allocation *(*get_cap_from_ca)(int
ca);
+	int (*alsa_chmap_to_spk_mask)(unsigned char c);
+	int (*spk_to_alsa_chmap)(int spk);

> 
> 
> Takashi

-- 
