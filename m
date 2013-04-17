From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Wed, 17 Apr 2013 07:51:47 +0200
Message-ID: <516E3873.5020507@canonical.com>
References: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
 <51629295.1000701@canonical.com> <s5h4nfh1fsh.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F83786D8@SHSMSX101.ccr.corp.intel.com>
 <5162AB7D.40103@canonical.com> <s5hzjx9z10c.wl%tiwai@suse.de>
 <5162B60C.6000509@canonical.com> <s5htxnhyzvu.wl%tiwai@suse.de>
 <5162C671.90405@canonical.com> <s5hhajhyvww.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F83789F5@SHSMSX101.ccr.corp.intel.com>
 <5163B90C.20107@canonical.com> <s5hhajg175u.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F837A47F@SHSMSX101.ccr.corp.intel.com>
 <5163DC21.9020702@canonical.com> <s5hmwt8xdf2.wl%tiwai@suse.de>
 <5164F8CF.6040905@canonical.com> <s5h7gkb0wfa.wl%tiwai@suse.de>
 <5165006F.5070207@canonical.com> <s5hzjx6zxld.wl%tiwai@suse.de>
 <5165412C.7050306@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F83826C6@SHSMSX101.ccr.corp.intel.com>
 <516BA618.5050104@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F8382D3B@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050302080305030502020606"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id EB39E26159D
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 07:51:50 +0200 (CEST)
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F8382D3B@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050302080305030502020606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 04/15/2013 09:48 AM, Lin, Mengdong wrote:
>> -----Original Message-----
>> From: David Henningsson [mailto:david.henningsson@canonical.com]
>> Sent: Monday, April 15, 2013 3:03 PM
>> To: Lin, Mengdong
>> Cc: Takashi Iwai; alsa-devel@alsa-project.org; Girdwood, Liam R
>> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - delay resume haswell hdmi codec
>> in system resume
>>
>> On 04/14/2013 03:48 PM, Lin, Mengdong wrote:
>>> Hi David and Takashi,
>>>
>>> I'm sorry for the late response. I was assigned other tasks this week
>>>
>>> We don't have a better solution for this issue now, still trying.
>>> The delay_resume() ops for a codec can help not delaying the unsol event. So
>> our patch can solve the problem after system suspend/resume if the cable is
>> connected.
>>> But I'm afraid that if the HDMI/DP cable removed during system suspend
>>> and connected again sometime after system is resumed, and if the codec
>> access happens before the cable is connected, waiting for unsol event can be
>> time out and codec cannot be properly resumed.
>>> And if runtime power saving is also disabled, the audio driver has no chance to
>> resume the codec again. I cannot verify such hot-plug case during
>> system/suspend now because my Haswell machines cannot reach a stable S3
>> and then resume.
>>> But we do observed a similar bug: if cable is connected after boot, the pin is in
>> D3 with right channel muted, as the codec is initialized before unsol event
>> comes.
>>> Audio driver cannot find a suitable time out to wait for the usnsol event as we
>> don't know when the cable will be connected.
>>
>> Takashi's latest suggestion was to enable unsol events, and nothing else,
>> directly on S3 resume. See suggested patch below.
>>
>> Will that not help here? Then we would at least get some unsol events on
>> hotplug I assume?
>
> I think Takashi's patch can help when cable is connected during suspend/resume cycles.
> This patch enables unsol event, so make sure unsol event won't be delayed.
>
> So shall I improve the patch as Takashi suggested, to solve current suspend/resume issue?

If you do, in what scenarios will this not be enough? I e, what will 
still require more advanced synchronisation between gfx and audio driver 
(as outlined below)?

>
>
>>> We'll try if we can fix this dependency issue in Gfx driver side, and by sync Gfx
>> and audio driver processing.
>>>
>>> And we cannot implement pm domain atm. Last Thursday, we have a meeting
>> with Gfx team, for Gfx power well support and audio dependency on Gfx.
>>> Linux PM maintainer Rafael also attended the meeting. He suggested us not
>> use pm domain now because it cannot fully support PCI devices (PM domains
>> ops will override PCI bus ops). We will use and extend the existing private gfx
>> driver API to control the powerwell and sequence the
>> initialization/suspend/resume events between gfx and audio for internal
>> releases. Once this is working well with the private API, we will then look at
>> either implementing this functionality as PM domain or PM runtime depending
>> on the best fit and upstream.
>>>
>>> I'm working on HD-A RTD3 for legacy audio in one or two weeks. After that,
>> I'll continue to work on this issue.
>>
>> The dependency on the Gfx driver, is it both codec-wide and per pin? It seems to
>> be at least per pin, which means that whenever we plug something in, we need
>> to redo our initialization of that pin after the Gfx driver has finished, is that
>> correct?
>
> We're still investigating the Gfx driver sequence.
> In fact, not every hot plug will cause trouble. If the system is booted with cable connected, later hot-plug does not cause error, including switch between DP and HDMI cable.
> The dependency issue only happens on boot and resume.
> Since the hot-plug will also make Gfx reconfig the display pipeline, so we want to compare the difference and locate the accurate dependency.

