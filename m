From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [PATCH] ALSA: HDA: Remove unconnected PCM devices
 for	Intel HDMI
Date: Tue, 23 Nov 2010 23:54:32 +0800
Message-ID: <20101123155432.GA32248@localhost>
References: <4CDD615A.7000807@canonical.com> <s5hy68kpl6s.wl%tiwai@suse.de>
	<4CEB8968.5090205@canonical.com> <20101123151536.GB26749@localhost>
	<4CEBE081.10705@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 2AD7B103A9D
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 16:54:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4CEBE081.10705@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 23, 2010 at 04:40:49PM +0100, David Henningsson wrote:
> On 2010-11-23 16:15, Wu Fengguang wrote:
> >>> From ca84aa8edbfb66e46266677249b141b5419d6e0a Mon Sep 17 00:00:00 2001
> >>From: David Henningsson<david.henningsson@canonical.com>
> >>Date: Tue, 23 Nov 2010 10:23:40 +0100
> >>Subject: [PATCH] ALSA: HDA: Remove unconnected PCM devices for Intel HDMI
> >>
> >>Some newer chips have more than one HDMI output, but usually not
> >
> >Please point out the model name here (where this patch actually makes
> >a difference)?
> 
> I'm attaching the codec-proc file for the relevant machine, which
> lists as "Intel Cougarpoint HDMI".

Yes it's different from old models:

  Pin Default 0x58560010: [N/A] Digital Out at Int HDMI
  Pin Default 0x58560020: [N/A] Digital Out at Int HDMI
  Pin Default 0x18560030: [Jack] Digital Out at Int HDMI

> >>all of them are exposed as physical jacks. Removing the unused
> >>PCM devices (as indicated by BIOS in the pin config default) will
> >>reduce user confusion as they currently have to choose between
> >>several HDMI devices, some of them not working anyway.
> >>
> >>Signed-off-by: David Henningsson<david.henningsson@canonical.com>
> >>---
> >>  sound/pci/hda/patch_hdmi.c |   41 ++++++++++++++++++++++++++++++++---------
> >>  1 files changed, 32 insertions(+), 9 deletions(-)
> >>
> >>diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> >>index d3e49aa..14a1087 100644
> >>--- a/sound/pci/hda/patch_hdmi.c
> >>+++ b/sound/pci/hda/patch_hdmi.c
> >>@@ -905,23 +905,28 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
> >>  	spec->pin[spec->num_pins] = pin_nid;
> >>  	spec->num_pins++;
> >>
> >>-	/*
> >>-	 * It is assumed that converter nodes come first in the node list and
> >>-	 * hence have been registered and usable now.
> >>-	 */
> >>  	return hdmi_read_pin_conn(codec, pin_nid);
> >>  }
> >>
> >>  static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t nid)
> >>  {
> >>+	int i, found_pin = 0;
> >>  	struct hdmi_spec *spec = codec->spec;
> >>
> >>-	if (spec->num_cvts>= MAX_HDMI_CVTS) {
> >>-		snd_printk(KERN_WARNING
> >>-			   "HDMI: no space for converter %d\n", nid);
> >>-		return -E2BIG;
> >
> >>+	for (i = 0; i<  spec->num_pins; i++)
> >>+		if (nid == spec->pin_cvt[i]) {
> >>+			found_pin = 1;
> >>+			break;
> >>+		}
> >>+
> >>+	if (!found_pin) {
> >
> >Can test this instead:
> >
> >         if (hda_node_index(spec->pin_cvt, nid)<  0) {
> 
> Yes, that would probably be simpler.
> 
> >>+		snd_printdd("HDMI: Skipping node %d (no connection)\n", nid);
> >>+		return -EINVAL;
> >>  	}
> >
> >The above return actually will hide the device for cvt 3:
> >
> >                +---- pin 4
> >               /
> >         cvt 2 ------ pin 5
> >               \
> >                +---- pin 6
> >
> >         cvt 3
> >
> >Which is the default connection for Intel ibexpeak/sandybridge codecs.
> >It might be a problem when the user uses dual displays (which may be
> >configured at runtime). I have no such a setup, so cannot assure
> >things will work or not work..
> 
> Hmm, is this really relevant? Looking at the current patch_hdmi.c, I
> can't see that it ever tries to change pin <-> cvt connections, but
> I might be missing something.

I just feel uncertain. Perhaps when there comes a need in future, we
can further do a patch to "restore" the hidden device at runtime?

> In fact, I have yet to see an HDMI codec where you can actually
> perform that change, perhaps you can post such a codec-proc file?

Here is the SandyBridge model. IbexPeak is almost the same.

Thanks,
Fengguang
---

Codec: Intel SandyBridge HDMI
Address: 3
Function Id: 0x1
Vendor Id: 0x80862805
Subsystem Id: 0x80860101
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=0, o=0, i=0, unsolicited=0, wake=0
Node 0x02 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Control: name="IEC958 Playback Con Mask", index=0, device=0
  Control: name="IEC958 Playback Pro Mask", index=0, device=0
  Control: name="IEC958 Playback Default", index=0, device=0
  Control: name="IEC958 Playback Switch", index=0, device=0
  Device: name="INTEL HDMI 0", type="HDMI", device=3
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Control: name="IEC958 Playback Con Mask", index=1, device=0
  Control: name="IEC958 Playback Pro Mask", index=1, device=0
  Control: name="IEC958 Playback Default", index=1, device=0
  Control: name="IEC958 Playback Switch", index=1, device=0
  Device: name="INTEL HDMI 1", type="HDMI", device=7
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x6611: 8-Channels Digital
  Control: name="IEC958 Playback Con Mask", index=2, device=0
  Control: name="IEC958 Playback Pro Mask", index=2, device=0
  Control: name="IEC958 Playback Default", index=2, device=0
  Control: name="IEC958 Playback Switch", index=2, device=0
  Converter: stream=0, channel=0
  Digital: Enabled
  Digital category: 0x0
  PCM:
    rates [0x7f0]: 32000 44100 48000 88200 96000 176400 192000
    bits [0x1e]: 16 20 24 32
    formats [0x5]: PCM AC3
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
Node 0x05 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=05, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x02* 0x03
Node 0x06 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=06, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x02* 0x03
Node 0x07 [Pin Complex] wcaps 0x40778d: 8-Channels Digital Amp-Out CP
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x09000094: OUT Detect HBR HDMI DP
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=07, enabled=1
  Power states:  D0 D3 EPSS
  Power: setting=D0, actual=D0
  Connection: 2
     0x02* 0x03
Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono
