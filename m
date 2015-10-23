From: George Gugulea <gugulea@gmail.com>
Subject: Re: No sound after suspend-to-ram
Date: Sat, 24 Oct 2015 01:01:00 +0300
Message-ID: <CALcwt_BakjANwqurkEkywkFTiNUd3WcmJFn1tovM5AVnF7XXUA@mail.gmail.com>
References: <CALcwt_Acar7dhMHtEo9PtSi+RBcpXXDcQTNHZr-CEfNYhhWmRA@mail.gmail.com>
 <s5hh9ljj5nd.wl-tiwai@suse.de>
 <CALcwt_DPaX1-oBw6gVUT85bFLUKeQGcv=M9aCBHsHD=+eu_bVA@mail.gmail.com>
 <s5hsi52ujmp.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A236B9@RTITMBSV09.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c25d4e3ceb860522ccbf6b
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f67.google.com (mail-lf0-f67.google.com
 [209.85.215.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 31F29264F30
 for <alsa-devel@alsa-project.org>; Sat, 24 Oct 2015 00:01:01 +0200 (CEST)
Received: by lffz202 with SMTP id z202so9057726lff.3
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 15:01:00 -0700 (PDT)
In-Reply-To: <6FAB7C47BCF00940BB0999A99BE3547A17A236B9@RTITMBSV09.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kailang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--001a11c25d4e3ceb860522ccbf6b
Content-Type: text/plain; charset=UTF-8

Sure thing,

Kailang, yes, there is a side headphones jack and it does work OK
after PM suspend-to-ram

I did `echo 1 > /sys/modules/snd_hda_codec/parameters/dump_coef ` and
I attached the output but you are probably interested in this:

Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
.....
447c447
<     Coeff 0x1f: 0x00c0
---
>     Coeff 0x1f: 0x0000
464c464
<     Coeff 0x30: 0x00b1
---
>     Coeff 0x30: 0x0090

And after I reset the two processing caps, the sound is back again.

hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x1f
hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x00c0
hda-verb /dev/snd/hwC0D0 0x20 SET_COEF_INDEX 0x30
hda-verb /dev/snd/hwC0D0 0x20 SET_PROC_COEF 0x00b1

I'm not sure that this are the correct parameters of hda-verb (because
I lack the knowledge of alsa development) but based on the result it
seems to be correct

Takashi, thanks for the hint

On Fri, Oct 23, 2015 at 11:28 AM, Kailang <kailang@realtek.com> wrote:
>
> Was speaker no sound only? Or Headphone also no sound.
>
>> -----Original Message-----
>> From: Takashi Iwai [mailto:tiwai@suse.de]
>> Sent: Friday, October 23, 2015 3:31 PM
>> To: George Gugulea
>> Cc: Kailang; alsa-devel@alsa-project.org
>> Subject: Re: [alsa-devel] No sound after suspend-to-ram
>>
>> On Thu, 22 Oct 2015 23:23:05 +0200,
>> George Gugulea wrote:
>> >
>> > I did now with 4.3.0-rc6 and there is the same problem.
>> > I reattached the two outputs, before and after (as a patch)
>> suspend-to-ram:
>> > diff -u alsa-info.txt.4.3-rc6.before alsa-info.txt.4.3-rc6.after >
>> > alsa-info.txt.4.3-rc6.patch
>>
>> OK, so we need to hunt more.
>>
>> Kailang, could you check whether anything missing for this codec?
>> The symptom appears like the COEF thingy you fixed by extra
>> init verbs.
>>
>>
>> thanks,
>>
>> Takashi
>>
>> >
>> >
>> >
>> > On Thu, Oct 22, 2015 at 6:15 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> > > On Thu, 22 Oct 2015 10:38:37 +0200,
>> > > George Gugulea wrote:
>> > >>
>> > >> After a fresh reboot, the sound works ok but if I put
>> the computer
>> > >> to sleep (pm-suspend), after it wakes up there is no
>> sound anymore.
>> > >>
>> > >> I did try 'alsa force-reload' after suspend but still no sound.
>> > >> After 'pm-hibernate' sound is back again.
>> > >>
>> > >> I found an old thread here:
>> > >> https://bugzilla.kernel.org/show_bug.cgi?id=49421 where Michael
>> > >> seems to have the same problem which is still unsolved;
>> maybe I can
>> > >> help with more info.
>> > >>
>> > >> I attached the 'alsa-info.sh' output before and after suspend:
>> > >> 'alsa-info.txt.before' and 'alsa-info.txt.after' (as a patch to
>> > >> stay below 80k mail size rule: diff -u alsa-info.txt.before
>> > >> alsa-info.txt.after > alsa-info.txt.patch)
>> > >>
>> > >> The only difference between before and after is this one:
>> > >> @@ -241,7 +241,7 @@
>> > >>  Node 0x11 [Audio Input] wcaps 0x10051b: Stereo Amp-In
>> > >>    Amp-In caps: ofs=0x11, nsteps=0x2e, stepsize=0x03, mute=1
>> > >>    Amp-In vals:  [0x12 0x12]
>> > >> -  Converter: stream=4, channel=0
>> > >> +  Converter: stream=0, channel=0
>> > >>    SDI-Select: 0
>> > >>    PCM:
>> > >>      rates [0x160]: 44100 48000 96000
>> > >>
>> > >>
>> > >> The PC is here:
>> > >> http://www.dell.com/us/p/xps-27-2720-aio/pd?ref=PD_OC,
>> > >> but the 2y older version with no touch
>> > >>
>> > >> If I boot into windows (8.1) everything works great, including
>> > >> sound (even after suspend)
>> > >
>> > > Did you test with 4.3-rc kernel?  3.19 is very old.
>> > >
>> > > It's likely codec-specific stuff, as there is no
>> difference seen in
>> > > alsa-info.sh outputs (the converter is the value assigned
>> > > dynamically at playback, so it doesn't matter at all).
>> > >
>> > >
>> > > Takashi
>> >
>> >
>> >
>> > --
>> > gg
>> > [2 alsa-info.txt.4.3-rc6.before <application/octet-stream (base64)>]
>> >
>> > --- alsa-info.txt.4.3-rc6.before    2015-10-22
>> 23:41:24.265081408 +0300
>> > +++ alsa-info.txt.4.3-rc6.after     2015-10-22
>> 23:46:30.584791012 +0300
>> > @@ -3,7 +3,7 @@
>> >  !!ALSA Information Script v 0.4.64
>> >  !!################################
>> >
>> > -!!Script ran on: Thu Oct 22 20:41:23 UTC 2015
>> > +!!Script ran on: Thu Oct 22 20:46:30 UTC 2015
>> >
>> >
>> >  !!Linux Distribution
>> > @@ -142,26 +142,26 @@
>> >      ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>> >    Device: name="ALC3260 Analog", type="Audio", device=0
>> >    Amp-Out caps: ofs=0x3f, nsteps=0x40, stepsize=0x03, mute=0
>> > -  Amp-Out vals:  [0x25 0x25]
>> > -  Converter: stream=5, channel=0
>> > +  Amp-Out vals:  [0x21 0x21]
>> > +  Converter: stream=0, channel=0
>> >    PCM:
>> >      rates [0x560]: 44100 48000 96000 192000
>> >      bits [0xe]: 16 20 24
>> >      formats [0x1]: PCM
>> >    Power states:  D0 D1 D2 D3 EPSS
>> > -  Power: setting=D0, actual=D0
>> > +  Power: setting=D3, actual=D3
>> >  Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
>> >    Control: name="Speaker Playback Volume", index=0, device=0
>> >      ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>> >    Amp-Out caps: ofs=0x3f, nsteps=0x40, stepsize=0x03, mute=0
>> > -  Amp-Out vals:  [0x25 0x25]
>> > -  Converter: stream=5, channel=0
>> > +  Amp-Out vals:  [0x21 0x21]
>> > +  Converter: stream=0, channel=0
>> >    PCM:
>> >      rates [0x560]: 44100 48000 96000 192000
>> >      bits [0xe]: 16 20 24
>> >      formats [0x1]: PCM
>> >    Power states:  D0 D1 D2 D3 EPSS
>> > -  Power: setting=D0, actual=D0
>> > +  Power: setting=D3, actual=D3
>> >  Node 0x04 [Vendor Defined Widget] wcaps 0xf00000: Mono  Node 0x05
>> > [Vendor Defined Widget] wcaps 0xf00000: Mono  Node 0x06
>> [Audio Output]
>> > wcaps 0x611: Stereo Digital @@ -182,7 +182,7 @@
>> >      ControlAmp: chs=3, dir=In, idx=0, ofs=0
>> >    Device: name="ALC3260 Analog", type="Audio", device=0
>> >    Amp-In caps: ofs=0x11, nsteps=0x2e, stepsize=0x03, mute=1
>> > -  Amp-In vals:  [0x11 0x11]
>> > +  Amp-In vals:  [0x10 0x10]
>> >    Converter: stream=0, channel=0
>> >    SDI-Select: 0
>> >    PCM:
>> > @@ -240,7 +240,7 @@
>> >  Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono  Node 0x11
>> > [Audio Input] wcaps 0x10051b: Stereo Amp-In
>> >    Amp-In caps: ofs=0x11, nsteps=0x2e, stepsize=0x03, mute=1
>> > -  Amp-In vals:  [0x11 0x11]
>> > +  Amp-In vals:  [0x10 0x10]
>> >    Converter: stream=1, channel=0
>> >    SDI-Select: 0
>> >    PCM:
>> > @@ -288,7 +288,7 @@
>> >      Misc = NO_PRESENCE
>> >    Pin-ctls: 0x40: OUT
>> >    Power states:  D0 D1 D2 D3 EPSS
>> > -  Power: setting=D0, actual=D0
>> > +  Power: setting=D3, actual=D3
>> >    Connection: 2
>> >       0x0c 0x0d*
>> >  Node 0x15 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out @@ -531,8
>> > +531,8 @@  crw-rw----+ 1 root audio 116,  2 Oct 22 23:40
>> > /dev/snd/controlC0  crw-rw----+ 1 root audio 116,  6 Oct 22 23:40
>> > /dev/snd/hwC0D0  crw-rw----+ 1 root audio 116,  7 Oct 22 23:40
>> > /dev/snd/hwC0D3
>> > -crw-rw----+ 1 root audio 116,  4 Oct 22 23:40 /dev/snd/pcmC0D0c
>> > -crw-rw----+ 1 root audio 116,  3 Oct 22 23:40 /dev/snd/pcmC0D0p
>> > +crw-rw----+ 1 root audio 116,  4 Oct 22 23:46 /dev/snd/pcmC0D0c
>> > +crw-rw----+ 1 root audio 116,  3 Oct 22 23:45 /dev/snd/pcmC0D0p
>> >  crw-rw----+ 1 root audio 116,  5 Oct 22 23:40 /dev/snd/pcmC0D3p
>> > crw-rw----+ 1 root audio 116,  1 Oct 22 23:40 /dev/snd/seq
>> > crw-rw----+ 1 root audio 116, 33 Oct 22 23:40
>> /dev/snd/timer @@ -578,7
>> > +578,7 @@
>> >    Capabilities: pvolume pvolume-joined pswitch pswitch-joined
>> >    Playback channels: Mono
>> >    Limits: Playback 0 - 64
>> > -  Mono: Playback 38 [59%] [-26.00dB] [on]
>> > +  Mono: Playback 34 [53%] [-30.00dB] [on]
>> >  Simple mixer control 'Headphone',0
>> >    Capabilities: pvolume pswitch
>> >    Playback channels: Front Left - Front Right @@ -598,8 +598,8 @@
>> >    Playback channels: Front Left - Front Right
>> >    Limits: Playback 0 - 255
>> >    Mono:
>> > -  Front Left: Playback 255 [100%] [0.00dB]
>> > -  Front Right: Playback 255 [100%] [0.00dB]
>> > +  Front Left: Playback 253 [99%] [-0.40dB]  Front Right:
>> Playback 253
>> > + [99%] [-0.40dB]
>> >  Simple mixer control 'Mic',0
>> >    Capabilities: pvolume pswitch
>> >    Playback channels: Front Left - Front Right @@ -629,8 +629,8 @@
>> >    Capabilities: cvolume cswitch
>> >    Capture channels: Front Left - Front Right
>> >    Limits: Capture 0 - 46
>> > -  Front Left: Capture 17 [37%] [0.00dB] [on]
>> > -  Front Right: Capture 17 [37%] [0.00dB] [on]
>> > +  Front Left: Capture 16 [35%] [-1.00dB] [on]  Front
>> Right: Capture
>> > + 16 [35%] [-1.00dB] [on]
>> >  Simple mixer control 'Auto-Mute Mode',0
>> >    Capabilities: enum
>> >    Items: 'Disabled' 'Enabled'
>> > @@ -745,8 +745,8 @@
>> >     control.8 {
>> >             iface MIXER
>> >             name 'Capture Volume'
>> > -           value.0 17
>> > -           value.1 17
>> > +           value.0 16
>> > +           value.1 16
>> >             comment {
>> >                     access 'read write'
>> >                     type INTEGER
>> > @@ -754,8 +754,8 @@
>> >                     range '0 - 46'
>> >                     dbmin -1700
>> >                     dbmax 2900
>> > -                   dbvalue.0 0
>> > -                   dbvalue.1 0
>> > +                   dbvalue.0 -100
>> > +                   dbvalue.1 -100
>> >             }
>> >     }
>> >     control.9 {
>> > @@ -804,7 +804,7 @@
>> >     control.12 {
>> >             iface MIXER
>> >             name 'Master Playback Volume'
>> > -           value 38
>> > +           value 34
>> >             comment {
>> >                     access 'read write'
>> >                     type INTEGER
>> > @@ -812,7 +812,7 @@
>> >                     range '0 - 64'
>> >                     dbmin -6400
>> >                     dbmax 0
>> > -                   dbvalue.0 -2600
>> > +                   dbvalue.0 -3000
>> >             }
>> >     }
>> >     control.13 {
>> > @@ -999,8 +999,8 @@
>> >     control.29 {
>> >             iface MIXER
>> >             name 'PCM Playback Volume'
>> > -           value.0 255
>> > -           value.1 255
>> > +           value.0 253
>> > +           value.1 253
>> >             comment {
>> >                     access 'read write user'
>> >                     type INTEGER
>> > @@ -1009,8 +1009,8 @@
>> >                     tlv '0000000100000008ffffec1400000014'
>> >                     dbmin -5100
>> >                     dbmax 0
>> > -                   dbvalue.0 0
>> > -                   dbvalue.1 0
>> > +                   dbvalue.0 -40
>> > +                   dbvalue.1 -40
>> >             }
>> >     }
>> >  }
>> > @@ -1021,6 +1021,8 @@
>> >  !!------------------
>> >
>> >  Module
>> > +alx
>> > +mdio
>> >  cmac
>> >  rfcomm
>> >  bnep
>> > @@ -1131,11 +1133,9 @@
>> >  psmouse
>> >  ahci
>> >  sdhci_pci
>> > -alx
>> >  rtsx_pci
>> >  libahci
>> >  sdhci
>> > -mdio
>> >  floppy
>> >
>> >
>> > _______________________________________________
>> > Alsa-devel mailing list
>> > Alsa-devel@alsa-project.org
>> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>> ------Please consider the environment before printing this e-mail.
>>



-- 
gg

--001a11c25d4e3ceb860522ccbf6b
Content-Type: application/octet-stream;
	name="alsa-info.txt.4.3-rc6.coef1.before"
Content-Disposition: attachment;
	filename="alsa-info.txt.4.3-rc6.coef1.before"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ig473yw80

dXBsb2FkPXRydWUmc2NyaXB0PXRydWUmY2FyZGluZm89CiEhIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMKISFBTFNBIEluZm9ybWF0aW9uIFNjcmlwdCB2IDAuNC42NAohISMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCgohIVNjcmlwdCByYW4gb246IEZyaSBPY3QgMjMgMjE6
Mjg6NTEgVVRDIDIwMTUKCgohIUxpbnV4IERpc3RyaWJ1dGlvbgohIS0tLS0tLS0tLS0tLS0tLS0t
LQoKVWJ1bnR1IDE0LjA0LjMgTFRTIFxuIFxsIERJU1RSSUJfSUQ9VWJ1bnR1IERJU1RSSUJfREVT
Q1JJUFRJT049IlVidW50dSAxNC4wNC4zIExUUyIgTkFNRT0iVWJ1bnR1IiBJRD11YnVudHUgSURf
TElLRT1kZWJpYW4gUFJFVFRZX05BTUU9IlVidW50dSAxNC4wNC4zIExUUyIgSE9NRV9VUkw9Imh0
dHA6Ly93d3cudWJ1bnR1LmNvbS8iIFNVUFBPUlRfVVJMPSJodHRwOi8vaGVscC51YnVudHUuY29t
LyIgQlVHX1JFUE9SVF9VUkw9Imh0dHA6Ly9idWdzLmxhdW5jaHBhZC5uZXQvdWJ1bnR1LyIKCgoh
IURNSSBJbmZvcm1hdGlvbgohIS0tLS0tLS0tLS0tLS0tLQoKTWFudWZhY3R1cmVyOiAgICAgIERl
bGwgSW5jLgpQcm9kdWN0IE5hbWU6ICAgICAgWFBTIE9uZSAyNzEwClByb2R1Y3QgVmVyc2lvbjog
ICAwMApGaXJtd2FyZSBWZXJzaW9uOiAgQTEyCgoKISFLZXJuZWwgSW5mb3JtYXRpb24KISEtLS0t
LS0tLS0tLS0tLS0tLS0KCktlcm5lbCByZWxlYXNlOiAgICA0LjMuMC1yYzYKT3BlcmF0aW5nIFN5
c3RlbTogIEdOVS9MaW51eApBcmNoaXRlY3R1cmU6ICAgICAgeDg2XzY0ClByb2Nlc3NvcjogICAg
ICAgICB4ODZfNjQKU01QIEVuYWJsZWQ6ICAgICAgIFllcwoKCiEhQUxTQSBWZXJzaW9uCiEhLS0t
LS0tLS0tLS0tCgpEcml2ZXIgdmVyc2lvbjogICAgIGs0LjMuMC1yYzYKTGlicmFyeSB2ZXJzaW9u
OiAgICAxLjAuMjcuMgpVdGlsaXRpZXMgdmVyc2lvbjogIDEuMC4yNy4yCgoKISFMb2FkZWQgQUxT
QSBtb2R1bGVzCiEhLS0tLS0tLS0tLS0tLS0tLS0tLQoKc25kX2hkYV9pbnRlbAoKCiEhU291bmQg
U2VydmVycyBvbiB0aGlzIHN5c3RlbQohIS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KClB1
bHNlYXVkaW86CiAgICAgIEluc3RhbGxlZCAtIFllcyAoL3Vzci9iaW4vcHVsc2VhdWRpbykKICAg
ICAgUnVubmluZyAtIFllcwoKCiEhU291bmRjYXJkcyByZWNvZ25pc2VkIGJ5IEFMU0EKISEtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKIDAgW1BDSCAgICAgICAgICAgIF06IEhEQS1JbnRl
bCAtIEhEQSBJbnRlbCBQQ0gKICAgICAgICAgICAgICAgICAgICAgIEhEQSBJbnRlbCBQQ0ggYXQg
MHhmN2MxMDAwMCBpcnEgMzkKCgohIVBDSSBTb3VuZGNhcmRzIGluc3RhbGxlZCBpbiB0aGUgc3lz
dGVtCiEhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCjAwOjFiLjAgQXVk
aW8gZGV2aWNlOiBJbnRlbCBDb3Jwb3JhdGlvbiA3IFNlcmllcy9DMjEwIFNlcmllcyBDaGlwc2V0
IEZhbWlseSBIaWdoIERlZmluaXRpb24gQXVkaW8gQ29udHJvbGxlciAocmV2IDA0KQoKCiEhQWR2
YW5jZWQgaW5mb3JtYXRpb24gLSBQQ0kgVmVuZG9yL0RldmljZS9TdWJzeXN0ZW0gSUQncwohIS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KCjAw
OjFiLjAgMDQwMzogODA4NjoxZTIwIChyZXYgMDQpCglTdWJzeXN0ZW06IDEwMjg6MDU0YgoKCiEh
TW9kcHJvYmUgb3B0aW9ucyAoU291bmQgcmVsYXRlZCkKISEtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQoKc25kX2F0aWl4cF9tb2RlbTogaW5kZXg9LTIKc25kX2ludGVsOHgwbTogaW5k
ZXg9LTIKc25kX3ZpYTgyeHhfbW9kZW06IGluZGV4PS0yCnNuZF91c2JfYXVkaW86IGluZGV4PS0y
CnNuZF91c2JfY2FpYXE6IGluZGV4PS0yCnNuZF91c2JfdWExMDE6IGluZGV4PS0yCnNuZF91c2Jf
dXMxMjJsOiBpbmRleD0tMgpzbmRfdXNiX3VzeDJ5OiBpbmRleD0tMgpzbmRfY21pcGNpOiBtcHVf
cG9ydD0weDMzMCBmbV9wb3J0PTB4Mzg4CnNuZF9wY3NwOiBpbmRleD0tMgpzbmRfdXNiX2F1ZGlv
OiBpbmRleD0tMgoKCiEhTG9hZGVkIHNvdW5kIG1vZHVsZSBvcHRpb25zCiEhLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCgohIU1vZHVsZTogc25kX2hkYV9pbnRlbAoJYWxpZ25fYnVmZmVyX3Np
emUgOiAtMQoJYmRsX3Bvc19hZGogOiAxLC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0x
LC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0xLC0x
LC0xCgliZWVwX21vZGUgOiBOLE4sTixOLE4sTixOLE4sTixOLE4sTixOLE4sTixOLE4sTixOLE4s
TixOLE4sTixOLE4sTixOLE4sTixOLE4KCWVuYWJsZSA6IFksWSxZLFksWSxZLFksWSxZLFksWSxZ
LFksWSxZLFksWSxZLFksWSxZLFksWSxZLFksWSxZLFksWSxZLFksWQoJZW5hYmxlX21zaSA6IC0x
CglpZCA6IChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwo
bnVsbCksKG51bGwpLChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwobnVsbCksKG51bGwpLChu
dWxsKSwobnVsbCksKG51bGwpLChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwobnVsbCksKG51
bGwpLChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwobnVs
bCkKCWluZGV4IDogLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEs
LTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEKCWphY2tw
b2xsX21zIDogMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAs
MCwwLDAsMCwwLDAsMCwwCgltb2RlbCA6IChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwobnVs
bCksKG51bGwpLChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwobnVsbCksKG51bGwpLChudWxs
KSwobnVsbCksKG51bGwpLChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwobnVsbCksKG51bGwp
LChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwobnVsbCks
KG51bGwpLChudWxsKSwobnVsbCkKCXBhdGNoIDogKG51bGwpLChudWxsKSwobnVsbCksKG51bGwp
LChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwobnVsbCks
KG51bGwpLChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwo
bnVsbCksKG51bGwpLChudWxsKSwobnVsbCksKG51bGwpLChudWxsKSwobnVsbCksKG51bGwpLChu
dWxsKSwobnVsbCksKG51bGwpLChudWxsKQoJcG9zaXRpb25fZml4IDogLTEsLTEsLTEsLTEsLTEs
LTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEs
LTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEKCXBvd2VyX3NhdmUgOiAwCglwb3dlcl9zYXZlX2NvbnRy
b2xsZXIgOiBZCglwcm9iZV9tYXNrIDogLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEs
LTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEsLTEs
LTEsLTEKCXByb2JlX29ubHkgOiAwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAsMCww
LDAsMCwwLDAsMCwwLDAsMCwwLDAsMCwwLDAKCXNpbmdsZV9jbWQgOiBOCglzbm9vcCA6IC0xCgoK
ISFIREEtSW50ZWwgQ29kZWMgaW5mb3JtYXRpb24KISEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KLS1zdGFydGNvbGxhcHNlLS0KCkNvZGVjOiBSZWFsdGVrIEFMQzMyNjAKQWRkcmVzczogMApB
RkcgRnVuY3Rpb24gSWQ6IDB4MSAodW5zb2wgMSkKVmVuZG9yIElkOiAweDEwZWMwMjc1ClN1YnN5
c3RlbSBJZDogMHgxMDI4MDU0YgpSZXZpc2lvbiBJZDogMHgxMDAwMDgKTm8gTW9kZW0gRnVuY3Rp
b24gR3JvdXAgZm91bmQKRGVmYXVsdCBQQ006CiAgICByYXRlcyBbMHg1ZjBdOiAzMjAwMCA0NDEw
MCA0ODAwMCA4ODIwMCA5NjAwMCAxOTIwMDAKICAgIGJpdHMgWzB4ZV06IDE2IDIwIDI0CiAgICBm
b3JtYXRzIFsweDFdOiBQQ00KRGVmYXVsdCBBbXAtSW4gY2FwczogTi9BCkRlZmF1bHQgQW1wLU91
dCBjYXBzOiBOL0EKU3RhdGUgb2YgQUZHIG5vZGUgMHgwMToKICBQb3dlciBzdGF0ZXM6ICBEMCBE
MSBEMiBEMyBDTEtTVE9QIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQwCkdQSU86
IGlvPTQsIG89MCwgaT0wLCB1bnNvbGljaXRlZD0xLCB3YWtlPTEKICBJT1swXTogZW5hYmxlPTAs
IGRpcj0wLCB3YWtlPTAsIHN0aWNreT0wLCBkYXRhPTAsIHVuc29sPTAKICBJT1sxXTogZW5hYmxl
PTAsIGRpcj0wLCB3YWtlPTAsIHN0aWNreT0wLCBkYXRhPTAsIHVuc29sPTAKICBJT1syXTogZW5h
YmxlPTAsIGRpcj0wLCB3YWtlPTAsIHN0aWNreT0wLCBkYXRhPTAsIHVuc29sPTAKICBJT1szXTog
ZW5hYmxlPTAsIGRpcj0wLCB3YWtlPTAsIHN0aWNreT0wLCBkYXRhPTAsIHVuc29sPTAKTm9kZSAw
eDAyIFtBdWRpbyBPdXRwdXRdIHdjYXBzIDB4NDFkOiBTdGVyZW8gQW1wLU91dAogIENvbnRyb2w6
IG5hbWU9IkhlYWRwaG9uZSBQbGF5YmFjayBWb2x1bWUiLCBpbmRleD0wLCBkZXZpY2U9MAogICAg
Q29udHJvbEFtcDogY2hzPTMsIGRpcj1PdXQsIGlkeD0wLCBvZnM9MAogIERldmljZTogbmFtZT0i
QUxDMzI2MCBBbmFsb2ciLCB0eXBlPSJBdWRpbyIsIGRldmljZT0wCiAgQW1wLU91dCBjYXBzOiBv
ZnM9MHgzZiwgbnN0ZXBzPTB4NDAsIHN0ZXBzaXplPTB4MDMsIG11dGU9MAogIEFtcC1PdXQgdmFs
czogIFsweDJkIDB4MmRdCiAgQ29udmVydGVyOiBzdHJlYW09NSwgY2hhbm5lbD0wCiAgUENNOgog
ICAgcmF0ZXMgWzB4NTYwXTogNDQxMDAgNDgwMDAgOTYwMDAgMTkyMDAwCiAgICBiaXRzIFsweGVd
OiAxNiAyMCAyNAogICAgZm9ybWF0cyBbMHgxXTogUENNCiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEg
RDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAKTm9kZSAweDAzIFtBdWRp
byBPdXRwdXRdIHdjYXBzIDB4NDFkOiBTdGVyZW8gQW1wLU91dAogIENvbnRyb2w6IG5hbWU9IlNw
ZWFrZXIgUGxheWJhY2sgVm9sdW1lIiwgaW5kZXg9MCwgZGV2aWNlPTAKICAgIENvbnRyb2xBbXA6
IGNocz0zLCBkaXI9T3V0LCBpZHg9MCwgb2ZzPTAKICBBbXAtT3V0IGNhcHM6IG9mcz0weDNmLCBu
c3RlcHM9MHg0MCwgc3RlcHNpemU9MHgwMywgbXV0ZT0wCiAgQW1wLU91dCB2YWxzOiAgWzB4MmQg
MHgyZF0KICBDb252ZXJ0ZXI6IHN0cmVhbT01LCBjaGFubmVsPTAKICBQQ006CiAgICByYXRlcyBb
MHg1NjBdOiA0NDEwMCA0ODAwMCA5NjAwMCAxOTIwMDAKICAgIGJpdHMgWzB4ZV06IDE2IDIwIDI0
CiAgICBmb3JtYXRzIFsweDFdOiBQQ00KICBQb3dlciBzdGF0ZXM6ICBEMCBEMSBEMiBEMyBFUFNT
CiAgUG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1EMApOb2RlIDB4MDQgW1ZlbmRvciBEZWZpbmVk
IFdpZGdldF0gd2NhcHMgMHhmMDAwMDA6IE1vbm8KTm9kZSAweDA1IFtWZW5kb3IgRGVmaW5lZCBX
aWRnZXRdIHdjYXBzIDB4ZjAwMDAwOiBNb25vCk5vZGUgMHgwNiBbQXVkaW8gT3V0cHV0XSB3Y2Fw
cyAweDYxMTogU3RlcmVvIERpZ2l0YWwKICBDb252ZXJ0ZXI6IHN0cmVhbT0wLCBjaGFubmVsPTAK
ICBEaWdpdGFsOgogIERpZ2l0YWwgY2F0ZWdvcnk6IDB4MAogIElFQyBDb2RpbmcgVHlwZTogMHgw
CiAgUENNOgogICAgcmF0ZXMgWzB4NWYwXTogMzIwMDAgNDQxMDAgNDgwMDAgODgyMDAgOTYwMDAg
MTkyMDAwCiAgICBiaXRzIFsweGVdOiAxNiAyMCAyNAogICAgZm9ybWF0cyBbMHgxXTogUENNCiAg
UG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5nPUQzLCBhY3R1
YWw9RDMKTm9kZSAweDA3IFtBdWRpbyBJbnB1dF0gd2NhcHMgMHgxMDA1MWI6IFN0ZXJlbyBBbXAt
SW4KICBDb250cm9sOiBuYW1lPSJDYXB0dXJlIFZvbHVtZSIsIGluZGV4PTAsIGRldmljZT0wCiAg
ICBDb250cm9sQW1wOiBjaHM9MywgZGlyPUluLCBpZHg9MCwgb2ZzPTAKICBDb250cm9sOiBuYW1l
PSJDYXB0dXJlIFN3aXRjaCIsIGluZGV4PTAsIGRldmljZT0wCiAgICBDb250cm9sQW1wOiBjaHM9
MywgZGlyPUluLCBpZHg9MCwgb2ZzPTAKICBEZXZpY2U6IG5hbWU9IkFMQzMyNjAgQW5hbG9nIiwg
dHlwZT0iQXVkaW8iLCBkZXZpY2U9MAogIEFtcC1JbiBjYXBzOiBvZnM9MHgxMSwgbnN0ZXBzPTB4
MmUsIHN0ZXBzaXplPTB4MDMsIG11dGU9MQogIEFtcC1JbiB2YWxzOiAgWzB4MTEgMHgxMV0KICBD
b252ZXJ0ZXI6IHN0cmVhbT0wLCBjaGFubmVsPTAKICBTREktU2VsZWN0OiAwCiAgUENNOgogICAg
cmF0ZXMgWzB4MTYwXTogNDQxMDAgNDgwMDAgOTYwMDAKICAgIGJpdHMgWzB4ZV06IDE2IDIwIDI0
CiAgICBmb3JtYXRzIFsweDFdOiBQQ00KICBQb3dlciBzdGF0ZXM6ICBEMCBEMSBEMiBEMyBFUFNT
CiAgUG93ZXI6IHNldHRpbmc9RDMsIGFjdHVhbD1EMwogIENvbm5lY3Rpb246IDEKICAgICAweDI0
Ck5vZGUgMHgwOCBbQXVkaW8gSW5wdXRdIHdjYXBzIDB4MTAwNTFiOiBTdGVyZW8gQW1wLUluCiAg
QW1wLUluIGNhcHM6IG9mcz0weDExLCBuc3RlcHM9MHgyZSwgc3RlcHNpemU9MHgwMywgbXV0ZT0x
CiAgQW1wLUluIHZhbHM6ICBbMHg5MCAweDkwXQogIENvbnZlcnRlcjogc3RyZWFtPTAsIGNoYW5u
ZWw9MAogIFNESS1TZWxlY3Q6IDAKICBQQ006CiAgICByYXRlcyBbMHgxNjBdOiA0NDEwMCA0ODAw
MCA5NjAwMAogICAgYml0cyBbMHhlXTogMTYgMjAgMjQKICAgIGZvcm1hdHMgWzB4MV06IFBDTQog
IFBvd2VyIHN0YXRlczogIEQwIEQxIEQyIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMywgYWN0
dWFsPUQzCiAgQ29ubmVjdGlvbjogMQogICAgIDB4MjMKTm9kZSAweDA5IFtWZW5kb3IgRGVmaW5l
ZCBXaWRnZXRdIHdjYXBzIDB4ZjAwMDAwOiBNb25vCk5vZGUgMHgwYSBbVmVuZG9yIERlZmluZWQg
V2lkZ2V0XSB3Y2FwcyAweGYwMDAwMDogTW9ubwpOb2RlIDB4MGIgW0F1ZGlvIE1peGVyXSB3Y2Fw
cyAweDIwMDEwYjogU3RlcmVvIEFtcC1JbgogIENvbnRyb2w6IG5hbWU9Ik1pYyBQbGF5YmFjayBW
b2x1bWUiLCBpbmRleD0wLCBkZXZpY2U9MAogICAgQ29udHJvbEFtcDogY2hzPTMsIGRpcj1Jbiwg
aWR4PTAsIG9mcz0wCiAgQ29udHJvbDogbmFtZT0iTWljIFBsYXliYWNrIFN3aXRjaCIsIGluZGV4
PTAsIGRldmljZT0wCiAgICBDb250cm9sQW1wOiBjaHM9MywgZGlyPUluLCBpZHg9MCwgb2ZzPTAK
ICBDb250cm9sOiBuYW1lPSJCZWVwIFBsYXliYWNrIFZvbHVtZSIsIGluZGV4PTAsIGRldmljZT0w
CiAgICBDb250cm9sQW1wOiBjaHM9MywgZGlyPUluLCBpZHg9NCwgb2ZzPTAKICBDb250cm9sOiBu
YW1lPSJCZWVwIFBsYXliYWNrIFN3aXRjaCIsIGluZGV4PTAsIGRldmljZT0wCiAgICBDb250cm9s
QW1wOiBjaHM9MywgZGlyPUluLCBpZHg9NCwgb2ZzPTAKICBBbXAtSW4gY2Fwczogb2ZzPTB4MTcs
IG5zdGVwcz0weDFmLCBzdGVwc2l6ZT0weDA1LCBtdXRlPTEKICBBbXAtSW4gdmFsczogIFsweDgw
IDB4ODBdIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdIFsweDgxIDB4ODBdCiAg
Q29ubmVjdGlvbjogNQogICAgIDB4MTggMHgxOSAweDFhIDB4MWIgMHgxZApOb2RlIDB4MGMgW0F1
ZGlvIE1peGVyXSB3Y2FwcyAweDIwMDEwYjogU3RlcmVvIEFtcC1JbgogIEFtcC1JbiBjYXBzOiBv
ZnM9MHgwMCwgbnN0ZXBzPTB4MDAsIHN0ZXBzaXplPTB4MDAsIG11dGU9MQogIEFtcC1JbiB2YWxz
OiAgWzB4MDAgMHgwMF0gWzB4MDAgMHgwMF0KICBDb25uZWN0aW9uOiAyCiAgICAgMHgwMiAweDBi
Ck5vZGUgMHgwZCBbQXVkaW8gTWl4ZXJdIHdjYXBzIDB4MjAwMTBiOiBTdGVyZW8gQW1wLUluCiAg
QW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNpemU9MHgwMCwgbXV0ZT0x
CiAgQW1wLUluIHZhbHM6ICBbMHgwMCAweDAwXSBbMHgwMCAweDAwXQogIENvbm5lY3Rpb246IDIK
ICAgICAweDAzIDB4MGIKTm9kZSAweDBlIFtBdWRpbyBNaXhlcl0gd2NhcHMgMHgyMDAxMGE6IE1v
bm8gQW1wLUluCiAgQW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNpemU9
MHgwMCwgbXV0ZT0xCiAgQW1wLUluIHZhbHM6ICBbMHgwMF0gWzB4ODBdCiAgQ29ubmVjdGlvbjog
MgogICAgIDB4MGMgMHgwZApOb2RlIDB4MGYgW1ZlbmRvciBEZWZpbmVkIFdpZGdldF0gd2NhcHMg
MHhmMDAwMDA6IE1vbm8KTm9kZSAweDEwIFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBzIDB4
ZjAwMDAwOiBNb25vCk5vZGUgMHgxMSBbQXVkaW8gSW5wdXRdIHdjYXBzIDB4MTAwNTFiOiBTdGVy
ZW8gQW1wLUluCiAgQW1wLUluIGNhcHM6IG9mcz0weDExLCBuc3RlcHM9MHgyZSwgc3RlcHNpemU9
MHgwMywgbXV0ZT0xCiAgQW1wLUluIHZhbHM6ICBbMHgxMSAweDExXQogIENvbnZlcnRlcjogc3Ry
ZWFtPTEsIGNoYW5uZWw9MAogIFNESS1TZWxlY3Q6IDAKICBQQ006CiAgICByYXRlcyBbMHgxNjBd
OiA0NDEwMCA0ODAwMCA5NjAwMAogICAgYml0cyBbMHhlXTogMTYgMjAgMjQKICAgIGZvcm1hdHMg
WzB4MV06IFBDTQogIFBvd2VyIHN0YXRlczogIEQwIEQxIEQyIEQzIEVQU1MKICBQb3dlcjogc2V0
dGluZz1EMCwgYWN0dWFsPUQwCiAgQ29ubmVjdGlvbjogMQogICAgIDB4MjIKTm9kZSAweDEyIFtQ
aW4gQ29tcGxleF0gd2NhcHMgMHg0MDA0MGI6IFN0ZXJlbyBBbXAtSW4KICBDb250cm9sOiBuYW1l
PSJJbnRlcm5hbCBNaWMgQm9vc3QgVm9sdW1lIiwgaW5kZXg9MCwgZGV2aWNlPTAKICAgIENvbnRy
b2xBbXA6IGNocz0zLCBkaXI9SW4sIGlkeD0wLCBvZnM9MAogIEFtcC1JbiBjYXBzOiBvZnM9MHgw
MCwgbnN0ZXBzPTB4MDMsIHN0ZXBzaXplPTB4MjcsIG11dGU9MAogIEFtcC1JbiB2YWxzOiAgWzB4
MDIgMHgwMl0KICBQaW5jYXAgMHgwMDAwMDAyMDogSU4KICBQaW4gRGVmYXVsdCAweDk5YTMwOTMw
OiBbRml4ZWRdIE1pYyBhdCBJbnQgQVRBUEkKICAgIENvbm4gPSBBVEFQSSwgQ29sb3IgPSBVbmtu
b3duCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4MywgU2VxdWVuY2UgPSAweDAKICAgIE1pc2MgPSBO
T19QUkVTRU5DRQogIFBpbi1jdGxzOiAweDIwOiBJTgogIFBvd2VyIHN0YXRlczogIEQwIEQxIEQy
IEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQwCk5vZGUgMHgxMyBbUGluIENv
bXBsZXhdIHdjYXBzIDB4NDAwNDBiOiBTdGVyZW8gQW1wLUluCiAgQW1wLUluIGNhcHM6IG9mcz0w
eDAwLCBuc3RlcHM9MHgwMywgc3RlcHNpemU9MHgyNywgbXV0ZT0wCiAgQW1wLUluIHZhbHM6ICBb
MHgwMCAweDAwXQogIFBpbmNhcCAweDAwMDAwMDIwOiBJTgogIFBpbiBEZWZhdWx0IDB4NDExMTEx
ZjA6IFtOL0FdIFNwZWFrZXIgYXQgRXh0IFJlYXIKICAgIENvbm4gPSAxLzgsIENvbG9yID0gQmxh
Y2sKICAgIERlZkFzc29jaWF0aW9uID0gMHhmLCBTZXF1ZW5jZSA9IDB4MAogICAgTWlzYyA9IE5P
X1BSRVNFTkNFCiAgUGluLWN0bHM6IDB4MDA6CiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMg
RVBTUwogIFBvd2VyOiBzZXR0aW5nPUQzLCBhY3R1YWw9RDMKTm9kZSAweDE0IFtQaW4gQ29tcGxl
eF0gd2NhcHMgMHg0MDA1MGQ6IFN0ZXJlbyBBbXAtT3V0CiAgQ29udHJvbDogbmFtZT0iU3BlYWtl
ciBQbGF5YmFjayBTd2l0Y2giLCBpbmRleD0wLCBkZXZpY2U9MAogICAgQ29udHJvbEFtcDogY2hz
PTMsIGRpcj1PdXQsIGlkeD0wLCBvZnM9MAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MDAsIG5zdGVw
cz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtT3V0IHZhbHM6ICBbMHgwMCAweDAw
XQogIFBpbmNhcCAweDAwMDEwMDUwOiBPVVQgRUFQRCBCYWxhbmNlZAogIEVBUEQgMHgyOiBFQVBE
CiAgUGluIERlZmF1bHQgMHg5MDE3MDExMDogW0ZpeGVkXSBTcGVha2VyIGF0IEludCBOL0EKICAg
IENvbm4gPSBBbmFsb2csIENvbG9yID0gVW5rbm93bgogICAgRGVmQXNzb2NpYXRpb24gPSAweDEs
IFNlcXVlbmNlID0gMHgwCiAgICBNaXNjID0gTk9fUFJFU0VOQ0UKICBQaW4tY3RsczogMHg0MDog
T1VUCiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5nPUQw
LCBhY3R1YWw9RDAKICBDb25uZWN0aW9uOiAyCiAgICAgMHgwYyAweDBkKgpOb2RlIDB4MTUgW1Bp
biBDb21wbGV4XSB3Y2FwcyAweDQwMDU4ZDogU3RlcmVvIEFtcC1PdXQKICBDb250cm9sOiBuYW1l
PSJIZWFkcGhvbmUgUGxheWJhY2sgU3dpdGNoIiwgaW5kZXg9MCwgZGV2aWNlPTAKICAgIENvbnRy
b2xBbXA6IGNocz0zLCBkaXI9T3V0LCBpZHg9MCwgb2ZzPTAKICBBbXAtT3V0IGNhcHM6IG9mcz0w
eDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNpemU9MHgwMCwgbXV0ZT0xCiAgQW1wLU91dCB2YWxzOiAg
WzB4MDAgMHgwMF0KICBQaW5jYXAgMHgwMDAxMDAxYzogT1VUIEhQIEVBUEQgRGV0ZWN0CiAgRUFQ
RCAweDI6IEVBUEQKICBQaW4gRGVmYXVsdCAweDAzMjE0NDFmOiBbSmFja10gSFAgT3V0IGF0IEV4
dCBMZWZ0CiAgICBDb25uID0gMS84LCBDb2xvciA9IEdyZWVuCiAgICBEZWZBc3NvY2lhdGlvbiA9
IDB4MSwgU2VxdWVuY2UgPSAweGYKICBQaW4tY3RsczogMHhjMDogT1VUIEhQCiAgVW5zb2xpY2l0
ZWQ6IHRhZz0wMSwgZW5hYmxlZD0xCiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUwog
IFBvd2VyOiBzZXR0aW5nPUQzLCBhY3R1YWw9RDMKICBDb25uZWN0aW9uOiAyCiAgICAgMHgwYyog
MHgwZApOb2RlIDB4MTYgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDUwYzogTW9ubyBBbXAtT3V0
CiAgQW1wLU91dCBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDAsIHN0ZXBzaXplPTB4MDAsIG11
dGU9MQogIEFtcC1PdXQgdmFsczogIFsweDgwXQogIFBpbmNhcCAweDAwMDAwMDEwOiBPVVQKICBQ
aW4gRGVmYXVsdCAweDQxMTExMWYwOiBbTi9BXSBTcGVha2VyIGF0IEV4dCBSZWFyCiAgICBDb25u
ID0gMS84LCBDb2xvciA9IEJsYWNrCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4ZiwgU2VxdWVuY2Ug
PSAweDAKICAgIE1pc2MgPSBOT19QUkVTRU5DRQogIFBpbi1jdGxzOiAweDAwOgogIFBvd2VyIHN0
YXRlczogIEQwIEQxIEQyIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMywgYWN0dWFsPUQzCiAg
Q29ubmVjdGlvbjogMQogICAgIDB4MGUKTm9kZSAweDE3IFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRd
IHdjYXBzIDB4ZjAwMDAwOiBNb25vCk5vZGUgMHgxOCBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAw
NThmOiBTdGVyZW8gQW1wLUluIEFtcC1PdXQKICBDb250cm9sOiBuYW1lPSJNaWMgQm9vc3QgVm9s
dW1lIiwgaW5kZXg9MCwgZGV2aWNlPTAKICAgIENvbnRyb2xBbXA6IGNocz0zLCBkaXI9SW4sIGlk
eD0wLCBvZnM9MAogIEFtcC1JbiBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDMsIHN0ZXBzaXpl
PTB4MjcsIG11dGU9MAogIEFtcC1JbiB2YWxzOiAgWzB4MDAgMHgwMF0KICBBbXAtT3V0IGNhcHM6
IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNpemU9MHgwMCwgbXV0ZT0xCiAgQW1wLU91dCB2
YWxzOiAgWzB4ODAgMHg4MF0KICBQaW5jYXAgMHgwMDAwMzczNDogSU4gT1VUIERldGVjdAogICAg
VnJlZiBjYXBzOiBISVogNTAgR1JEIDgwIDEwMAogIFBpbiBEZWZhdWx0IDB4MDNhMTk4MjA6IFtK
YWNrXSBNaWMgYXQgRXh0IExlZnQKICAgIENvbm4gPSAxLzgsIENvbG9yID0gUGluawogICAgRGVm
QXNzb2NpYXRpb24gPSAweDIsIFNlcXVlbmNlID0gMHgwCiAgUGluLWN0bHM6IDB4MjQ6IElOIFZS
RUZfODAKICBVbnNvbGljaXRlZDogdGFnPTAyLCBlbmFibGVkPTEKICBQb3dlciBzdGF0ZXM6ICBE
MCBEMSBEMiBEMyBFUFNTCiAgUG93ZXI6IHNldHRpbmc9RDMsIGFjdHVhbD1EMwogIENvbm5lY3Rp
b246IDIKICAgICAweDBjKiAweDBkCk5vZGUgMHgxOSBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDAw
NThmOiBTdGVyZW8gQW1wLUluIEFtcC1PdXQKICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVw
cz0weDAzLCBzdGVwc2l6ZT0weDI3LCBtdXRlPTAKICBBbXAtSW4gdmFsczogIFsweDAwIDB4MDBd
CiAgQW1wLU91dCBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDAsIHN0ZXBzaXplPTB4MDAsIG11
dGU9MQogIEFtcC1PdXQgdmFsczogIFsweDgwIDB4ODBdCiAgUGluY2FwIDB4MDAwMDM3MzQ6IElO
IE9VVCBEZXRlY3QKICAgIFZyZWYgY2FwczogSElaIDUwIEdSRCA4MCAxMDAKICBQaW4gRGVmYXVs
dCAweDQxMTExMWYwOiBbTi9BXSBTcGVha2VyIGF0IEV4dCBSZWFyCiAgICBDb25uID0gMS84LCBD
b2xvciA9IEJsYWNrCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4ZiwgU2VxdWVuY2UgPSAweDAKICAg
IE1pc2MgPSBOT19QUkVTRU5DRQogIFBpbi1jdGxzOiAweDIwOiBJTiBWUkVGX0hJWgogIFVuc29s
aWNpdGVkOiB0YWc9MDAsIGVuYWJsZWQ9MAogIFBvd2VyIHN0YXRlczogIEQwIEQxIEQyIEQzIEVQ
U1MKICBQb3dlcjogc2V0dGluZz1EMywgYWN0dWFsPUQzCiAgQ29ubmVjdGlvbjogMgogICAgIDB4
MGMqIDB4MGQKTm9kZSAweDFhIFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0MDA1OGY6IFN0ZXJlbyBB
bXAtSW4gQW1wLU91dAogIEFtcC1JbiBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDMsIHN0ZXBz
aXplPTB4MjcsIG11dGU9MAogIEFtcC1JbiB2YWxzOiAgWzB4MDAgMHgwMF0KICBBbXAtT3V0IGNh
cHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3RlcHNpemU9MHgwMCwgbXV0ZT0xCiAgQW1wLU91
dCB2YWxzOiAgWzB4ODAgMHg4MF0KICBQaW5jYXAgMHgwMDAwMzczYzogSU4gT1VUIEhQIERldGVj
dAogICAgVnJlZiBjYXBzOiBISVogNTAgR1JEIDgwIDEwMAogIFBpbiBEZWZhdWx0IDB4NDExMTEx
ZjA6IFtOL0FdIFNwZWFrZXIgYXQgRXh0IFJlYXIKICAgIENvbm4gPSAxLzgsIENvbG9yID0gQmxh
Y2sKICAgIERlZkFzc29jaWF0aW9uID0gMHhmLCBTZXF1ZW5jZSA9IDB4MAogICAgTWlzYyA9IE5P
X1BSRVNFTkNFCiAgUGluLWN0bHM6IDB4MjA6IElOIFZSRUZfSElaCiAgVW5zb2xpY2l0ZWQ6IHRh
Zz0wMCwgZW5hYmxlZD0wCiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUwogIFBvd2Vy
OiBzZXR0aW5nPUQzLCBhY3R1YWw9RDMKICBDb25uZWN0aW9uOiAyCiAgICAgMHgwYyogMHgwZApO
b2RlIDB4MWIgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDU4ZjogU3RlcmVvIEFtcC1JbiBBbXAt
T3V0CiAgQW1wLUluIGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMywgc3RlcHNpemU9MHgyNywg
bXV0ZT0wCiAgQW1wLUluIHZhbHM6ICBbMHgwMCAweDAwXQogIEFtcC1PdXQgY2Fwczogb2ZzPTB4
MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtT3V0IHZhbHM6ICBb
MHg4MCAweDgwXQogIFBpbmNhcCAweDAwMDAzNzM0OiBJTiBPVVQgRGV0ZWN0CiAgICBWcmVmIGNh
cHM6IEhJWiA1MCBHUkQgODAgMTAwCiAgUGluIERlZmF1bHQgMHg0MTExMTFmMDogW04vQV0gU3Bl
YWtlciBhdCBFeHQgUmVhcgogICAgQ29ubiA9IDEvOCwgQ29sb3IgPSBCbGFjawogICAgRGVmQXNz
b2NpYXRpb24gPSAweGYsIFNlcXVlbmNlID0gMHgwCiAgICBNaXNjID0gTk9fUFJFU0VOQ0UKICBQ
aW4tY3RsczogMHgyMDogSU4gVlJFRl9ISVoKICBVbnNvbGljaXRlZDogdGFnPTAwLCBlbmFibGVk
PTAKICBQb3dlciBzdGF0ZXM6ICBEMCBEMSBEMiBEMyBFUFNTCiAgUG93ZXI6IHNldHRpbmc9RDMs
IGFjdHVhbD1EMwogIENvbm5lY3Rpb246IDIKICAgICAweDBjKiAweDBkCk5vZGUgMHgxYyBbVmVu
ZG9yIERlZmluZWQgV2lkZ2V0XSB3Y2FwcyAweGYwMDAwMDogTW9ubwpOb2RlIDB4MWQgW1BpbiBD
b21wbGV4XSB3Y2FwcyAweDQwMDQwMDogTW9ubwogIFBpbmNhcCAweDAwMDAwMDIwOiBJTgogIFBp
biBEZWZhdWx0IDB4NDAxNjg2MmQ6IFtOL0FdIFNwZWFrZXIgYXQgRXh0IE4vQQogICAgQ29ubiA9
IERpZ2l0YWwsIENvbG9yID0gUHVycGxlCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4MiwgU2VxdWVu
Y2UgPSAweGQKICBQaW4tY3RsczogMHgyMDogSU4KICBQb3dlciBzdGF0ZXM6ICBEMCBEMSBEMiBE
MyBFUFNTCiAgUG93ZXI6IHNldHRpbmc9RDMsIGFjdHVhbD1EMwpOb2RlIDB4MWUgW1BpbiBDb21w
bGV4XSB3Y2FwcyAweDQwMDcwMTogU3RlcmVvIERpZ2l0YWwKICBQaW5jYXAgMHgwMDAwMDAxMDog
T1VUCiAgUGluIERlZmF1bHQgMHg0MTExMTFmMDogW04vQV0gU3BlYWtlciBhdCBFeHQgUmVhcgog
ICAgQ29ubiA9IDEvOCwgQ29sb3IgPSBCbGFjawogICAgRGVmQXNzb2NpYXRpb24gPSAweGYsIFNl
cXVlbmNlID0gMHgwCiAgICBNaXNjID0gTk9fUFJFU0VOQ0UKICBQaW4tY3RsczogMHg0MDogT1VU
CiAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUwogIFBvd2VyOiBzZXR0aW5nPUQzLCBh
Y3R1YWw9RDMKICBDb25uZWN0aW9uOiAxCiAgICAgMHgwNgpOb2RlIDB4MWYgW1ZlbmRvciBEZWZp
bmVkIFdpZGdldF0gd2NhcHMgMHhmMDAwMDA6IE1vbm8KTm9kZSAweDIwIFtWZW5kb3IgRGVmaW5l
ZCBXaWRnZXRdIHdjYXBzIDB4ZjAwMDQwOiBNb25vCiAgUHJvY2Vzc2luZyBjYXBzOiBiZW5pZ249
MCwgbmNvZWZmPTY0CiAgICBDb2VmZiAweDAwOiAweDgwMDkKICAgIENvZWZmIDB4MDE6IDB4Yzk2
MQogICAgQ29lZmYgMHgwMjogMHg4ZWFjCiAgICBDb2VmZiAweDAzOiAweDQ4MDIKICAgIENvZWZm
IDB4MDQ6IDB4MTAxMgogICAgQ29lZmYgMHgwNTogMHhjY2NjCiAgICBDb2VmZiAweDA2OiAweGNj
Y2MKICAgIENvZWZmIDB4MDc6IDB4MzA2NAogICAgQ29lZmYgMHgwODogMHgwN2MwCiAgICBDb2Vm
ZiAweDA5OiAweDAwMDAKICAgIENvZWZmIDB4MGE6IDB4MDAyMAogICAgQ29lZmYgMHgwYjogMHhl
ZjE5CiAgICBDb2VmZiAweDBjOiAweDU5NjQKICAgIENvZWZmIDB4MGQ6IDB4OTQwMAogICAgQ29l
ZmYgMHgwZTogMHgwMDAxCiAgICBDb2VmZiAweDBmOiAweDMzMDMKICAgIENvZWZmIDB4MTA6IDB4
NDAwMAogICAgQ29lZmYgMHgxMTogMHgwMDAwCiAgICBDb2VmZiAweDEyOiAweDAwMDAKICAgIENv
ZWZmIDB4MTM6IDB4MDAwMAogICAgQ29lZmYgMHgxNDogMHgwMDAwCiAgICBDb2VmZiAweDE1OiAw
eDAwMDAKICAgIENvZWZmIDB4MTY6IDB4MDAwMAogICAgQ29lZmYgMHgxNzogMHgwMDAwCiAgICBD
b2VmZiAweDE4OiAweDAwMDAKICAgIENvZWZmIDB4MTk6IDB4MDAwMAogICAgQ29lZmYgMHgxYTog
MHgwMDAwCiAgICBDb2VmZiAweDFiOiAweDAwMDAKICAgIENvZWZmIDB4MWM6IDB4MDAwMAogICAg
Q29lZmYgMHgxZDogMHgwMDAwCiAgICBDb2VmZiAweDFlOiAweDA4MDMKICAgIENvZWZmIDB4MWY6
IDB4MDBjMAogICAgQ29lZmYgMHgyMDogMHgyMDIwCiAgICBDb2VmZiAweDIxOiAweDg4NDAKICAg
IENvZWZmIDB4MjI6IDB4MDgwMAogICAgQ29lZmYgMHgyMzogMHg3ZmZmCiAgICBDb2VmZiAweDI0
OiAweDAzOTAKICAgIENvZWZmIDB4MjU6IDB4MDAwMQogICAgQ29lZmYgMHgyNjogMHgxMjZiCiAg
ICBDb2VmZiAweDI3OiAweDA0MDAKICAgIENvZWZmIDB4Mjg6IDB4MDBhZgogICAgQ29lZmYgMHgy
OTogMHgwMDAwCiAgICBDb2VmZiAweDJhOiAweDAwYWYKICAgIENvZWZmIDB4MmI6IDB4MDBhZgog
ICAgQ29lZmYgMHgyYzogMHhkMDAwCiAgICBDb2VmZiAweDJkOiAweDAwMDAKICAgIENvZWZmIDB4
MmU6IDB4MDAwMAogICAgQ29lZmYgMHgyZjogMHgzMDAwCiAgICBDb2VmZiAweDMwOiAweDAwYjEK
ICAgIENvZWZmIDB4MzE6IDB4MDAwMAogICAgQ29lZmYgMHgzMjogMHgwMDAwCiAgICBDb2VmZiAw
eDMzOiAweDAwMDAKICAgIENvZWZmIDB4MzQ6IDB4YzA0MAogICAgQ29lZmYgMHgzNTogMHgwMGRk
CiAgICBDb2VmZiAweDM2OiAweGMyMDIKICAgIENvZWZmIDB4Mzc6IDB4MDAwMAogICAgQ29lZmYg
MHgzODogMHgwMDAwCiAgICBDb2VmZiAweDM5OiAweDAwMDAKICAgIENvZWZmIDB4M2E6IDB4MDAw
MAogICAgQ29lZmYgMHgzYjogMHgwMTAwCiAgICBDb2VmZiAweDNjOiAweDAwYWMKICAgIENvZWZm
IDB4M2Q6IDB4MDAwMAogICAgQ29lZmYgMHgzZTogMHgwMDAwCiAgICBDb2VmZiAweDNmOiAweGZm
MDAKTm9kZSAweDIxIFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBzIDB4ZjAwMDAwOiBNb25v
Ck5vZGUgMHgyMiBbQXVkaW8gU2VsZWN0b3JdIHdjYXBzIDB4MzAwMTAxOiBTdGVyZW8KICBDb25u
ZWN0aW9uOiAyCiAgICAgMHgxMiogMHgxMwpOb2RlIDB4MjMgW0F1ZGlvIE1peGVyXSB3Y2FwcyAw
eDIwMDEwYjogU3RlcmVvIEFtcC1JbgogIEFtcC1JbiBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4
MDAsIHN0ZXBzaXplPTB4MDAsIG11dGU9MQogIEFtcC1JbiB2YWxzOiAgWzB4ODAgMHg4MF0gWzB4
ODAgMHg4MF0gWzB4ODAgMHg4MF0gWzB4ODAgMHg4MF0gWzB4ODAgMHg4MF0gWzB4ODAgMHg4MF0K
ICBDb25uZWN0aW9uOiA2CiAgICAgMHgxOCAweDE5IDB4MWEgMHgxYiAweDFkIDB4MGIKTm9kZSAw
eDI0IFtBdWRpbyBNaXhlcl0gd2NhcHMgMHgyMDAxMGI6IFN0ZXJlbyBBbXAtSW4KICBBbXAtSW4g
Y2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAt
SW4gdmFsczogIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdIFsweDgwIDB4ODBdIFsweDgwIDB4ODBd
IFsweDgwIDB4ODBdIFsweDgwIDB4ODBdCiAgQ29ubmVjdGlvbjogNgogICAgIDB4MTggMHgxOSAw
eDFhIDB4MWIgMHgxZCAweDBiCkNvZGVjOiBJbnRlbCBQYW50aGVyUG9pbnQgSERNSQpBZGRyZXNz
OiAzCkFGRyBGdW5jdGlvbiBJZDogMHgxICh1bnNvbCAwKQpWZW5kb3IgSWQ6IDB4ODA4NjI4MDYK
U3Vic3lzdGVtIElkOiAweDgwODYwMTAxClJldmlzaW9uIElkOiAweDEwMDAwMApObyBNb2RlbSBG
dW5jdGlvbiBHcm91cCBmb3VuZApEZWZhdWx0IFBDTToKICAgIHJhdGVzIFsweDBdOgogICAgYml0
cyBbMHgwXToKICAgIGZvcm1hdHMgWzB4MF06CkRlZmF1bHQgQW1wLUluIGNhcHM6IE4vQQpEZWZh
dWx0IEFtcC1PdXQgY2FwczogTi9BClN0YXRlIG9mIEFGRyBub2RlIDB4MDE6CiAgUG93ZXIgc3Rh
dGVzOiAgRDAgRDMgQ0xLU1RPUCBFUFNTCiAgUG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1EMCwg
Q2xvY2stc3RvcC1PSwpHUElPOiBpbz0wLCBvPTAsIGk9MCwgdW5zb2xpY2l0ZWQ9MCwgd2FrZT0w
Ck5vZGUgMHgwMiBbQXVkaW8gT3V0cHV0XSB3Y2FwcyAweDY2MTE6IDgtQ2hhbm5lbHMgRGlnaXRh
bAogIENvbnZlcnRlcjogc3RyZWFtPTAsIGNoYW5uZWw9MAogIERpZ2l0YWw6IEVuYWJsZWQKICBE
aWdpdGFsIGNhdGVnb3J5OiAweDAKICBJRUMgQ29kaW5nIFR5cGU6IDB4MAogIFBDTToKICAgIHJh
dGVzIFsweDdmMF06IDMyMDAwIDQ0MTAwIDQ4MDAwIDg4MjAwIDk2MDAwIDE3NjQwMCAxOTIwMDAK
ICAgIGJpdHMgWzB4MWVdOiAxNiAyMCAyNCAzMgogICAgZm9ybWF0cyBbMHg1XTogUENNIEFDMwog
IFBvd2VyIHN0YXRlczogIEQwIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQw
Ck5vZGUgMHgwMyBbQXVkaW8gT3V0cHV0XSB3Y2FwcyAweDY2MTE6IDgtQ2hhbm5lbHMgRGlnaXRh
bAogIENvbnZlcnRlcjogc3RyZWFtPTAsIGNoYW5uZWw9MAogIERpZ2l0YWw6IEVuYWJsZWQKICBE
aWdpdGFsIGNhdGVnb3J5OiAweDAKICBJRUMgQ29kaW5nIFR5cGU6IDB4MAogIFBDTToKICAgIHJh
dGVzIFsweDdmMF06IDMyMDAwIDQ0MTAwIDQ4MDAwIDg4MjAwIDk2MDAwIDE3NjQwMCAxOTIwMDAK
ICAgIGJpdHMgWzB4MWVdOiAxNiAyMCAyNCAzMgogICAgZm9ybWF0cyBbMHg1XTogUENNIEFDMwog
IFBvd2VyIHN0YXRlczogIEQwIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQw
Ck5vZGUgMHgwNCBbQXVkaW8gT3V0cHV0XSB3Y2FwcyAweDY2MTE6IDgtQ2hhbm5lbHMgRGlnaXRh
bAogIENvbnZlcnRlcjogc3RyZWFtPTAsIGNoYW5uZWw9MAogIERpZ2l0YWw6IEVuYWJsZWQKICBE
aWdpdGFsIGNhdGVnb3J5OiAweDAKICBJRUMgQ29kaW5nIFR5cGU6IDB4MAogIFBDTToKICAgIHJh
dGVzIFsweDdmMF06IDMyMDAwIDQ0MTAwIDQ4MDAwIDg4MjAwIDk2MDAwIDE3NjQwMCAxOTIwMDAK
ICAgIGJpdHMgWzB4MWVdOiAxNiAyMCAyNCAzMgogICAgZm9ybWF0cyBbMHg1XTogUENNIEFDMwog
IFBvd2VyIHN0YXRlczogIEQwIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQw
Ck5vZGUgMHgwNSBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDA3NzhkOiA4LUNoYW5uZWxzIERpZ2l0
YWwgQW1wLU91dCBDUAogIENvbnRyb2w6IG5hbWU9IklFQzk1OCBQbGF5YmFjayBDb24gTWFzayIs
IGluZGV4PTAsIGRldmljZT0wCiAgQ29udHJvbDogbmFtZT0iSUVDOTU4IFBsYXliYWNrIFBybyBN
YXNrIiwgaW5kZXg9MCwgZGV2aWNlPTAKICBDb250cm9sOiBuYW1lPSJJRUM5NTggUGxheWJhY2sg
RGVmYXVsdCIsIGluZGV4PTAsIGRldmljZT0wCiAgQ29udHJvbDogbmFtZT0iSUVDOTU4IFBsYXli
YWNrIFN3aXRjaCIsIGluZGV4PTAsIGRldmljZT0wCiAgQ29udHJvbDogbmFtZT0iRUxEIiwgaW5k
ZXg9MCwgZGV2aWNlPTMKICBBbXAtT3V0IGNhcHM6IG9mcz0weDAwLCBuc3RlcHM9MHgwMCwgc3Rl
cHNpemU9MHgwMCwgbXV0ZT0xCiAgQW1wLU91dCB2YWxzOiAgWzB4MDAgMHgwMF0KICBQaW5jYXAg
MHgwOTAwMDA5NDogT1VUIERldGVjdCBIQlIgSERNSSBEUAogIFBpbiBEZWZhdWx0IDB4MTg1NjAw
MTA6IFtKYWNrXSBEaWdpdGFsIE91dCBhdCBJbnQgSERNSQogICAgQ29ubiA9IERpZ2l0YWwsIENv
bG9yID0gVW5rbm93bgogICAgRGVmQXNzb2NpYXRpb24gPSAweDEsIFNlcXVlbmNlID0gMHgwCiAg
UGluLWN0bHM6IDB4NDA6IE9VVAogIFVuc29saWNpdGVkOiB0YWc9MDEsIGVuYWJsZWQ9MQogIFBv
d2VyIHN0YXRlczogIEQwIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQwCiAg
Q29ubmVjdGlvbjogMQogICAgIDB4MDIKTm9kZSAweDA2IFtQaW4gQ29tcGxleF0gd2NhcHMgMHg0
MDc3OGQ6IDgtQ2hhbm5lbHMgRGlnaXRhbCBBbXAtT3V0IENQCiAgQW1wLU91dCBjYXBzOiBvZnM9
MHgwMCwgbnN0ZXBzPTB4MDAsIHN0ZXBzaXplPTB4MDAsIG11dGU9MQogIEFtcC1PdXQgdmFsczog
IFsweDAwIDB4ODBdCiAgUGluY2FwIDB4MDkwMDAwOTQ6IE9VVCBEZXRlY3QgSEJSIEhETUkgRFAK
ICBQaW4gRGVmYXVsdCAweDU4NTYwMDIwOiBbTi9BXSBEaWdpdGFsIE91dCBhdCBJbnQgSERNSQog
ICAgQ29ubiA9IERpZ2l0YWwsIENvbG9yID0gVW5rbm93bgogICAgRGVmQXNzb2NpYXRpb24gPSAw
eDIsIFNlcXVlbmNlID0gMHgwCiAgUGluLWN0bHM6IDB4NDA6IE9VVAogIFVuc29saWNpdGVkOiB0
YWc9MDAsIGVuYWJsZWQ9MAogIFBvd2VyIHN0YXRlczogIEQwIEQzIEVQU1MKICBQb3dlcjogc2V0
dGluZz1EMCwgYWN0dWFsPUQwCiAgQ29ubmVjdGlvbjogMQogICAgIDB4MDMKTm9kZSAweDA3IFtQ
aW4gQ29tcGxleF0gd2NhcHMgMHg0MDc3OGQ6IDgtQ2hhbm5lbHMgRGlnaXRhbCBBbXAtT3V0IENQ
CiAgQW1wLU91dCBjYXBzOiBvZnM9MHgwMCwgbnN0ZXBzPTB4MDAsIHN0ZXBzaXplPTB4MDAsIG11
dGU9MQogIEFtcC1PdXQgdmFsczogIFsweDAwIDB4ODBdCiAgUGluY2FwIDB4MDkwMDAwOTQ6IE9V
VCBEZXRlY3QgSEJSIEhETUkgRFAKICBQaW4gRGVmYXVsdCAweDU4NTYwMDMwOiBbTi9BXSBEaWdp
dGFsIE91dCBhdCBJbnQgSERNSQogICAgQ29ubiA9IERpZ2l0YWwsIENvbG9yID0gVW5rbm93bgog
ICAgRGVmQXNzb2NpYXRpb24gPSAweDMsIFNlcXVlbmNlID0gMHgwCiAgUGluLWN0bHM6IDB4NDA6
IE9VVAogIFVuc29saWNpdGVkOiB0YWc9MDAsIGVuYWJsZWQ9MAogIFBvd2VyIHN0YXRlczogIEQw
IEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQwCiAgQ29ubmVjdGlvbjogMQog
ICAgIDB4MDQKTm9kZSAweDA4IFtWZW5kb3IgRGVmaW5lZCBXaWRnZXRdIHdjYXBzIDB4ZjAwMDAw
OiBNb25vCi0tZW5kY29sbGFwc2UtLQoKCiEhQUxTQSBEZXZpY2Ugbm9kZXMKISEtLS0tLS0tLS0t
LS0tLS0tLQoKY3J3LXJ3LS0tLSsgMSByb290IGF1ZGlvIDExNiwgIDIgT2N0IDI0IDAwOjIxIC9k
ZXYvc25kL2NvbnRyb2xDMApjcnctcnctLS0tKyAxIHJvb3QgYXVkaW8gMTE2LCAgNiBPY3QgMjQg
MDA6MjEgL2Rldi9zbmQvaHdDMEQwCmNydy1ydy0tLS0rIDEgcm9vdCBhdWRpbyAxMTYsICA3IE9j
dCAyNCAwMDoyMSAvZGV2L3NuZC9od0MwRDMKY3J3LXJ3LS0tLSsgMSByb290IGF1ZGlvIDExNiwg
IDQgT2N0IDI0IDAwOjIxIC9kZXYvc25kL3BjbUMwRDBjCmNydy1ydy0tLS0rIDEgcm9vdCBhdWRp
byAxMTYsICAzIE9jdCAyNCAwMDoyMSAvZGV2L3NuZC9wY21DMEQwcApjcnctcnctLS0tKyAxIHJv
b3QgYXVkaW8gMTE2LCAgNSBPY3QgMjQgMDA6MjEgL2Rldi9zbmQvcGNtQzBEM3AKY3J3LXJ3LS0t
LSsgMSByb290IGF1ZGlvIDExNiwgIDEgT2N0IDI0IDAwOjIxIC9kZXYvc25kL3NlcQpjcnctcnct
LS0tKyAxIHJvb3QgYXVkaW8gMTE2LCAzMyBPY3QgMjQgMDA6MjEgL2Rldi9zbmQvdGltZXIKCi9k
ZXYvc25kL2J5LXBhdGg6CnRvdGFsIDAKZHJ3eHIteHIteCAyIHJvb3Qgcm9vdCAgNjAgT2N0IDI0
IDAwOjIxIC4KZHJ3eHIteHIteCAzIHJvb3Qgcm9vdCAyMjAgT2N0IDI0IDAwOjIxIC4uCmxyd3hy
d3hyd3ggMSByb290IHJvb3QgIDEyIE9jdCAyNCAwMDoyMSBwY2ktMDAwMDowMDoxYi4wIC0+IC4u
L2NvbnRyb2xDMAoKCiEhQXBsYXkvQXJlY29yZCBvdXRwdXQKISEtLS0tLS0tLS0tLS0tLS0tLS0t
LQoKQVBMQVkKCioqKiogTGlzdCBvZiBQTEFZQkFDSyBIYXJkd2FyZSBEZXZpY2VzICoqKioKY2Fy
ZCAwOiBQQ0ggW0hEQSBJbnRlbCBQQ0hdLCBkZXZpY2UgMDogQUxDMzI2MCBBbmFsb2cgW0FMQzMy
NjAgQW5hbG9nXQogIFN1YmRldmljZXM6IDEvMQogIFN1YmRldmljZSAjMDogc3ViZGV2aWNlICMw
CmNhcmQgMDogUENIIFtIREEgSW50ZWwgUENIXSwgZGV2aWNlIDM6IEhETUkgMCBbSERNSSAwXQog
IFN1YmRldmljZXM6IDEvMQogIFN1YmRldmljZSAjMDogc3ViZGV2aWNlICMwCgpBUkVDT1JECgoq
KioqIExpc3Qgb2YgQ0FQVFVSRSBIYXJkd2FyZSBEZXZpY2VzICoqKioKY2FyZCAwOiBQQ0ggW0hE
QSBJbnRlbCBQQ0hdLCBkZXZpY2UgMDogQUxDMzI2MCBBbmFsb2cgW0FMQzMyNjAgQW5hbG9nXQog
IFN1YmRldmljZXM6IDEvMQogIFN1YmRldmljZSAjMDogc3ViZGV2aWNlICMwCgohIUFtaXhlciBv
dXRwdXQKISEtLS0tLS0tLS0tLS0tCgohIS0tLS0tLS1NaXhlciBjb250cm9scyBmb3IgY2FyZCAw
IFtQQ0hdCgpDYXJkIGh3OjAgJ1BDSCcvJ0hEQSBJbnRlbCBQQ0ggYXQgMHhmN2MxMDAwMCBpcnEg
MzknCiAgTWl4ZXIgbmFtZQk6ICdJbnRlbCBQYW50aGVyUG9pbnQgSERNSScKICBDb21wb25lbnRz
CTogJ0hEQToxMGVjMDI3NSwxMDI4MDU0YiwwMDEwMDAwOCBIREE6ODA4NjI4MDYsODA4NjAxMDEs
MDAxMDAwMDAnCiAgQ29udHJvbHMgICAgICA6IDI5CiAgU2ltcGxlIGN0cmxzICA6IDExClNpbXBs
ZSBtaXhlciBjb250cm9sICdNYXN0ZXInLDAKICBDYXBhYmlsaXRpZXM6IHB2b2x1bWUgcHZvbHVt
ZS1qb2luZWQgcHN3aXRjaCBwc3dpdGNoLWpvaW5lZAogIFBsYXliYWNrIGNoYW5uZWxzOiBNb25v
CiAgTGltaXRzOiBQbGF5YmFjayAwIC0gNjQKICBNb25vOiBQbGF5YmFjayA0NiBbNzIlXSBbLTE4
LjAwZEJdIFtvbl0KU2ltcGxlIG1peGVyIGNvbnRyb2wgJ0hlYWRwaG9uZScsMAogIENhcGFiaWxp
dGllczogcHZvbHVtZSBwc3dpdGNoCiAgUGxheWJhY2sgY2hhbm5lbHM6IEZyb250IExlZnQgLSBG
cm9udCBSaWdodAogIExpbWl0czogUGxheWJhY2sgMCAtIDY0CiAgTW9ubzoKICBGcm9udCBMZWZ0
OiBQbGF5YmFjayA2MyBbOTglXSBbMC4wMGRCXSBbb25dCiAgRnJvbnQgUmlnaHQ6IFBsYXliYWNr
IDYzIFs5OCVdIFswLjAwZEJdIFtvbl0KU2ltcGxlIG1peGVyIGNvbnRyb2wgJ1NwZWFrZXInLDAK
ICBDYXBhYmlsaXRpZXM6IHB2b2x1bWUgcHN3aXRjaAogIFBsYXliYWNrIGNoYW5uZWxzOiBGcm9u
dCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBMaW1pdHM6IFBsYXliYWNrIDAgLSA2NAogIE1vbm86CiAg
RnJvbnQgTGVmdDogUGxheWJhY2sgNjMgWzk4JV0gWzAuMDBkQl0gW29uXQogIEZyb250IFJpZ2h0
OiBQbGF5YmFjayA2MyBbOTglXSBbMC4wMGRCXSBbb25dClNpbXBsZSBtaXhlciBjb250cm9sICdQ
Q00nLDAKICBDYXBhYmlsaXRpZXM6IHB2b2x1bWUKICBQbGF5YmFjayBjaGFubmVsczogRnJvbnQg
TGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBQbGF5YmFjayAwIC0gMjU1CiAgTW9ubzoKICBG
cm9udCBMZWZ0OiBQbGF5YmFjayAyNTUgWzEwMCVdIFswLjAwZEJdCiAgRnJvbnQgUmlnaHQ6IFBs
YXliYWNrIDI1NSBbMTAwJV0gWzAuMDBkQl0KU2ltcGxlIG1peGVyIGNvbnRyb2wgJ01pYycsMAog
IENhcGFiaWxpdGllczogcHZvbHVtZSBwc3dpdGNoCiAgUGxheWJhY2sgY2hhbm5lbHM6IEZyb250
IExlZnQgLSBGcm9udCBSaWdodAogIExpbWl0czogUGxheWJhY2sgMCAtIDMxCiAgTW9ubzoKICBG
cm9udCBMZWZ0OiBQbGF5YmFjayAwIFswJV0gWy0zNC41MGRCXSBbb2ZmXQogIEZyb250IFJpZ2h0
OiBQbGF5YmFjayAwIFswJV0gWy0zNC41MGRCXSBbb2ZmXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAn
TWljIEJvb3N0JywwCiAgQ2FwYWJpbGl0aWVzOiB2b2x1bWUKICBQbGF5YmFjayBjaGFubmVsczog
RnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgQ2FwdHVyZSBjaGFubmVsczogRnJvbnQgTGVmdCAt
IEZyb250IFJpZ2h0CiAgTGltaXRzOiAwIC0gMwogIEZyb250IExlZnQ6IDAgWzAlXSBbMC4wMGRC
XQogIEZyb250IFJpZ2h0OiAwIFswJV0gWzAuMDBkQl0KU2ltcGxlIG1peGVyIGNvbnRyb2wgJ0lF
Qzk1OCcsMAogIENhcGFiaWxpdGllczogcHN3aXRjaCBwc3dpdGNoLWpvaW5lZAogIFBsYXliYWNr
IGNoYW5uZWxzOiBNb25vCiAgTW9ubzogUGxheWJhY2sgW29mZl0KU2ltcGxlIG1peGVyIGNvbnRy
b2wgJ0JlZXAnLDAKICBDYXBhYmlsaXRpZXM6IHB2b2x1bWUgcHN3aXRjaAogIFBsYXliYWNrIGNo
YW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBMaW1pdHM6IFBsYXliYWNrIDAgLSAz
MQogIE1vbm86CiAgRnJvbnQgTGVmdDogUGxheWJhY2sgMSBbMyVdIFstMzMuMDBkQl0gW29mZl0K
ICBGcm9udCBSaWdodDogUGxheWJhY2sgMCBbMCVdIFstMzQuNTBkQl0gW29mZl0KU2ltcGxlIG1p
eGVyIGNvbnRyb2wgJ0NhcHR1cmUnLDAKICBDYXBhYmlsaXRpZXM6IGN2b2x1bWUgY3N3aXRjaAog
IENhcHR1cmUgY2hhbm5lbHM6IEZyb250IExlZnQgLSBGcm9udCBSaWdodAogIExpbWl0czogQ2Fw
dHVyZSAwIC0gNDYKICBGcm9udCBMZWZ0OiBDYXB0dXJlIDE3IFszNyVdIFswLjAwZEJdIFtvbl0K
ICBGcm9udCBSaWdodDogQ2FwdHVyZSAxNyBbMzclXSBbMC4wMGRCXSBbb25dClNpbXBsZSBtaXhl
ciBjb250cm9sICdBdXRvLU11dGUgTW9kZScsMAogIENhcGFiaWxpdGllczogZW51bQogIEl0ZW1z
OiAnRGlzYWJsZWQnICdFbmFibGVkJwogIEl0ZW0wOiAnRW5hYmxlZCcKU2ltcGxlIG1peGVyIGNv
bnRyb2wgJ0ludGVybmFsIE1pYyBCb29zdCcsMAogIENhcGFiaWxpdGllczogdm9sdW1lCiAgUGxh
eWJhY2sgY2hhbm5lbHM6IEZyb250IExlZnQgLSBGcm9udCBSaWdodAogIENhcHR1cmUgY2hhbm5l
bHM6IEZyb250IExlZnQgLSBGcm9udCBSaWdodAogIExpbWl0czogMCAtIDMKICBGcm9udCBMZWZ0
OiAyIFs2NyVdIFsyMC4wMGRCXQogIEZyb250IFJpZ2h0OiAyIFs2NyVdIFsyMC4wMGRCXQoKCiEh
QWxzYWN0bCBvdXRwdXQKISEtLS0tLS0tLS0tLS0tLQoKLS1zdGFydGNvbGxhcHNlLS0Kc3RhdGUu
UENIIHsKCWNvbnRyb2wuMSB7CgkJaWZhY2UgTUlYRVIKCQluYW1lICdIZWFkcGhvbmUgUGxheWJh
Y2sgVm9sdW1lJwoJCXZhbHVlLjAgNjMKCQl2YWx1ZS4xIDYzCgkJY29tbWVudCB7CgkJCWFjY2Vz
cyAncmVhZCB3cml0ZScKCQkJdHlwZSBJTlRFR0VSCgkJCWNvdW50IDIKCQkJcmFuZ2UgJzAgLSA2
NCcKCQkJZGJtaW4gLTYzMDAKCQkJZGJtYXggMTAwCgkJCWRidmFsdWUuMCAwCgkJCWRidmFsdWUu
MSAwCgkJfQoJfQoJY29udHJvbC4yIHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ0hlYWRwaG9uZSBQ
bGF5YmFjayBTd2l0Y2gnCgkJdmFsdWUuMCB0cnVlCgkJdmFsdWUuMSB0cnVlCgkJY29tbWVudCB7
CgkJCWFjY2VzcyAncmVhZCB3cml0ZScKCQkJdHlwZSBCT09MRUFOCgkJCWNvdW50IDIKCQl9Cgl9
Cgljb250cm9sLjMgewoJCWlmYWNlIE1JWEVSCgkJbmFtZSAnU3BlYWtlciBQbGF5YmFjayBWb2x1
bWUnCgkJdmFsdWUuMCA2MwoJCXZhbHVlLjEgNjMKCQljb21tZW50IHsKCQkJYWNjZXNzICdyZWFk
IHdyaXRlJwoJCQl0eXBlIElOVEVHRVIKCQkJY291bnQgMgoJCQlyYW5nZSAnMCAtIDY0JwoJCQlk
Ym1pbiAtNjMwMAoJCQlkYm1heCAxMDAKCQkJZGJ2YWx1ZS4wIDAKCQkJZGJ2YWx1ZS4xIDAKCQl9
Cgl9Cgljb250cm9sLjQgewoJCWlmYWNlIE1JWEVSCgkJbmFtZSAnU3BlYWtlciBQbGF5YmFjayBT
d2l0Y2gnCgkJdmFsdWUuMCB0cnVlCgkJdmFsdWUuMSB0cnVlCgkJY29tbWVudCB7CgkJCWFjY2Vz
cyAncmVhZCB3cml0ZScKCQkJdHlwZSBCT09MRUFOCgkJCWNvdW50IDIKCQl9Cgl9Cgljb250cm9s
LjUgewoJCWlmYWNlIE1JWEVSCgkJbmFtZSAnTWljIFBsYXliYWNrIFZvbHVtZScKCQl2YWx1ZS4w
IDAKCQl2YWx1ZS4xIDAKCQljb21tZW50IHsKCQkJYWNjZXNzICdyZWFkIHdyaXRlJwoJCQl0eXBl
IElOVEVHRVIKCQkJY291bnQgMgoJCQlyYW5nZSAnMCAtIDMxJwoJCQlkYm1pbiAtMzQ1MAoJCQlk
Ym1heCAxMjAwCgkJCWRidmFsdWUuMCAtMzQ1MAoJCQlkYnZhbHVlLjEgLTM0NTAKCQl9Cgl9Cglj
b250cm9sLjYgewoJCWlmYWNlIE1JWEVSCgkJbmFtZSAnTWljIFBsYXliYWNrIFN3aXRjaCcKCQl2
YWx1ZS4wIGZhbHNlCgkJdmFsdWUuMSBmYWxzZQoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQg
d3JpdGUnCgkJCXR5cGUgQk9PTEVBTgoJCQljb3VudCAyCgkJfQoJfQoJY29udHJvbC43IHsKCQlp
ZmFjZSBNSVhFUgoJCW5hbWUgJ0F1dG8tTXV0ZSBNb2RlJwoJCXZhbHVlIEVuYWJsZWQKCQljb21t
ZW50IHsKCQkJYWNjZXNzICdyZWFkIHdyaXRlJwoJCQl0eXBlIEVOVU1FUkFURUQKCQkJY291bnQg
MQoJCQlpdGVtLjAgRGlzYWJsZWQKCQkJaXRlbS4xIEVuYWJsZWQKCQl9Cgl9Cgljb250cm9sLjgg
ewoJCWlmYWNlIE1JWEVSCgkJbmFtZSAnQ2FwdHVyZSBWb2x1bWUnCgkJdmFsdWUuMCAxNwoJCXZh
bHVlLjEgMTcKCQljb21tZW50IHsKCQkJYWNjZXNzICdyZWFkIHdyaXRlJwoJCQl0eXBlIElOVEVH
RVIKCQkJY291bnQgMgoJCQlyYW5nZSAnMCAtIDQ2JwoJCQlkYm1pbiAtMTcwMAoJCQlkYm1heCAy
OTAwCgkJCWRidmFsdWUuMCAwCgkJCWRidmFsdWUuMSAwCgkJfQoJfQoJY29udHJvbC45IHsKCQlp
ZmFjZSBNSVhFUgoJCW5hbWUgJ0NhcHR1cmUgU3dpdGNoJwoJCXZhbHVlLjAgdHJ1ZQoJCXZhbHVl
LjEgdHJ1ZQoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQgd3JpdGUnCgkJCXR5cGUgQk9PTEVB
TgoJCQljb3VudCAyCgkJfQoJfQoJY29udHJvbC4xMCB7CgkJaWZhY2UgTUlYRVIKCQluYW1lICdN
aWMgQm9vc3QgVm9sdW1lJwoJCXZhbHVlLjAgMAoJCXZhbHVlLjEgMAoJCWNvbW1lbnQgewoJCQlh
Y2Nlc3MgJ3JlYWQgd3JpdGUnCgkJCXR5cGUgSU5URUdFUgoJCQljb3VudCAyCgkJCXJhbmdlICcw
IC0gMycKCQkJZGJtaW4gMAoJCQlkYm1heCAzMDAwCgkJCWRidmFsdWUuMCAwCgkJCWRidmFsdWUu
MSAwCgkJfQoJfQoJY29udHJvbC4xMSB7CgkJaWZhY2UgTUlYRVIKCQluYW1lICdJbnRlcm5hbCBN
aWMgQm9vc3QgVm9sdW1lJwoJCXZhbHVlLjAgMgoJCXZhbHVlLjEgMgoJCWNvbW1lbnQgewoJCQlh
Y2Nlc3MgJ3JlYWQgd3JpdGUnCgkJCXR5cGUgSU5URUdFUgoJCQljb3VudCAyCgkJCXJhbmdlICcw
IC0gMycKCQkJZGJtaW4gMAoJCQlkYm1heCAzMDAwCgkJCWRidmFsdWUuMCAyMDAwCgkJCWRidmFs
dWUuMSAyMDAwCgkJfQoJfQoJY29udHJvbC4xMiB7CgkJaWZhY2UgTUlYRVIKCQluYW1lICdNYXN0
ZXIgUGxheWJhY2sgVm9sdW1lJwoJCXZhbHVlIDQ2CgkJY29tbWVudCB7CgkJCWFjY2VzcyAncmVh
ZCB3cml0ZScKCQkJdHlwZSBJTlRFR0VSCgkJCWNvdW50IDEKCQkJcmFuZ2UgJzAgLSA2NCcKCQkJ
ZGJtaW4gLTY0MDAKCQkJZGJtYXggMAoJCQlkYnZhbHVlLjAgLTE4MDAKCQl9Cgl9Cgljb250cm9s
LjEzIHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ01hc3RlciBQbGF5YmFjayBTd2l0Y2gnCgkJdmFs
dWUgdHJ1ZQoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQgd3JpdGUnCgkJCXR5cGUgQk9PTEVB
TgoJCQljb3VudCAxCgkJfQoJfQoJY29udHJvbC4xNCB7CgkJaWZhY2UgQ0FSRAoJCW5hbWUgJ01p
YyBKYWNrJwoJCXZhbHVlIGZhbHNlCgkJY29tbWVudCB7CgkJCWFjY2VzcyByZWFkCgkJCXR5cGUg
Qk9PTEVBTgoJCQljb3VudCAxCgkJfQoJfQoJY29udHJvbC4xNSB7CgkJaWZhY2UgQ0FSRAoJCW5h
bWUgJ0ludGVybmFsIE1pYyBQaGFudG9tIEphY2snCgkJdmFsdWUgdHJ1ZQoJCWNvbW1lbnQgewoJ
CQlhY2Nlc3MgcmVhZAoJCQl0eXBlIEJPT0xFQU4KCQkJY291bnQgMQoJCX0KCX0KCWNvbnRyb2wu
MTYgewoJCWlmYWNlIENBUkQKCQluYW1lICdIZWFkcGhvbmUgSmFjaycKCQl2YWx1ZSBmYWxzZQoJ
CWNvbW1lbnQgewoJCQlhY2Nlc3MgcmVhZAoJCQl0eXBlIEJPT0xFQU4KCQkJY291bnQgMQoJCX0K
CX0KCWNvbnRyb2wuMTcgewoJCWlmYWNlIENBUkQKCQluYW1lICdTcGVha2VyIFBoYW50b20gSmFj
aycKCQl2YWx1ZSB0cnVlCgkJY29tbWVudCB7CgkJCWFjY2VzcyByZWFkCgkJCXR5cGUgQk9PTEVB
TgoJCQljb3VudCAxCgkJfQoJfQoJY29udHJvbC4xOCB7CgkJaWZhY2UgTUlYRVIKCQluYW1lICdC
ZWVwIFBsYXliYWNrIFZvbHVtZScKCQl2YWx1ZS4wIDEKCQl2YWx1ZS4xIDAKCQljb21tZW50IHsK
CQkJYWNjZXNzICdyZWFkIHdyaXRlJwoJCQl0eXBlIElOVEVHRVIKCQkJY291bnQgMgoJCQlyYW5n
ZSAnMCAtIDMxJwoJCQlkYm1pbiAtMzQ1MAoJCQlkYm1heCAxMjAwCgkJCWRidmFsdWUuMCAtMzMw
MAoJCQlkYnZhbHVlLjEgLTM0NTAKCQl9Cgl9Cgljb250cm9sLjE5IHsKCQlpZmFjZSBNSVhFUgoJ
CW5hbWUgJ0JlZXAgUGxheWJhY2sgU3dpdGNoJwoJCXZhbHVlLjAgZmFsc2UKCQl2YWx1ZS4xIGZh
bHNlCgkJY29tbWVudCB7CgkJCWFjY2VzcyAncmVhZCB3cml0ZScKCQkJdHlwZSBCT09MRUFOCgkJ
CWNvdW50IDIKCQl9Cgl9Cgljb250cm9sLjIwIHsKCQlpZmFjZSBQQ00KCQluYW1lICdQbGF5YmFj
ayBDaGFubmVsIE1hcCcKCQl2YWx1ZS4wIDAKCQl2YWx1ZS4xIDAKCQljb21tZW50IHsKCQkJYWNj
ZXNzIHJlYWQKCQkJdHlwZSBJTlRFR0VSCgkJCWNvdW50IDIKCQkJcmFuZ2UgJzAgLSAzNicKCQl9
Cgl9Cgljb250cm9sLjIxIHsKCQlpZmFjZSBQQ00KCQluYW1lICdDYXB0dXJlIENoYW5uZWwgTWFw
JwoJCXZhbHVlLjAgMAoJCXZhbHVlLjEgMAoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgcmVhZAoJCQl0
eXBlIElOVEVHRVIKCQkJY291bnQgMgoJCQlyYW5nZSAnMCAtIDM2JwoJCX0KCX0KCWNvbnRyb2wu
MjIgewoJCWlmYWNlIENBUkQKCQluYW1lICdIRE1JL0RQLHBjbT0zIEphY2snCgkJdmFsdWUgZmFs
c2UKCQljb21tZW50IHsKCQkJYWNjZXNzIHJlYWQKCQkJdHlwZSBCT09MRUFOCgkJCWNvdW50IDEK
CQl9Cgl9Cgljb250cm9sLjIzIHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ0lFQzk1OCBQbGF5YmFj
ayBDb24gTWFzaycKCQl2YWx1ZSAnMGZmZjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCcKCQljb21tZW50IHsKCQkJYWNjZXNzIHJl
YWQKCQkJdHlwZSBJRUM5NTgKCQkJY291bnQgMQoJCX0KCX0KCWNvbnRyb2wuMjQgewoJCWlmYWNl
IE1JWEVSCgkJbmFtZSAnSUVDOTU4IFBsYXliYWNrIFBybyBNYXNrJwoJCXZhbHVlICcwZjAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwJwoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgcmVhZAoJCQl0eXBlIElFQzk1OAoJCQljb3VudCAx
CgkJfQoJfQoJY29udHJvbC4yNSB7CgkJaWZhY2UgTUlYRVIKCQluYW1lICdJRUM5NTggUGxheWJh
Y2sgRGVmYXVsdCcKCQl2YWx1ZSAnMDQwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCcKCQljb21tZW50IHsKCQkJYWNjZXNzICdy
ZWFkIHdyaXRlJwoJCQl0eXBlIElFQzk1OAoJCQljb3VudCAxCgkJfQoJfQoJY29udHJvbC4yNiB7
CgkJaWZhY2UgTUlYRVIKCQluYW1lICdJRUM5NTggUGxheWJhY2sgU3dpdGNoJwoJCXZhbHVlIGZh
bHNlCgkJY29tbWVudCB7CgkJCWFjY2VzcyAncmVhZCB3cml0ZScKCQkJdHlwZSBCT09MRUFOCgkJ
CWNvdW50IDEKCQl9Cgl9Cgljb250cm9sLjI3IHsKCQlpZmFjZSBQQ00KCQlkZXZpY2UgMwoJCW5h
bWUgRUxECgkJdmFsdWUgJycKCQljb21tZW50IHsKCQkJYWNjZXNzICdyZWFkIHZvbGF0aWxlJwoJ
CQl0eXBlIEJZVEVTCgkJCWNvdW50IDAKCQl9Cgl9Cgljb250cm9sLjI4IHsKCQlpZmFjZSBQQ00K
CQlkZXZpY2UgMwoJCW5hbWUgJ1BsYXliYWNrIENoYW5uZWwgTWFwJwoJCXZhbHVlLjAgMAoJCXZh
bHVlLjEgMAoJCXZhbHVlLjIgMAoJCXZhbHVlLjMgMAoJCXZhbHVlLjQgMAoJCXZhbHVlLjUgMAoJ
CXZhbHVlLjYgMAoJCXZhbHVlLjcgMAoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQgd3JpdGUn
CgkJCXR5cGUgSU5URUdFUgoJCQljb3VudCA4CgkJCXJhbmdlICcwIC0gMzYnCgkJfQoJfQoJY29u
dHJvbC4yOSB7CgkJaWZhY2UgTUlYRVIKCQluYW1lICdQQ00gUGxheWJhY2sgVm9sdW1lJwoJCXZh
bHVlLjAgMjU1CgkJdmFsdWUuMSAyNTUKCQljb21tZW50IHsKCQkJYWNjZXNzICdyZWFkIHdyaXRl
IHVzZXInCgkJCXR5cGUgSU5URUdFUgoJCQljb3VudCAyCgkJCXJhbmdlICcwIC0gMjU1JwoJCQl0
bHYgJzAwMDAwMDAxMDAwMDAwMDhmZmZmZWMxNDAwMDAwMDE0JwoJCQlkYm1pbiAtNTEwMAoJCQlk
Ym1heCAwCgkJCWRidmFsdWUuMCAwCgkJCWRidmFsdWUuMSAwCgkJfQoJfQp9Ci0tZW5kY29sbGFw
c2UtLQoKCiEhQWxsIExvYWRlZCBNb2R1bGVzCiEhLS0tLS0tLS0tLS0tLS0tLS0tCgpNb2R1bGUK
Y21hYwpyZmNvbW0KYm5lcAphcmM0Cm5sc19pc284ODU5XzEKYXRoOWsKYXRoOWtfY29tbW9uCmF0
aDlrX2h3Cmk5MTUKYXRoCm1hYzgwMjExCnNuZF9oZGFfY29kZWNfaGRtaQpzbmRfaGRhX2NvZGVj
X3JlYWx0ZWsKc25kX2hkYV9jb2RlY19nZW5lcmljCnNuZF9oZGFfaW50ZWwKc25kX2hkYV9jb2Rl
YwppbnRlbF9yYXBsCmlvc2ZfbWJpCnNuZF9oZGFfY29yZQp4ODZfcGtnX3RlbXBfdGhlcm1hbApp
bnRlbF9wb3dlcmNsYW1wCmpveWRldgpjb3JldGVtcApzbmRfaHdkZXAKa3ZtX2ludGVsCmRybV9r
bXNfaGVscGVyCnNuZF9wY20Ka3ZtCmRybQpjZmc4MDIxMQphdGgzawp1dmN2aWRlbwpidHVzYgpi
dHJ0bApzbmRfc2VxX21pZGkKYnRiY20Kc25kX3NlcV9taWRpX2V2ZW50CnNuZF9yYXdtaWRpCnZp
ZGVvYnVmMl92bWFsbG9jCmJ0aW50ZWwKdmlkZW9idWYyX21lbW9wcwpkZWxsX3dtaV9haW8KYmx1
ZXRvb3RoCnNuZF9zZXEKaGlkX2dlbmVyaWMKdmlkZW9idWYyX2NvcmUKc3BhcnNlX2tleW1hcAp2
NGwyX2NvbW1vbgp2aWRlb2RldgpkY2RiYXMKc25kX3NlcV9kZXZpY2UKY3JjdDEwZGlmX3BjbG11
bApzbmRfdGltZXIKY3JjMzJfcGNsbXVsCnVzYmhpZApzbmQKYWVzbmlfaW50ZWwKaGlkCmFlc194
ODZfNjQKbWVpX21lCmxydwpzZXMKZ2YxMjhtdWwKcnRzeF9wY2lfbXMKbWVkaWEKZ2x1ZV9oZWxw
ZXIKbWVpCmkyY19hbGdvX2JpdAplbmNsb3N1cmUKaXJfbGlyY19jb2RlYwptZW1zdGljawpzZXJp
b19yYXcKZmJfc3lzX2ZvcHMKYWJsa19oZWxwZXIKbGlyY19kZXYKaXJfeG1wX2RlY29kZXIKY3J5
cHRkCmlyX21jZV9rYmRfZGVjb2Rlcgppcl9zb255X2RlY29kZXIKaWUzMTIwMF9lZGFjCmlyX3Nh
bnlvX2RlY29kZXIKaXJfc2hhcnBfZGVjb2Rlcgppcl9yYzZfZGVjb2Rlcgppcl9yYzVfZGVjb2Rl
cgppcl9qdmNfZGVjb2Rlcgppcl9uZWNfZGVjb2RlcgpzeXNjb3B5YXJlYQplZGFjX2NvcmUKc291
bmRjb3JlCnNocGNocApzeXNmaWxscmVjdApwYXJwb3J0X3BjCnN5c2ltZ2JsdApscGNfaWNoCnBw
ZGV2CnJjX3JjNl9tY2UKZmludGVrX2NpcgpscAo4MjUwX2ZpbnRlawpyY19jb3JlCnZpZGVvCnBh
cnBvcnQKbWFjX2hpZAp3bWkKdWFzCnVzYl9zdG9yYWdlCnJ0c3hfcGNpX3NkbW1jCnBzbW91c2UK
c2RoY2lfcGNpCmFseAphaGNpCnJ0c3hfcGNpCnNkaGNpCmxpYmFoY2kKbWRpbwpmbG9wcHkKCgoh
IVN5c2ZzIEZpbGVzCiEhLS0tLS0tLS0tLS0KCi9zeXMvY2xhc3Mvc291bmQvaHdDMEQwL2luaXRf
cGluX2NvbmZpZ3M6CjB4MTIgMHg5OWEzMDkzMAoweDEzIDB4NDExMTExZjAKMHgxNCAweDkwMTcw
MTEwCjB4MTUgMHgwMzIxNDQxZgoweDE2IDB4NDExMTExZjAKMHgxOCAweDAzYTE5ODIwCjB4MTkg
MHg0MTExMTFmMAoweDFhIDB4NDExMTExZjAKMHgxYiAweDQxMTExMWYwCjB4MWQgMHg0MDE2ODYy
ZAoweDFlIDB4NDExMTExZjAKCi9zeXMvY2xhc3Mvc291bmQvaHdDMEQwL2RyaXZlcl9waW5fY29u
ZmlnczoKCi9zeXMvY2xhc3Mvc291bmQvaHdDMEQwL3VzZXJfcGluX2NvbmZpZ3M6Cgovc3lzL2Ns
YXNzL3NvdW5kL2h3QzBEMC9pbml0X3ZlcmJzOgoKL3N5cy9jbGFzcy9zb3VuZC9od0MwRDAvaGlu
dHM6Cgovc3lzL2NsYXNzL3NvdW5kL2h3QzBEMy9pbml0X3Bpbl9jb25maWdzOgoweDA1IDB4MTg1
NjAwMTAKMHgwNiAweDU4NTYwMDIwCjB4MDcgMHg1ODU2MDAzMAoKL3N5cy9jbGFzcy9zb3VuZC9o
d0MwRDMvZHJpdmVyX3Bpbl9jb25maWdzOgoKL3N5cy9jbGFzcy9zb3VuZC9od0MwRDMvdXNlcl9w
aW5fY29uZmlnczoKCi9zeXMvY2xhc3Mvc291bmQvaHdDMEQzL2luaXRfdmVyYnM6Cgovc3lzL2Ns
YXNzL3NvdW5kL2h3QzBEMy9oaW50czoKCgohIUFMU0EvSERBIGRtZXNnCiEhLS0tLS0tLS0tLS0t
LS0KClsgICAgNC41MjUzNjldIGludGVsX3JhcGw6IEZvdW5kIFJBUEwgZG9tYWluIHVuY29yZQpb
ICAgIDQuNTUzNjY2XSBzbmRfaGRhX2ludGVsIDAwMDA6MDA6MWIuMDogZW5hYmxpbmcgZGV2aWNl
ICgwMDAwIC0+IDAwMDIpClsgICAgNC41ODM5MDBdIHNuZF9oZGFfY29kZWNfcmVhbHRlayBoZGF1
ZGlvQzBEMDogYXV0b2NvbmZpZyBmb3IgQUxDMzI2MDogbGluZV9vdXRzPTEgKDB4MTQvMHgwLzB4
MC8weDAvMHgwKSB0eXBlOnNwZWFrZXIKWyAgICA0LjU4MzkwMl0gc25kX2hkYV9jb2RlY19yZWFs
dGVrIGhkYXVkaW9DMEQwOiAgICBzcGVha2VyX291dHM9MCAoMHgwLzB4MC8weDAvMHgwLzB4MCkK
WyAgICA0LjU4MzkwNF0gc25kX2hkYV9jb2RlY19yZWFsdGVrIGhkYXVkaW9DMEQwOiAgICBocF9v
dXRzPTEgKDB4MTUvMHgwLzB4MC8weDAvMHgwKQpbICAgIDQuNTgzOTA1XSBzbmRfaGRhX2NvZGVj
X3JlYWx0ZWsgaGRhdWRpb0MwRDA6ICAgIG1vbm86IG1vbm9fb3V0PTB4MApbICAgIDQuNTgzOTA2
XSBzbmRfaGRhX2NvZGVjX3JlYWx0ZWsgaGRhdWRpb0MwRDA6ICAgIGlucHV0czoKWyAgICA0LjU4
MzkwOF0gc25kX2hkYV9jb2RlY19yZWFsdGVrIGhkYXVkaW9DMEQwOiAgICAgIE1pYz0weDE4Clsg
ICAgNC41ODM5MDldIHNuZF9oZGFfY29kZWNfcmVhbHRlayBoZGF1ZGlvQzBEMDogICAgICBJbnRl
cm5hbCBNaWM9MHgxMgpbICAgIDQuNjA1OTg3XSBpbnB1dDogSERBIEludGVsIFBDSCBNaWMgYXMg
L2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFiLjAvc291bmQvY2FyZDAvaW5wdXQxMgpbICAg
IDQuNjA2MDU0XSBpbnB1dDogSERBIEludGVsIFBDSCBIZWFkcGhvbmUgYXMgL2RldmljZXMvcGNp
MDAwMDowMC8wMDAwOjAwOjFiLjAvc291bmQvY2FyZDAvaW5wdXQxMwpbICAgIDQuNjA2MTEyXSBp
bnB1dDogSERBIEludGVsIFBDSCBIRE1JL0RQLHBjbT0zIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAv
MDAwMDowMDoxYi4wL3NvdW5kL2NhcmQwL2lucHV0MTQKWyAgICA0LjY4NTg4NV0gRVhUNC1mcyAo
c2RiMik6IHJlLW1vdW50ZWQuIE9wdHM6IGVycm9ycz1yZW1vdW50LXJvCgoK
--001a11c25d4e3ceb860522ccbf6b
Content-Type: text/x-patch; charset=US-ASCII; name="alsa-info.txt.4.3-rc6.coef1.patch"
Content-Disposition: attachment;
	filename="alsa-info.txt.4.3-rc6.coef1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ig473ywu1

LS0tIGFsc2EtaW5mby50eHQuNC4zLXJjNi5jb2VmMS5iZWZvcmUJMjAxNS0xMC0yNCAwMDoyODo1
My43ODUzODc0ODYgKzAzMDAKKysrIGFsc2EtaW5mby50eHQuNC4zLXJjNi5jb2VmMS5hZnRlcgky
MDE1LTEwLTI0IDAwOjMxOjAwLjM1ODA5MDA4NiArMDMwMApAQCAtMyw3ICszLDcgQEAKICEhQUxT
QSBJbmZvcm1hdGlvbiBTY3JpcHQgdiAwLjQuNjQKICEhIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMKIAotISFTY3JpcHQgcmFuIG9uOiBGcmkgT2N0IDIzIDIxOjI4OjUxIFVUQyAyMDE1
CishIVNjcmlwdCByYW4gb246IEZyaSBPY3QgMjMgMjE6MzA6NTkgVVRDIDIwMTUKIAogCiAhIUxp
bnV4IERpc3RyaWJ1dGlvbgpAQCAtMTQzLDI1ICsxNDMsMjUgQEAKICAgRGV2aWNlOiBuYW1lPSJB
TEMzMjYwIEFuYWxvZyIsIHR5cGU9IkF1ZGlvIiwgZGV2aWNlPTAKICAgQW1wLU91dCBjYXBzOiBv
ZnM9MHgzZiwgbnN0ZXBzPTB4NDAsIHN0ZXBzaXplPTB4MDMsIG11dGU9MAogICBBbXAtT3V0IHZh
bHM6ICBbMHgyZCAweDJkXQotICBDb252ZXJ0ZXI6IHN0cmVhbT01LCBjaGFubmVsPTAKKyAgQ29u
dmVydGVyOiBzdHJlYW09MCwgY2hhbm5lbD0wCiAgIFBDTToKICAgICByYXRlcyBbMHg1NjBdOiA0
NDEwMCA0ODAwMCA5NjAwMCAxOTIwMDAKICAgICBiaXRzIFsweGVdOiAxNiAyMCAyNAogICAgIGZv
cm1hdHMgWzB4MV06IFBDTQogICBQb3dlciBzdGF0ZXM6ICBEMCBEMSBEMiBEMyBFUFNTCi0gIFBv
d2VyOiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAKKyAgUG93ZXI6IHNldHRpbmc9RDMsIGFjdHVhbD1E
MwogTm9kZSAweDAzIFtBdWRpbyBPdXRwdXRdIHdjYXBzIDB4NDFkOiBTdGVyZW8gQW1wLU91dAog
ICBDb250cm9sOiBuYW1lPSJTcGVha2VyIFBsYXliYWNrIFZvbHVtZSIsIGluZGV4PTAsIGRldmlj
ZT0wCiAgICAgQ29udHJvbEFtcDogY2hzPTMsIGRpcj1PdXQsIGlkeD0wLCBvZnM9MAogICBBbXAt
T3V0IGNhcHM6IG9mcz0weDNmLCBuc3RlcHM9MHg0MCwgc3RlcHNpemU9MHgwMywgbXV0ZT0wCiAg
IEFtcC1PdXQgdmFsczogIFsweDJkIDB4MmRdCi0gIENvbnZlcnRlcjogc3RyZWFtPTUsIGNoYW5u
ZWw9MAorICBDb252ZXJ0ZXI6IHN0cmVhbT0wLCBjaGFubmVsPTAKICAgUENNOgogICAgIHJhdGVz
IFsweDU2MF06IDQ0MTAwIDQ4MDAwIDk2MDAwIDE5MjAwMAogICAgIGJpdHMgWzB4ZV06IDE2IDIw
IDI0CiAgICAgZm9ybWF0cyBbMHgxXTogUENNCiAgIFBvd2VyIHN0YXRlczogIEQwIEQxIEQyIEQz
IEVQU1MKLSAgUG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1EMAorICBQb3dlcjogc2V0dGluZz1E
MywgYWN0dWFsPUQzCiBOb2RlIDB4MDQgW1ZlbmRvciBEZWZpbmVkIFdpZGdldF0gd2NhcHMgMHhm
MDAwMDA6IE1vbm8KIE5vZGUgMHgwNSBbVmVuZG9yIERlZmluZWQgV2lkZ2V0XSB3Y2FwcyAweGYw
MDAwMDogTW9ubwogTm9kZSAweDA2IFtBdWRpbyBPdXRwdXRdIHdjYXBzIDB4NjExOiBTdGVyZW8g
RGlnaXRhbApAQCAtMjQxLDE0ICsyNDEsMTQgQEAKIE5vZGUgMHgxMSBbQXVkaW8gSW5wdXRdIHdj
YXBzIDB4MTAwNTFiOiBTdGVyZW8gQW1wLUluCiAgIEFtcC1JbiBjYXBzOiBvZnM9MHgxMSwgbnN0
ZXBzPTB4MmUsIHN0ZXBzaXplPTB4MDMsIG11dGU9MQogICBBbXAtSW4gdmFsczogIFsweDExIDB4
MTFdCi0gIENvbnZlcnRlcjogc3RyZWFtPTEsIGNoYW5uZWw9MAorICBDb252ZXJ0ZXI6IHN0cmVh
bT0wLCBjaGFubmVsPTAKICAgU0RJLVNlbGVjdDogMAogICBQQ006CiAgICAgcmF0ZXMgWzB4MTYw
XTogNDQxMDAgNDgwMDAgOTYwMDAKICAgICBiaXRzIFsweGVdOiAxNiAyMCAyNAogICAgIGZvcm1h
dHMgWzB4MV06IFBDTQogICBQb3dlciBzdGF0ZXM6ICBEMCBEMSBEMiBEMyBFUFNTCi0gIFBvd2Vy
OiBzZXR0aW5nPUQwLCBhY3R1YWw9RDAKKyAgUG93ZXI6IHNldHRpbmc9RDMsIGFjdHVhbD1EMwog
ICBDb25uZWN0aW9uOiAxCiAgICAgIDB4MjIKIE5vZGUgMHgxMiBbUGluIENvbXBsZXhdIHdjYXBz
IDB4NDAwNDBiOiBTdGVyZW8gQW1wLUluCkBAIC0yNjMsNyArMjYzLDcgQEAKICAgICBNaXNjID0g
Tk9fUFJFU0VOQ0UKICAgUGluLWN0bHM6IDB4MjA6IElOCiAgIFBvd2VyIHN0YXRlczogIEQwIEQx
IEQyIEQzIEVQU1MKLSAgUG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1EMAorICBQb3dlcjogc2V0
dGluZz1EMywgYWN0dWFsPUQzCiBOb2RlIDB4MTMgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQwMDQw
YjogU3RlcmVvIEFtcC1JbgogICBBbXAtSW4gY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAzLCBz
dGVwc2l6ZT0weDI3LCBtdXRlPTAKICAgQW1wLUluIHZhbHM6ICBbMHgwMCAweDAwXQpAQCAtMjg4
LDcgKzI4OCw3IEBACiAgICAgTWlzYyA9IE5PX1BSRVNFTkNFCiAgIFBpbi1jdGxzOiAweDQwOiBP
VVQKICAgUG93ZXIgc3RhdGVzOiAgRDAgRDEgRDIgRDMgRVBTUwotICBQb3dlcjogc2V0dGluZz1E
MCwgYWN0dWFsPUQwCisgIFBvd2VyOiBzZXR0aW5nPUQzLCBhY3R1YWw9RDMKICAgQ29ubmVjdGlv
bjogMgogICAgICAweDBjIDB4MGQqCiBOb2RlIDB4MTUgW1BpbiBDb21wbGV4XSB3Y2FwcyAweDQw
MDU4ZDogU3RlcmVvIEFtcC1PdXQKQEAgLTQ0NCw3ICs0NDQsNyBAQAogICAgIENvZWZmIDB4MWM6
IDB4MDAwMAogICAgIENvZWZmIDB4MWQ6IDB4MDAwMAogICAgIENvZWZmIDB4MWU6IDB4MDgwMwot
ICAgIENvZWZmIDB4MWY6IDB4MDBjMAorICAgIENvZWZmIDB4MWY6IDB4MDAwMAogICAgIENvZWZm
IDB4MjA6IDB4MjAyMAogICAgIENvZWZmIDB4MjE6IDB4ODg0MAogICAgIENvZWZmIDB4MjI6IDB4
MDgwMApAQCAtNDYxLDcgKzQ2MSw3IEBACiAgICAgQ29lZmYgMHgyZDogMHgwMDAwCiAgICAgQ29l
ZmYgMHgyZTogMHgwMDAwCiAgICAgQ29lZmYgMHgyZjogMHgzMDAwCi0gICAgQ29lZmYgMHgzMDog
MHgwMGIxCisgICAgQ29lZmYgMHgzMDogMHgwMDkwCiAgICAgQ29lZmYgMHgzMTogMHgwMDAwCiAg
ICAgQ29lZmYgMHgzMjogMHgwMDAwCiAgICAgQ29lZmYgMHgzMzogMHgwMDAwCkBAIC0xMDg1LDYg
KzEwODUsOCBAQAogISEtLS0tLS0tLS0tLS0tLS0tLS0KIAogTW9kdWxlCithbHgKK21kaW8KIGNt
YWMKIHJmY29tbQogYm5lcApAQCAtMTE5NCwxMiArMTE5NiwxMCBAQAogcnRzeF9wY2lfc2RtbWMK
IHBzbW91c2UKIHNkaGNpX3BjaQotYWx4CiBhaGNpCiBydHN4X3BjaQogc2RoY2kKIGxpYmFoY2kK
LW1kaW8KIGZsb3BweQogCiAK
--001a11c25d4e3ceb860522ccbf6b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--001a11c25d4e3ceb860522ccbf6b--
