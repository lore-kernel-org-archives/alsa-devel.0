From: Tormen <my.nl.abos@gmail.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Thu, 11 Jul 2013 11:31:15 +0200
Message-ID: <51DE7B63.7060708@gmail.com>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
 <51D5FCFC.8010506@gmail.com> <s5hip0pwp49.wl%tiwai@suse.de>
 <51D6B56D.8050909@gmail.com> <s5h1u7dchqh.wl%tiwai@suse.de>
 <020e0ad5107eb4c2bb333468be58d7d3@www.happyassassin.net>
 <51D9F543.2070605@gmail.com>
 <c2cbc2323ce3a8e0df5f52de3ecb276c@www.happyassassin.net>
 <s5hvc4luem4.wl%tiwai@suse.de>
 <46b0590bfa4ffc836dde180f8ffe3c97@www.happyassassin.net>
 <s5hwqoycu0y.wl%tiwai@suse.de> <51DDD53A.8040502@gmail.com>
 <s5hbo69vf4z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020300010704000607090006"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 192B62657AF
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 11:31:19 +0200 (CEST)
Received: by mail-bk0-f47.google.com with SMTP id jg1so3198719bkc.6
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 02:31:18 -0700 (PDT)
In-Reply-To: <s5hbo69vf4z.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Adam Williamson <awilliam@redhat.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020300010704000607090006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 11/07/13 07:29, Takashi Iwai wrote:
> At Wed, 10 Jul 2013 23:42:18 +0200,
> Tormen wrote:
>> On 10/07/13 17:30, Takashi Iwai wrote:
>>> At Tue, 09 Jul 2013 11:53:47 -0700,
>>> Adam Williamson wrote:
>>>> On 2013-07-08 10:48, Takashi Iwai wrote:
>>>>
>>>>>> Ah, yes, I'd forgotten about that little wrinkle. I don't pretend to
>>>>>> be
>>>>>> following the exact details of the planned fix here, but just as a
>>>>>> high-level remark, this 'extra mic jack' seems very much like an
>>>>>> implementation detail for the noise cancellation which Linux does not
>>>>>> do
>>>>>> in any case (AFAIK). It wouldn't make sense to me to expose it as a
>>>>>> 'normal' mic jack, exactly. It's not like you can plug an actual
>>>>>> microphone into this 'mic jack' and use it. How will it be exposed
>>>>>> exactly after the patch, tiwai?
>>>>> Well, Tormen's description sounds like it being a mic for a headset,
>>>>> no?
>> I did mention though:
>>   >     (a) the Notebook came with Noise-cancelling headsets, but they
>> are small in-ear plugs so there is no place for noise-cancelling logic
>> in the plugs ...
>>
>>>> No, at least IIRC - the special headphones that come with the system
>>>> aren't for voice calling or whatever, they're active noise cancelling
>>>> earphones.
>>>> http://forum.notebookreview.com/sony/501220-sony-noise-cancelling-ear-phones-came-vaio-z-3.html
>>>> is a thread about them, for e.g.
>>> OK, then it's not suitable to handle it as a headset.
>>> I expected it being rather a standard TRRS connector.
>> OK, I looked into that and here are my findings:
>>
>> People reported about two different models of noise cancelling
>> headphones in the context of Sony VAIO VPCZ Notebooks.
>> Both are 5-conductor jacks.
>>
>> You can see them both here:
>> http://attachment.imp3.net/forum/month_1103/11030618490735852e6e2772f8.jpg
>> The right side version is better seen here with it's extra "notch"
>> adding the 5th conductor to an otherwise 4.5mm 4-conductor TRRS jack (3
>> black rings + notch)
>>       http://pic.yupoo.com/melly/C8LBXQYf/LBWc6.jpg
>> The left side version is a 3.5 mm 5-conductor TRRS phone connector (4
>> black rings)
>> http://img03.taobaocdn.com/bao/uploaded/i3/T1xd9qXcNbXXaS84UV_020744.jpg
>>
>> I do have the LEFT side version (the one with 4 black rings)
>>
>> Important:
>>    * This TRRS headset jack works just fine when you plug a stereo
>> headphones (3-conductor version).
>>    * And It seems to also work fine with a 4-conductor version (headphone
>> + mic smartphone headset) - see about "Mic 1" below.
>>
>> More details about the wiring (from an alsamixer viewpoint in (debian)
>> kernel 3.9.6):
>>
>> +++ "Mic 1" refers to the earplug Stereo mic channel.
>> The "Microphone Boost 1" controls nicely this "Mic 1".
>> When capturing from "Mic 1" in alsamixer (with 3.9.6 debian kernel
>> without any new patch):
>>
>>       * plugging a standard 4-conductor TRRS (headset + MONO microphone
>> combination like common for smartphones these days with 3 black rings)
>>       -> the microphone comes through on the right microphone channel
>>       Unfortunately I don't have a headset + STEREO microphone
>> combination at hand :/
>>
>>       * plugging the 5-conductor TRRS original noise cancelling headset
>> (model Sony "mdr-nc021")
>>       -> the microphone in the /left/ earplug (it says "L" on the plug)
>> comes through on the LEFT microphone channel
>>       +  the microphone in the /right/ earplug (it says "R" on the plug)
>> comes through on the RIGHT microphone channel
>>
>> +++ "Mic" refers to the Mic TRRS standard Stereo jack which is beside
>> the headset TRRS jack.
>> The "Microphone Boost" controls nicely the "Mic" capture channel.
>>
>> +++ "Internal" refers to the built in Stereo Microphone
>>
>> +++ The "Digital" channel seems to have the exact same effect than the
>> "Capture" channel (controlling the degree of amplification of the
>> currently active capture source)
>> There is certainly a deeper sense in the distinguishing both of them,
>> but I don't get it :)
>>
>> So this does make all perfect sense to me (especially "Mic 1") and I
>> like the idea to further expose this quite /real/ stereo microphone
>> channel "Mic 1".
>>
>> Here is a small test recording I did using the (model Sony "mdr-nc021")
>> headset:
>> https://docs.google.com/file/d/0B9I6C680kzS1RFBOdWtaZXNIY00/edit?usp=sharing
>>
>> (( maybe rename "Mic" to "Mic jack" and "Mic 1" to "Headphone Mic" ))
> Thanks for the detailed analysis.
> So we should keep both inputs.  A remaining question is whether to
> rename the control names, especially "Mic 1".
>
> BTW, did you already test the patch?  It's waiting for test feedback.
> Otherwise the fix can't be queued to upstream.
>
>
> Takashi
/// Thanks!
Wao, your always so quick :)

