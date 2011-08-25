From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: ALSA: hda: hdmi: Hint matching between input
 devices and pcm devices
Date: Thu, 25 Aug 2011 09:13:56 +0200
Message-ID: <4E55F634.9070601@canonical.com>
References: <4E53C32E.9020801@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3823@HQMAIL01.nvidia.com>
	<4E5483CD.6070808@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A3C9E@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040904060507060402050704"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 64D21103837
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Aug 2011 09:13:58 +0200 (CEST)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B24A3C9E@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040904060507060402050704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 08/24/2011 11:21 PM, Stephen Warren wrote:
> David Henningsson wrote at Tuesday, August 23, 2011 10:54 PM:
>> On 2011-08-23 17:51, Stephen Warren wrote:
>>> David Henningsson wrote at Tuesday, August 23, 2011 9:12 AM:
>>>> Since modern HDMI cards often have more than one output pin and thus
>>>> input device, we need to know which one has actually been plugged in.
>>>>
>>>> This patch adds a name hint that indicates which PCM device is connected
>>>> to which pin.
>>>>
>>>> To do that, the jack creation has been deferred to build_controls, i e,
>>>> after the PCM devices have been created.
>>>>
>>>> Would be great to have Stephen look through this patch quickly before
>>>> it's committed.
>>
>> Thanks for the review!
>>
>>> Structurally, I think this looks OK. The only question I have is the
>>> string format:
>>>
>>> "HDMI/DP (pcm %d)", pcmdev
>>>
>>> * Is there a 1:1 mapping between the internal pcmdev numbers and what
>>> alsa-lib presents to clients?
>>
>> That's very much up to the configuration in alsa-lib, but I would say
>> that alsa-lib in general does that, and especially for HDA.
>>
>>> Thinking about ALSA device numbering, it's
>>> like "hw:1,3", so includes the card number too; should that be in the
>>> string?
>>
>> The matchup against the card can be done both in sysfs, and using the
>> card name, which is later prefixed to that string. The end result would
>> be something like "HDA NVidia HDMI/DP (pcm 3)"
>
> OK, so if the string that user-space sees already has the card name, that's
> probably enough in practice, although it still seems a little free-form.
>
> One issue with the above string: There's no delimiter that user-space can
> use to extract just the card name from the whole string. Perhaps add a
> ":" at the start so there's a delimiter?

Or a ","

> "HDA NVidia: HDMI/DP (pcm 3)"
> "HDA NVidia: pcm 3"
>
> ?
>
>> It's possible though, and somewhat simpler than matching against sysfs
>> to add the card number as well.
>>
>>> * Would it be better to make the string completely generic - i.e. not
>>> include "HDMI/DP", but rather something like "ALSA PCM %d", or even
>>> "ALSA PCM hw:%d,%d" so that the same format could be used for non-HDMI/
>>> DP PCMs in the future?
>>
>> That would probably be bad, as there would be no way to distinguish
>> between e g "Headphone" and "Headphone 2".
>
> Are those two different analog outputs from the same PCM device?

Yes.

> If so, I don't see a problem with having both those jack's input devices
> reporting the same PCM name; user-space will just see 2 matches and know
> that the PCM device is useful if either is plugged in.

