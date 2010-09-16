From: Stephen Warren <swarren@nvidia.com>
Subject: Re: Unifying sound/pci/hda/patch_*hdmi.c
Date: Thu, 16 Sep 2010 11:10:13 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF030062B9FC@HQMAIL01.nvidia.com>
References: <s5hsk1b12qw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DD441037F1
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Sep 2010 20:10:23 +0200 (CEST)
In-Reply-To: <s5hsk1b12qw.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wu Fengguang <wfg@linux.intel.com>, Wei Ni <wni@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> the below is a patch for unifying three patch_*hdmi.c into a single
> file.  I'd like to push this to 2.6.37, so please review, especially
> whether it can break Nvidia hardware (since I have no h/w available).

First off, in general, I think working towards unifying all the HDMI
code is a great goal.

However, this patch worries me a bit because it significantly changes
the way some parts of the code work at the same time as performing the
refactoring...

In particular, after a brief skim, I see the following issues:

+static int patch_nvhdmi_8ch_89(struct hda_codec *codec)
+{
+	struct hdmi_spec *spec;
+	int err = patch_generic_hdmi(codec);
+
+	if (err < 0)
+		return err;
+	spec = codec->spec;
+	spec->old_pin_detect = 1;
+	spec->pcm_playback = &nvhdmi_pcm_playback_8ch_7x;

That last line is definitely wrong as far as I can tell. Just delete
it?

+	return 0;
+}

+static int patch_nvhdmi_8ch_7x(struct hda_codec *codec)
+{
+	struct hdmi_spec *spec;
+	int err = patch_generic_hdmi(codec);

The old nvhdmi_8ch_7x code was custom like nvhdmi_2ch. Unfortunately, I'm
not familiar with the old HW nor why it used custom code instead of the
generic parser. This seems like a risky change without testing.

One behavioral change I see is that patch_generic_hdmi will call
snd_hda_eld_proc_new, which wasn't previously called for this codec type.
Yet, nvhdmi_patch_ops_8ch_7x doesn't point unsol_event at hdmi_unsol_event,
so the ELD stuff won't work. I don't know if the unsolicited event logic in
the HW works on this chip or not, given the Linux driver hasn't used it
before. I suppose it has to work, but who knows...

Related,

+static struct hda_codec_ops nvhdmi_patch_ops_2ch = {
+	.build_controls = generic_hdmi_build_controls,
+	.build_pcms = generic_hdmi_build_pcms,
+	.init = nvhdmi_7x_init,
+	.free = generic_hdmi_free,
+};

Generic_hdmi_free calls snd_hda_eld_proc_free. Since nvhdmi_7x_init
doesn't call generic_hdmi_init, will that attempt to free ELD structures
that aren't allocated?

Once the above issues are thought through, I can try to find time to test
this on HW. Unfortunately, I definitely don't have any of the "2ch" HW
available to test at all. I do have a small subset of the "8ch_7x" and
"8ch_89" HW (although my only HDMI sink at work only supports 2-channel
audio). Also, my allotted time to work on the audio driver is very small
right now, plus I'll be away from the office next week and hence won't
have HW access to test anything anyway. Sorry I suck at being a tester!

> In future, we can reduce ATI- and Nvidia-specific codes gradually after
> confirming the generic parser works.
> 
> The patch is found in sound-unstable git tree, too.  The corresponding
> alsa-driver-unstable tarball can be used for external builds.
> 
> 
> thanks,
> 
> Takashi

-- 
nvpublic