/// Small question:
What is the use of Digital and Capture seeming to do the same thing ?

/// Rename:
Yes it's what I thought, but am name would best express the fact that 
this is an /optional/ MIC within the headphone plug.
"Mic 1" -> "Headphone Mic" ... but that's a bit lengthy :(

/// Patch:
Hmmm. I am not sure what I am doing wrong here, but I don't get it so 
apply nicely.
I tried:
debian 3.9.6,
linux vanilla 3.9.6
deiban 3.10
linux vanilla 3.10

I am applying the attached x.diff (I took from your email from
     Date: Mon, 08 Jul 2013 10:04:22 +0200
and I do get this:

*** Linux Vanilla 3.10:
/mnt/tmp/src/linux-3.10 % cat /tmp/x.diff|patch -p1
patching file Documentation/sound/alsa/HD-Audio.txt
patching file sound/pci/hda/hda_generic.c
Hunk #1 FAILED at 142.
Hunk #2 FAILED at 1541.
Hunk #3 FAILED at 1554.
Hunk #4 FAILED at 1582.
Hunk #5 FAILED at 1600.
5 out of 5 hunks FAILED -- saving rejects to file 
sound/pci/hda/hda_generic.c.rej
patching file sound/pci/hda/hda_generic.h
Hunk #1 FAILED at 220.
1 out of 1 hunk FAILED -- saving rejects to file 
sound/pci/hda/hda_generic.h.rej
patching file sound/pci/hda/patch_realtek.c
Hunk #1 FAILED at 1843.
1 out of 1 hunk FAILED -- saving rejects to file 
sound/pci/hda/patch_realtek.c.rej

What am I missing here ? Do you need the rejects ?


*** Debian 3.10:

/mnt/tmp/src/linux-3.10~rc7 % cat /tmp/x.diff|patch -p1
patching file Documentation/sound/alsa/HD-Audio.txt
patching file sound/pci/hda/hda_generic.c
Hunk #1 FAILED at 142.
Hunk #2 FAILED at 1541.
Hunk #3 FAILED at 1554.
Hunk #4 FAILED at 1582.
Hunk #5 FAILED at 1600.
5 out of 5 hunks FAILED -- saving rejects to file 
sound/pci/hda/hda_generic.c.rej
patching file sound/pci/hda/hda_generic.h
Hunk #1 FAILED at 220.
1 out of 1 hunk FAILED -- saving rejects to file 
sound/pci/hda/hda_generic.h.rej
patching file sound/pci/hda/patch_realtek.c
Hunk #1 FAILED at 1843.
1 out of 1 hunk FAILED -- saving rejects to file 
sound/pci/hda/patch_realtek.c.rej

And from what I remeber the 3.9.6 looked very similar.


--------------020300010704000607090006
Content-Type: text/plain; charset=UTF-8;
 name="x.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="x.diff"

diff --git a/Documentation/sound/alsa/HD-Audio.txt b/Documentation/sound/alsa/HD-Audio.txt
index c3c912d..42a0a39 100644
--- a/Documentation/sound/alsa/HD-Audio.txt
+++ b/Documentation/sound/alsa/HD-Audio.txt
@@ -454,6 +454,8 @@ The generic parser supports the following hints:
 - need_dac_fix (bool): limits the DACs depending on the channel count
 - primary_hp (bool): probe headphone jacks as the primary outputs;
   default true
+- multi_io (bool): try probing multi-I/O config (e.g. shared
+  line-in/surround, mic/clfe jacks)
 - multi_cap_vol (bool): provide multiple capture volumes
 - inv_dmic_split (bool): provide split internal mic volume/switch for
   phase-inverted digital mics
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 8e77cbb..33062ad 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -142,6 +142,9 @@ static void parse_user_hints(struct hda_codec *codec)
    val = snd_hda_get_bool_hint(codec, "primary_hp");
    if (val >= 0)
        spec->no_primary_hp = !val;
+   val = snd_hda_get_bool_hint(codec, "multi_io");
+   if (val >= 0)
+       spec->no_multi_io = !val;
    val = snd_hda_get_bool_hint(codec, "multi_cap_vol");
    if (val >= 0)
        spec->multi_cap_vol = !!val;
@@ -1541,7 +1544,8 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
                          cfg->speaker_pins,
                          spec->multiout.extra_out_nid,
                          spec->speaker_paths);
