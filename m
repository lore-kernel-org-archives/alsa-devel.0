From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] Timing issues between ALSA and i915
 drivers
Date: Thu, 17 Jan 2019 13:53:06 -0600
Message-ID: <d0fb9eb6-a32a-0757-22ba-012eb2aad44c@linux.intel.com>
References: <045cfacd-7a8a-af3c-0f82-325b12cf65da@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------B87A0C2700579B1F6A4FED1E"
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <045cfacd-7a8a-af3c-0f82-325b12cf65da@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, intel-gfx@lists.freedesktop.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Imre Deak <imre.deak@intel.com>, "Rojewski, Cezary" <cezary.rojewski@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------B87A0C2700579B1F6A4FED1E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


> I could use some feedback on HDMI audio issues exposed during the 4.21 
> merge window. By accident (misleading documentation) we ended up 
> enabling the Skylake driver instead of the HDaudio legacy, and broke 
> audio on a number of Skylake and ApolloLake devices where the 
> HDMI/iDISP codec was not detected (bit 2 not set in the codec_mask). 
> Linus' Dell XPS13 9350 was the first to be impacted of course...
>
> After debugging a bit, this issue can be resolved by either
>
> a) compiling both SOUND and DRM as built-ins (y instead of m)
>
> b) moving the calls snd_hdac_i915_init() to the probe function instead 
> of the worker queue (code at 
> https://github.com/plbossart/sound/commits/fix/skl-hdmi)
>
> Both solutions point to timing issues.
>
> During internal reviews I was alerted to the fact that the suggested 
> fix essentially reverts patch ab1b732d53c18 ('ASoC: Intel: Skylake: 
> Move i915 registration to worker thread') which was introduced to 
> solve DRM lockup issues.

I tried to narrow down the issue further and my current understanding is 
that the Skylake driver performs link reset operations without the 
display power turned on - which does not look like a very smart thing to 
do in hindsight.

In other words, it's not really when snd_hdac_i915_init() is called that 
matters as I assumed initially, but more when snd_hdac_display_power() 
is invoked. There are two cases where this happens, and for each of them 
turning the display power on results in HDMI detection. The attached 
diffs split the initialization from the power on, which provides a 
better understanding of the issue.

What would be really useful at this point is a confirmation that 
snd_hdac_i915_init() cannot be called in the initial probe but does need 
to be executed in a work queue. That would really impact the way the 
initialization sequence is reworked on the Skylake side as well as 
modify the way the SOF driver deals with i915 initialization.

Thanks

-Pierre


--------------B87A0C2700579B1F6A4FED1E
Content-Type: text/x-patch;
 name="hdmi-links.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hdmi-links.diff"

diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 60c94836bf5b..56556d06a17f 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -767,23 +767,6 @@ static const struct hdac_bus_ops bus_core_ops = {
 	.get_response = snd_hdac_bus_get_response,
 };
 
-static int skl_i915_init(struct hdac_bus *bus)
-{
-	int err;
-
-	/*
-	 * The HDMI codec is in GPU so we need to ensure that it is powered
-	 * up and ready for probe
-	 */
-	err = snd_hdac_i915_init(bus);
-	if (err < 0)
-		return err;
-
-	snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
-
-	return 0;
-}
-
 static void skl_probe_work(struct work_struct *work)
 {
 	struct skl *skl = container_of(work, struct skl, probe_work);
@@ -791,12 +774,6 @@ static void skl_probe_work(struct work_struct *work)
 	struct hdac_ext_link *hlink = NULL;
 	int err;
 
-	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
-		err = skl_i915_init(bus);
-		if (err < 0)
-			return;
-	}
-
 	err = skl_init_chip(bus, true);
 	if (err < 0) {
 		dev_err(bus->dev, "Init chip failed with err: %d\n", err);
@@ -899,6 +876,11 @@ static int skl_first_init(struct hdac_bus *bus)
 	unsigned short gcap;
 	int cp_streams, pb_streams, start_idx;
 
+	err = snd_hdac_i915_init(bus);
+	if (err < 0)
+		return err;
+
+
 	err = pci_request_regions(pci, "Skylake HD audio");
 	if (err < 0)
 		return err;
@@ -910,7 +892,10 @@ static int skl_first_init(struct hdac_bus *bus)
 		return -ENXIO;
 	}
 
-	snd_hdac_bus_reset_link(bus, true);
+	/* this bus_reset_link is unnecessary, and without the display
+	 *  power turned on prevents HDMI from being detected
+	 */
+	//snd_hdac_bus_reset_link(bus, true);
 
 	snd_hdac_bus_parse_capabilities(bus);
 
@@ -962,7 +947,14 @@ static int skl_first_init(struct hdac_bus *bus)
 	/* initialize chip */
 	skl_init_pci(skl);
 
-	return skl_init_chip(bus, true);
+	/* turning the display power here works */
+	snd_hdac_display_power(bus, HDA_CODEC_IDX_CONTROLLER, true);
+
+	err =  skl_init_chip(bus, true);
+
+	/* turning the display power here does not work, HDMI not detected */
+
+	return err;
 }
 
 static int skl_probe(struct pci_dev *pci,

--------------B87A0C2700579B1F6A4FED1E
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KSW50ZWwtZ2Z4
IG1haWxpbmcgbGlzdApJbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vaW50ZWwtZ2Z4Cg==

--------------B87A0C2700579B1F6A4FED1E--