The problem is not that they have the same name, the problem is with 
removing "HDMI/DP", or in the analog case "Headphones" and "Headphones 
2". This is used to determine which ALSA volume controls one should 
control when the user wants to change volume. (The PCM device is usually 
useful regardless, e g with internal speakers which don't have a jack.)

> If not, I'm afraid I don't have enough context to understand your comment.
>
>> This is a HDMI specific
>> problem in general, as all analog outputs and inputs are at ,0 and SPDIF
>> at ,1. (Although there might be exceptions, the "Independent HP" thing
>> of the VIA drivers come to mind.)
>
> Hmm. I don't see it as HDMI specific. If there's a random input device
> today that represents the analog output's jack detection, how does user-
> space know the input device is for analog (sub-device 0) at all? Isn't
> the exact same issue present for any kind of output; I don't how the
> ,0/,1/,3 numbering affects this. Sorry!

As for the actual numbering, this is hardcoded in 
hda_codec.c:get_empty_pcm_device().

The jack input devices solve two different problems for HDMI and analog:

For HDMI, my problem is that I don't know which PCM device to send the 
output to (because there are four). The jack input device, with the 
patch, fixes that problem.

For Analog output, my problem is that I don't know which volume controls 
are affecting the current output path. If the Headphone is plugged in, 
this might be "Master" and "Headphone" whereas if it is unplugged, it 
might be "Master" and "Speaker" instead.
In theory, analog outputs could show up at both devices 0,2,4 and 5, but 
in practice, all of them always [1] show up at PCM device 0.

>> Up to now, I believe the string in the name has been pretty arbitrarily.
>> E g, I have "Headphone" on one machine and "HP Out" on another. Should
>> we try to establish a format where various parameters can be added, it
>> might be good to try something like ",name=value". Should we add card as
>> well, the result would be e g: "HDA NVidia HDMI/DP,card=2,pcm=3"
>
> That sounds pretty sane to me.

Ok, I'm attaching a patch where the only difference is that the format 
has changed according to the ,name=value syntax.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

[1] Possibly with the "Independent HP" exception of the VIA drivers, and 
maybe some more exotic exception that I've forgotten.

--------------040904060507060402050704
Content-Type: text/x-patch;
 name="0001-ALSA-hda-hdmi-Hint-matching-between-input-devices-an.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-hdmi-Hint-matching-between-input-devices-an.pa";
 filename*1="tch"

>From ab5ef7898ca0a6e86401428a3ca77f05db9eb7c9 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 23 Aug 2011 16:56:03 +0200
Subject: [PATCH] ALSA: hda: hdmi: Hint matching between input devices and pcm devices

Since modern HDMI cards often have more than one output pin and thus
input device, we need to know which one has actually been plugged in.

This patch adds a name hint that indicates which PCM device is connected 
to which pin.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c |   31 ++++++++++++++++++++++++-------
 1 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 19cb72d..8c83ec4 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -967,19 +967,12 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 
 	per_pin->pin_nid = pin_nid;
 
-	err = snd_hda_input_jack_add(codec, pin_nid,
-				     SND_JACK_VIDEOOUT, NULL);
-	if (err < 0)
-		return err;
-
 	err = hdmi_read_pin_conn(codec, pin_idx);
 	if (err < 0)
 		return err;
 
 	spec->num_pins++;
 
-	hdmi_present_sense(codec, pin_nid, eld);
-
 	return 0;
 }
 
@@ -1162,6 +1155,25 @@ static int generic_hdmi_build_pcms(struct hda_codec *codec)
 	return 0;
 }
 
+static int generic_hdmi_build_jack(struct hda_codec *codec, int pin_idx)
+{
+	int err;
+	char hdmi_str[32];
+	struct hdmi_spec *spec = codec->spec;
+	struct hdmi_spec_per_pin *per_pin = &spec->pins[pin_idx];
+	int pcmdev = spec->pcm_rec[pin_idx].device;
+
+	snprintf(hdmi_str, sizeof(hdmi_str), "HDMI/DP,pcm=%d", pcmdev);
+
+	err = snd_hda_input_jack_add(codec, per_pin->pin_nid,
+			     SND_JACK_VIDEOOUT, pcmdev > 0 ? hdmi_str : NULL);
+	if (err < 0)
+		return err;
+
+	hdmi_present_sense(codec, per_pin->pin_nid, &per_pin->sink_eld);
+	return 0;
+}
+
 static int generic_hdmi_build_controls(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec = codec->spec;
@@ -1170,6 +1182,11 @@ static int generic_hdmi_build_controls(struct hda_codec *codec)
 
 	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
 		struct hdmi_spec_per_pin *per_pin = &spec->pins[pin_idx];
+
+		err = generic_hdmi_build_jack(codec, pin_idx);
+		if (err < 0)
+			return err;
+
 		err = snd_hda_create_spdif_out_ctls(codec,
 						    per_pin->pin_nid,
 						    per_pin->mux_nids[0]);
-- 
1.7.4.1


--------------040904060507060402050704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040904060507060402050704--