-           if (fill_mio_first && cfg->line_outs == 1 &&
+           if (!spec->no_multi_io &&
+               fill_mio_first && cfg->line_outs == 1 &&
                cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
                err = fill_multi_ios(codec, cfg->line_out_pins[0], true);
                if (!err)
@@ -1554,7 +1558,7 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
                   spec->private_dac_nids, spec->out_paths,
                   spec->main_out_badness);
 
-   if (fill_mio_first &&
+   if (!spec->no_multi_io && fill_mio_first &&
        cfg->line_outs == 1 && cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
        /* try to fill multi-io first */
        err = fill_multi_ios(codec, cfg->line_out_pins[0], false);
@@ -1582,7 +1586,8 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
            return err;
        badness += err;
    }
-   if (cfg->line_outs == 1 && cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
+   if (!spec->no_multi_io &&
+       cfg->line_outs == 1 && cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
        err = fill_multi_ios(codec, cfg->line_out_pins[0], false);
        if (err < 0)
            return err;
@@ -1600,7 +1605,8 @@ static int fill_and_eval_dacs(struct hda_codec *codec,
                check_aamix_out_path(codec, spec->speaker_paths[0]);
    }
 
-   if (cfg->hp_outs && cfg->line_out_type == AUTO_PIN_SPEAKER_OUT)
+   if (!spec->no_multi_io &&
+       cfg->hp_outs && cfg->line_out_type == AUTO_PIN_SPEAKER_OUT)
        if (count_multiio_pins(codec, cfg->hp_pins[0]) >= 2)
            spec->multi_ios = 1; /* give badness */
 
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index e199a85..48d4402 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -220,6 +220,7 @@ struct hda_gen_spec {
    unsigned int hp_mic:1; /* Allow HP as a mic-in */
    unsigned int suppress_hp_mic_detect:1; /* Don't detect HP/mic */
    unsigned int no_primary_hp:1; /* Don't prefer HP pins to speaker pins */
+   unsigned int no_multi_io:1; /* Don't try multi I/O config */
    unsigned int multi_cap_vol:1; /* allow multiple capture xxx volumes */
    unsigned int inv_dmic_split:1; /* inverted dmic w/a for conexant */
    unsigned int own_eapd_ctl:1; /* set EAPD by own function */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8bd2261..7913a2c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1843,8 +1843,10 @@ static void alc882_fixup_no_primary_hp(struct hda_codec *codec,
                       const struct hda_fixup *fix, int action)
 {
    struct alc_spec *spec = codec->spec;
-   if (action == HDA_FIXUP_ACT_PRE_PROBE)
+   if (action == HDA_FIXUP_ACT_PRE_PROBE) {
        spec->gen.no_primary_hp = 1;
+       spec->gen.no_multi_io = 1;
+   }
 }
 
 static const struct hda_fixup alc882_fixups[] = {

--------------020300010704000607090006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020300010704000607090006--