It looks like this will take some time to implement, and the 3.10 merge 
window will soon open. It also sounds like the complexity makes it 
possible that a full fix can not be applied later during 3.10 rc cycle.

Takashi, may I ask you to apply the attached workaround in the mean 
time? I've confirmed it to resolve the problem on at least two different 
machines.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic

--------------050302080305030502020606
Content-Type: text/x-patch;
 name="0001-ALSA-hda-fixup-D3-pin-and-right-channel-mute-on-Hasw.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-hda-fixup-D3-pin-and-right-channel-mute-on-Hasw.pa";
 filename*1="tch"

>From 37b4fbb88dc03160fd71d1ec11ba14e83e6a79dc Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 10 Apr 2013 12:26:07 +0200
Subject: [PATCH] ALSA: hda - fixup D3 pin and right channel mute on Haswell
 HDMI audio

When graphics initializes the HDMI chip, sometimes this leads to
pins going into D3 and right channel being muted. If the audio driver
finishes initialization before the graphic driver does, this situation
becomes permanent.

This is a workaround that checks for this situation and corrects it on
playback prepare. It has been verified working on at least one machine.

BugLink: https://bugs.launchpad.net/bugs/1167270
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index ede8215..32930e6 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1018,6 +1018,41 @@ static void hdmi_unsol_event(struct hda_codec *codec, unsigned int res)
 		hdmi_non_intrinsic_event(codec, res);
 }
 
+static void haswell_verify_pin_D0(struct hda_codec *codec, hda_nid_t nid)
+{
+	int pwr, lamp, ramp;
+
+	pwr = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_POWER_STATE, 0);
+	pwr = (pwr & AC_PWRST_ACTUAL) >> AC_PWRST_ACTUAL_SHIFT;
+	if (pwr != AC_PWRST_D0) {
+		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_POWER_STATE,
+				    AC_PWRST_D0);
+		msleep(40);
+		pwr = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_POWER_STATE, 0);
+		pwr = (pwr & AC_PWRST_ACTUAL) >> AC_PWRST_ACTUAL_SHIFT;
+		snd_printd("Haswell HDMI audio: Power for pin 0x%x is now D%d\n", nid, pwr);
+	}
+
+	lamp = snd_hda_codec_read(codec, nid, 0,
+				  AC_VERB_GET_AMP_GAIN_MUTE,
+				  AC_AMP_GET_LEFT | AC_AMP_GET_OUTPUT);
+	ramp = snd_hda_codec_read(codec, nid, 0,
+				  AC_VERB_GET_AMP_GAIN_MUTE,
+				  AC_AMP_GET_RIGHT | AC_AMP_GET_OUTPUT);
+	if (lamp != ramp) {
+		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
+				    AC_AMP_SET_RIGHT | AC_AMP_SET_OUTPUT | lamp);
+
+		lamp = snd_hda_codec_read(codec, nid, 0,
+				  AC_VERB_GET_AMP_GAIN_MUTE,
+				  AC_AMP_GET_LEFT | AC_AMP_GET_OUTPUT);
+		ramp = snd_hda_codec_read(codec, nid, 0,
+				  AC_VERB_GET_AMP_GAIN_MUTE,
+				  AC_AMP_GET_RIGHT | AC_AMP_GET_OUTPUT);
+		snd_printd("Haswell HDMI audio: Mute after set on pin 0x%x: [0x%x 0x%x]\n", nid, lamp, ramp);
+	}
+}
+
 /*
  * Callbacks
  */
@@ -1032,6 +1067,9 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 	int pinctl;
 	int new_pinctl = 0;
 
+	if (codec->vendor_id == 0x80862807)
+		haswell_verify_pin_D0(codec, pin_nid);
+
 	if (snd_hda_query_pin_caps(codec, pin_nid) & AC_PINCAP_HBR) {
 		pinctl = snd_hda_codec_read(codec, pin_nid, 0,
 					    AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-- 
1.7.9.5


--------------050302080305030502020606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050302080305030502020606--
