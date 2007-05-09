From: "Nobin Mathew" <nobin.mathew@gmail.com>
Subject: Fwd: Fwd: [ASoC] Mic record is not working with wm9713
	ASoC driver
Date: Wed, 9 May 2007 17:50:39 +0530
Message-ID: <8d6898730705090520l36aad5d2p4db6af9f0289f0f3@mail.gmail.com>
References: <8d6898730705090218h4ba10102u917b0943bad97a8b@mail.gmail.com>
	<1178706334.3740.24.camel@a10072.wolfsonmicro.main>
	<8d6898730705090344ofc820d9r96cb4723722027be@mail.gmail.com>
	<1178707947.3740.30.camel@a10072.wolfsonmicro.main>
	<8d6898730705090355v6966309av6aff6c1e93c5a876@mail.gmail.com>
	<8d6898730705090358g104d9a9fjd4ad2697c44ec39b@mail.gmail.com>
	<1178712484.3740.49.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_143077_10239888.1178713239788"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 40FC92443F
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2007 14:20:47 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so162417nzf
	for <alsa-devel@alsa-project.org>; Wed, 09 May 2007 05:20:46 -0700 (PDT)
In-Reply-To: <1178712484.3740.49.camel@a10072.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_143077_10239888.1178713239788
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Forwarded Conversation
Subject: [ASoC] Mic record is not working with wm9713 ASoC driver
------------------------

 From: Nobin Mathew <nobin.mathew@gmail.com>
To: linux-kernel@vger.kernel.org
Date: Wed, May 9, 2007 at 2:48 PM

I am trying to record mic with AsoC wm9713 driver. My Mic is connected "Mic 1".

My settings

'Mic A Source' -> "Mic 1"
'Mic Boost (+20dB)' [on]
'Capture' [on]
'Left Capture Source' "Mic 1"
'Right Capture Source' "Mic 1"


i am issuing following command to record
"arecord -M -f S16_LE sound.wav"

But what i found is driver is not enabling "Mic bias" and "Mic A PGA"

this dump of /sys/devices/platform/soc-audio/dapm_widget while
"arecord" is running is given below


Mic Bias: Off
Mic B Pre Amp: Off
Mic A Pre Amp: On
Mic B PGA: Off
Mic A PGA: Off
Mono In: Off
Right Line In: Off
Left Line In: Off
Mono Out: Off
Out 4: Off
Out 3: Off
Right Speaker: Off
Left Speaker: Off
Right Headphone: Off
Left Headphone: Off
Right ADC: On
Left ADC: On
Aux DAC: Off
Voice DAC: Off
Capture Mixer: Off
HP Mixer: Off
AC97 Mixer: Off
Right DAC: Off
Left DAC: Off
Speaker Mixer: Off
Mono Mixer: Off
Right HP Mixer: Off
Left HP Mixer: Off
PM State: D0

In idea why this is happening?
what is going wrong with my settings?

Nobin Mathew

--------
 From: Andrew Morton <akpm@linux-foundation.org>
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
Takashi Iwai <tiwai@suse.de>
Date: Wed, May 9, 2007 at 3:51 PM

[Quoted text hidden](maintainers cc'ed)

--------
 From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: linux-kernel@vger.kernel.org
Date: Wed, May 9, 2007 at 3:55 PM

On Wed, 2007-05-09 at 14:48 +0530, Nobin Mathew wrote:
> I am trying to record mic with AsoC wm9713 driver. My Mic is connected "Mic 1".

I've replied to this duplicate post on alsa-dev.

Liam


--------
 From: Nobin Mathew <nobin.mathew@gmail.com>
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org
Date: Wed, May 9, 2007 at 4:14 PM

Liam Sorry for disturbing you again,

I could not find that reply on alsa devel mailing list

Can u send that to me

Thanks
[Quoted text hidden]
--------
 From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
To: Nobin Mathew <nobin.mathew@gmail.com>
Date: Wed, May 9, 2007 at 4:22 PM

The mail server is probably a little behind..... give it about 30
mins...

Liam
[Quoted text hidden]> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


--------
 From: Nobin Mathew <nobin.mathew@gmail.com>
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Date: Wed, May 9, 2007 at 4:25 PM
Attachments: identity_wm9713.c

Liam i got the mail.
I am not setting any audio paths in my machine driver
[Quoted text hidden]
--------
 From: Nobin Mathew <nobin.mathew@gmail.com>
To: linux-kernel@vger.kernel.org
Date: Wed, May 9, 2007 at 4:28 PM
Attachments: identity_wm9713.c

[Quoted text hidden]
--------
 From: Nobin Mathew <nobin.mathew@gmail.com>
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Date: Wed, May 9, 2007 at 5:00 PM

Liam i have few more doubts

i have only Mic1, i am not connecting to Mic2A and Mic 2B
So can i remove audio path to Mic2A and Mic2B
means
my audio path will be like
static const char* audio_map[][3] = {

        /* mic is connected to mic1 - with bias */
        {"MIC1", NULL, "Mic Bias"},
        {"Mic Bias", NULL, "Mic 1"},
#if 0
        /* mic is connected to mic2A - with bias */
        {"MIC2A", NULL, "Mic Bias"},
        {"Mic Bias", NULL, "Mic 2"},
        /* mic is connected to mic2B - with bias */
        {"MIC2B", NULL, "Mic Bias"},
        {"Mic Bias", NULL, "Mic 3"},
#endif

        {NULL, NULL, NULL},
};

instead of

static const char* audio_map[][3] = {

        /* mic is connected to mic1 - with bias */
        {"MIC1", NULL, "Mic Bias"},
        {"Mic Bias", NULL, "Mic 1"},
        /* mic is connected to mic2A - with bias */
        {"MIC2A", NULL, "Mic Bias"},
        {"Mic Bias", NULL, "Mic 2"},
        /* mic is connected to mic2B - with bias */
        {"MIC2B", NULL, "Mic Bias"},
        {"Mic Bias", NULL, "Mic 3"},

        {NULL, NULL, NULL},
};


what is the meaning of these lines, what is RXP and RXN

        /* set up mainstone codec pins */
//      snd_soc_dapm_set_endpoint(codec, "RXP", 0);
//      snd_soc_dapm_set_endpoint(codec, "RXN", 0);
        snd_soc_dapm_set_endpoint(codec, "MIC1", 0);
[Quoted text hidden]
--------
 From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
To: Nobin Mathew <nobin.mathew@gmail.com>
Date: Wed, May 9, 2007 at 5:30 PM

On Wed, 2007-05-09 at 17:00 +0530, Nobin Mathew wrote:
> Liam i have few more doubts
>
> i have only Mic1, i am not connecting to Mic2A and Mic 2B
> So can i remove audio path to Mic2A and Mic2B
> means
> my audio path will be like
> static const char* audio_map[][3] = {
>
>       /* mic is connected to mic1 - with bias */
>       {"MIC1", NULL, "Mic Bias"},
>       {"Mic Bias", NULL, "Mic 1"},
> #if 0
>       /* mic is connected to mic2A - with bias */
>       {"MIC2A", NULL, "Mic Bias"},
>       {"Mic Bias", NULL, "Mic 2"},
>       /* mic is connected to mic2B - with bias */
>       {"MIC2B", NULL, "Mic Bias"},
>       {"Mic Bias", NULL, "Mic 3"},
> #endif
>
>       {NULL, NULL, NULL},
> };
>

This is fine, it's safe to remove unused Mic's.

> instead of
>
> static const char* audio_map[][3] = {
>
>       /* mic is connected to mic1 - with bias */
>       {"MIC1", NULL, "Mic Bias"},
>       {"Mic Bias", NULL, "Mic 1"},
>       /* mic is connected to mic2A - with bias */
>       {"MIC2A", NULL, "Mic Bias"},
>       {"Mic Bias", NULL, "Mic 2"},
>       /* mic is connected to mic2B - with bias */
>       {"MIC2B", NULL, "Mic Bias"},
>       {"Mic Bias", NULL, "Mic 3"},
>
>       {NULL, NULL, NULL},
> };
>
>
> what is the meaning of these lines, what is RXP and RXN
>
>       /* set up mainstone codec pins */
> //    snd_soc_dapm_set_endpoint(codec, "RXP", 0);
> //    snd_soc_dapm_set_endpoint(codec, "RXN", 0);
>       snd_soc_dapm_set_endpoint(codec, "MIC1", 0);

RXP and RXN are from a different codec and should be removed. Also
remove the MIC1 endpoint setting to 0 as this will disconnect it.


Comments from driver :-

static int identity_wm9713_ac97_init(struct snd_soc_codec *codec)
{
        struct platform_controller *controller =
codec->ac97->bus->private_data;
        struct aaci *aaci = (struct aaci *)controller->bus_controller;

        snd_ac97_pcm_assign(codec->ac97->bus, 3, ac97_defs);
        aaci->ac97_bus = codec->ac97->bus;

        /*
         *     * Disable AC97 PC Beep input on audio codecs.
         *          */
        if (ac97_is_audio(codec->ac97))
                snd_ac97_write_cache(codec->ac97, AC97_PC_BEEP,
0x801e);
        return 0;
}


AC97 beep should be disabled in userspace. e.g. alsa configuration file
or by changing mixers settings (alsactl can save and restore settings).

unsigned int identity_wm9713_config_sysclk(struct snd_soc_pcm_runtime
*rtd,
        struct snd_soc_clock_info *info)
{
        return rtd->codec_dai->config_sysclk(rtd->codec_dai, info,
12187500);
}


This function has been removed in current ASoC versions. It's best to
upgrade from kernel.org or from here :-

http://opensource.wolfsonmicro.com/cgi-bin/gitweb/gitweb.cgi?p=linux-2.6-asoc;a=shortlog;h=dev


Liam


--------
 From: Nobin Mathew <nobin.mathew@gmail.com>
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Date: Wed, May 9, 2007 at 5:30 PM

Liam
Thanks of lot

i got it working

Cheers
[Quoted text hidden]
--------
 From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: linux-kernel@vger.kernel.org
Date: Wed, May 9, 2007 at 5:38 PM

It's probably best to keep this thread on alsa-dev otherwise things
start to get confusing when cross posting occurs.

Liam





--------

------=_Part_143077_10239888.1178713239788
Content-Type: text/x-csrc; name=identity_wm9713.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f1hog9vw
Content-Disposition: attachment; filename="identity_wm9713.c"

LyoKICogIFNpUkYgVGVjaG5vbG9neSwgSW5jLiBHUFMgU29mdHdhcmUgCiAqCiAqICBDb3B5cmln
aHQgKEMpIDIwMDYgYnkgU2lSRiBUZWNobm9sb2d5LCBJbmMuIEFsbCByaWdodHMgcmVzZXJ2ZWQu
CiAqCiAqICBsaW51eC9zb3VuZC9zb2Mvc2lyZjNhL2lkZW50aXR5X3dtOTcxMy5jCiAqICAKICog
VGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFu
ZC9vciBtb2RpZnkKICogaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKICogdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlv
bjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUgTGljZW5zZSwgb3IKICogKGF0IHlvdXIgb3B0aW9u
KSBhbnkgbGF0ZXIgdmVyc2lvbi4KICoKICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGlu
IHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCiAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJS
QU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCiAqIE1FUkNIQU5UQUJJ
TElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKICogR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KICoKICogWW91IHNob3Vs
ZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UK
ICogYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29m
dHdhcmUKICogRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJv
c3RvbiwgTUEgIDAyMTExLTEzMDcgIFVTQQogKi8KCi8qCiAqIE1hY2hpbmUgU3BlY2lmaWMgY29k
ZWZvciBBU29DIGRyaXZlcgogKiBUaGlzIHdpbGwgc2V0dXAgYWM5NyBjb250cm9sbGVyIHdpdGgg
d205NzEzIGNvZGVjIHN1cHBvcnQKICovCgojaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CiNpbmNs
dWRlIDxsaW51eC9kZWxheS5oPgojaW5jbHVkZSA8bGludXgvaW5pdC5oPgojaW5jbHVkZSA8bGlu
dXgvaW9wb3J0Lmg+CiNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4KI2luY2x1ZGUgPGxpbnV4L3Nw
aW5sb2NrLmg+CiNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KI2luY2x1ZGUgPGxpbnV4L2Vy
ci5oPgojaW5jbHVkZSA8bGludXgvYW1iYS9idXMuaD4KI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBw
aW5nLmg+CS8qIERNQSBtZW1vcnkgaXMgdXNlZCBmb3IgdGhlIGJ1ZmZlciBldmVuIGlmIG5vIERN
QSBmb3IgdGhpcyBhcmNoaXRlY3R1cmUgKi8KI2luY2x1ZGUgPGxpbnV4L3BtLmg+CgoKI2luY2x1
ZGUgPGFzbS9pby5oPgojaW5jbHVkZSA8YXNtL2lycS5oPgojaW5jbHVkZSA8YXNtL3NpemVzLmg+
CgojaWZkZWYgQ09ORklHX0FSTV9BTUJBX0RNQQojIGluY2x1ZGUgPGFzbS9tYWNoLXR5cGVzLmg+
CiNlbmRpZgoKI2luY2x1ZGUgPHNvdW5kL2RyaXZlci5oPgojaW5jbHVkZSA8c291bmQvY29yZS5o
PgojaW5jbHVkZSA8c291bmQvaW5pdHZhbC5oPgojaW5jbHVkZSA8c291bmQvYWM5N19jb2RlYy5o
PgojaW5jbHVkZSA8c291bmQvcGNtLmg+CiNpbmNsdWRlIDxzb3VuZC9wY21fcGFyYW1zLmg+CiNp
bmNsdWRlIDxzb3VuZC9zb2MuaD4KI2luY2x1ZGUgPHNvdW5kL3NvYy1kYXBtLmg+CgojaW5jbHVk
ZSAiLi4vY29kZWNzL2FjOTcuaCIKI2luY2x1ZGUgInBsYXRmb3JtX3NvdW5kLmgiCiNpbmNsdWRl
ICJhYWNpLmgiCgpleHRlcm4gc3RydWN0IHNuZF9zb2NfY3B1X2RhaSBhYWNpX2FjOTdfZGFpW107
CmV4dGVybiBzdHJ1Y3Qgc25kX3NvY19jb2RlY19kYWkgd205NzEzX2RhaVtdOwpleHRlcm4gc3Ry
dWN0IHNuZF9zb2NfcGxhdGZvcm0gc2lyZjNhX3NvY19wbGF0Zm9ybTsKZXh0ZXJuIHN0cnVjdCBz
bmRfc29jX2NvZGVjX2RldmljZSBzb2NfY29kZWNfZGV2X3dtOTcxMzsKZXh0ZXJuIHN0cnVjdCBh
Yzk3X3BjbSBhYzk3X2RlZnNbXTsKCmV4dGVybiBpbnQgc2lyZjNhX2FjOTdfcHJvYmUoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqKTsKZXh0ZXJuIHZvaWQgc2lyZjNhX2FjOTdfcmVtb3ZlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKik7CmV4dGVybiB2b2lkIHNuZF9hYzk3X2J1c19wcm9jX2luaXQo
c3RydWN0IHNuZF9hYzk3X2J1cyAqKTsKZXh0ZXJuIHZvaWQgc25kX2FjOTdfYnVzX3Byb2NfZG9u
ZShzdHJ1Y3Qgc25kX2FjOTdfYnVzICopOwoKCnN0YXRpYyBpbnQgaWRlbnRpdHlfd205NzEzX3N0
YXJ0dXAoc25kX3BjbV9zdWJzdHJlYW1fdCAqc3Vic3RyZWFtKQp7CglyZXR1cm4gMDsKfQoKc3Rh
dGljIHN0cnVjdCBzbmRfc29jX29wcyBpZGVudGl0eV93bTk3MTNfb3BzID0gewoJLnN0YXJ0dXAg
PSBpZGVudGl0eV93bTk3MTNfc3RhcnR1cCwKfTsKCnN0YXRpYyBpbnQgaWRlbnRpdHlfd205NzEz
X2FjOTdfaW5pdChzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMpCnsKCXN0cnVjdCBwbGF0Zm9y
bV9jb250cm9sbGVyICpjb250cm9sbGVyID0gY29kZWMtPmFjOTctPmJ1cy0+cHJpdmF0ZV9kYXRh
OwoJc3RydWN0IGFhY2kgKmFhY2kgPSAoc3RydWN0IGFhY2kgKiljb250cm9sbGVyLT5idXNfY29u
dHJvbGxlcjsKCiAgICAJc25kX2FjOTdfcGNtX2Fzc2lnbihjb2RlYy0+YWM5Ny0+YnVzLCAzLCBh
Yzk3X2RlZnMpOwogICAgCWFhY2ktPmFjOTdfYnVzID0gY29kZWMtPmFjOTctPmJ1czsKICAgIAog
ICAgCS8qCgkgKiAgICAgKiBEaXNhYmxlIEFDOTcgUEMgQmVlcCBpbnB1dCBvbiBhdWRpbyBjb2Rl
Y3MuCgkgKiAgICAgICAgICAqLwogICAgCWlmIChhYzk3X2lzX2F1ZGlvKGNvZGVjLT5hYzk3KSkK
ICAgIAkJc25kX2FjOTdfd3JpdGVfY2FjaGUoY29kZWMtPmFjOTcsIEFDOTdfUENfQkVFUCwgMHg4
MDFlKTsgCiAgICAJcmV0dXJuIDA7Cn0KdW5zaWduZWQgaW50IGlkZW50aXR5X3dtOTcxM19jb25m
aWdfc3lzY2xrKHN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1lICpydGQsCglzdHJ1Y3Qgc25kX3Nv
Y19jbG9ja19pbmZvICppbmZvKQp7CglyZXR1cm4gcnRkLT5jb2RlY19kYWktPmNvbmZpZ19zeXNj
bGsocnRkLT5jb2RlY19kYWksIGluZm8sIDEyMTg3NTAwKTsKfQoKCnN0YXRpYyBzdHJ1Y3Qgc25k
X3NvY19kYWlfbGluayBpZGVudGl0eV93bTk3MTNfZGFpW10gPSB7Cgl7CgkJLm5hbWUgPSAiQUM5
NyIsCgkJLnN0cmVhbV9uYW1lID0gIkFDOTcgSGlGaSIsCgkJLmNwdV9kYWkgPSAmYWFjaV9hYzk3
X2RhaVswXSwKCQkuY29kZWNfZGFpID0gJndtOTcxM19kYWlbMF0sCgkJLmluaXQgPSBpZGVudGl0
eV93bTk3MTNfYWM5N19pbml0LAoJCS5jb25maWdfc3lzY2xrID0gaWRlbnRpdHlfd205NzEzX2Nv
bmZpZ19zeXNjbGssCgoJfSwKCS8qCgl7CgkJLm5hbWUgPSAiV005NzEzIiwKCQkuc3RyZWFtX25h
bWUgPSAiQkxVRVRPT1RIIFZPSUNFIiwKCQkuY3B1X2RhaSA9ICZhYWNpX2FjOTdfZGFpWzFdLAoJ
CS5jb2RlY19kYWkgPSAmd205NzEzX2RhaVsyXSwKCX0sCiovCQp9OwoKaW50IGlkZW50aXR5X3dt
OTcxM19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQp7CglpbnQgcmV0ID0gMDsK
CXN0cnVjdCBzbmRfc29jX2RldmljZSAqc29jZGV2OwoKCXNvY2RldiA9IHBsYXRmb3JtX2dldF9k
cnZkYXRhKHBkZXYpOwoJc29jZGV2LT5tYWNoaW5lLT5kYWlfbGluay0+Y3B1X2RhaS0+cHJvYmUg
PSBzaXJmM2FfYWM5N19wcm9iZTsJCglzb2NkZXYtPm1hY2hpbmUtPmRhaV9saW5rLT5jcHVfZGFp
LT5yZW1vdmUgPSBzaXJmM2FfYWM5N19yZW1vdmU7CQoKCXJldHVybiByZXQ7Cn0KCmludCBpZGVu
dGl0eV93bTk3MTNfc3VzcGVuZF9wcmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgcG1f
bWVzc2FnZV90IHN0YXRlKQp7CglzdHJ1Y3Qgc25kX3NvY19kZXZpY2UgKnNvY2RldiA9IHBsYXRm
b3JtX2dldF9kcnZkYXRhKHBkZXYpOwoJc3RydWN0IHNuZF9zb2NfY29kZWMgKmNvZGVjID0gc29j
ZGV2LT5jb2RlYzsKCXN0cnVjdCBzbmRfc29jX2NvZGVjX2RhaSAqZGFpID0gY29kZWMtPmRhaTsK
CXN0cnVjdCBwbGF0Zm9ybV9jb250cm9sbGVyICpjb250cm9sbGVyID0gZGFpLT5wcml2YXRlX2Rh
dGE7CgoJY29udHJvbGxlci0+c3RhdGUuZXZlbnQgPSBzdGF0ZS5ldmVudDsKCXJldHVybiAwOwp9
CgppbnQgaWRlbnRpdHlfd205NzEzX3Jlc3VtZV9wb3N0KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpCnsKCXN0cnVjdCBzbmRfc29jX2RldmljZSAqc29jZGV2ID0gcGxhdGZvcm1fZ2V0X2Ry
dmRhdGEocGRldik7CglzdHJ1Y3Qgc25kX3NvY19jb2RlYyAqY29kZWMgPSBzb2NkZXYtPmNvZGVj
OwoJc3RydWN0IHNuZF9zb2NfY29kZWNfZGFpICpkYWkgPSBjb2RlYy0+ZGFpOwoJc3RydWN0IHBs
YXRmb3JtX2NvbnRyb2xsZXIgKmNvbnRyb2xsZXIgPSBkYWktPnByaXZhdGVfZGF0YTsKCgljb250
cm9sbGVyLT5zdGF0ZS5ldmVudCA9IFBNX0VWRU5UX09OOwkKCXJldHVybiAwOwp9CgpzdGF0aWMg
c3RydWN0IHNuZF9zb2NfbWFjaGluZSBpZGVudGl0eV93bTk3MTMgPSB7CgkubmFtZSA9ICJJREVO
VElUWSIsCgkucHJvYmUgPSBpZGVudGl0eV93bTk3MTNfcHJvYmUsCgkuc3VzcGVuZF9wcmUgPSBp
ZGVudGl0eV93bTk3MTNfc3VzcGVuZF9wcmUsCgkucmVzdW1lX3Bvc3QgPSBpZGVudGl0eV93bTk3
MTNfcmVzdW1lX3Bvc3QsCgkuZGFpX2xpbmsgPSBpZGVudGl0eV93bTk3MTNfZGFpLAoJLm51bV9s
aW5rcyA9IEFSUkFZX1NJWkUoaWRlbnRpdHlfd205NzEzX2RhaSksCgkub3BzID0gJmlkZW50aXR5
X3dtOTcxM19vcHMsCn07CgpzdGF0aWMgc3RydWN0IHNuZF9zb2NfZGV2aWNlIGlkZW50aXR5X3dt
OTcxM19zbmRfZGV2ZGF0YSA9IHsKCS5tYWNoaW5lID0gJmlkZW50aXR5X3dtOTcxMywKCS5wbGF0
Zm9ybSA9ICZzaXJmM2Ffc29jX3BsYXRmb3JtLAoJLmNvZGVjX2RldiA9ICZzb2NfY29kZWNfZGV2
X3dtOTcxMywKfTsKCmV4dGVybiBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIGlkZW50aXR5X3NuZF9k
ZXZpY2U7CnN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBpZGVudGl0eV93bTk3MTNfc25kX2Rldmlj
ZSA9ICZpZGVudGl0eV9zbmRfZGV2aWNlOwoKc3RhdGljIGludCBfX2luaXQgaWRlbnRpdHlfd205
NzEzX2luaXQodm9pZCkKewoJaW50IHJldDsKCglkZXZpY2VfaW5pdGlhbGl6ZSgmcGlkZW50aXR5
X3dtOTcxM19zbmRfZGV2aWNlLT5kZXYpOwoJcGxhdGZvcm1fc2V0X2RydmRhdGEocGlkZW50aXR5
X3dtOTcxM19zbmRfZGV2aWNlLCAmaWRlbnRpdHlfd205NzEzX3NuZF9kZXZkYXRhKTsKCWlkZW50
aXR5X3dtOTcxM19zbmRfZGV2ZGF0YS5kZXYgPSAmcGlkZW50aXR5X3dtOTcxM19zbmRfZGV2aWNl
LT5kZXY7CglyZXQgPSBwbGF0Zm9ybV9kZXZpY2VfYWRkKHBpZGVudGl0eV93bTk3MTNfc25kX2Rl
dmljZSk7CgoJaWYgKHJldCkKCQlwbGF0Zm9ybV9kZXZpY2VfcHV0KHBpZGVudGl0eV93bTk3MTNf
c25kX2RldmljZSk7CgoJcmV0dXJuIHJldDsKfQoKc3RhdGljIHZvaWQgX19leGl0IGlkZW50aXR5
X3dtOTcxM19leGl0KHZvaWQpCnsKCXBsYXRmb3JtX2RldmljZV91bnJlZ2lzdGVyKHBpZGVudGl0
eV93bTk3MTNfc25kX2RldmljZSk7Cn0KCm1vZHVsZV9pbml0KGlkZW50aXR5X3dtOTcxM19pbml0
KTsKbW9kdWxlX2V4aXQoaWRlbnRpdHlfd205NzEzX2V4aXQpOwoKLyogTW9kdWxlIGluZm9ybWF0
aW9uICovCk1PRFVMRV9BVVRIT1IoIk5vYmluIE1hdGhldyIpOwpNT0RVTEVfREVTQ1JJUFRJT04o
IkFMU0EgU29DIFNpUkYzQSIpOwpNT0RVTEVfTElDRU5TRSgiR1BMIik7Cg==
------=_Part_143077_10239888.1178713239788
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------=_Part_143077_10239888.1178713239788--
