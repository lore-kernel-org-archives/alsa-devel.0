From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Headphone jack and auto-mute of speak output
Date: Sat, 9 Oct 2010 16:53:57 +0800
Message-ID: <AANLkTikwoa=uwJ930jvYvs04g-N1Wb0O8Su2XA_wBw2K@mail.gmail.com>
References: <AANLkTi=ZhMVY1abcpxviy50yfSbdc1vABCtKa9jJXfig@mail.gmail.com>
	<AANLkTim-R=FGHo-CxT=gxysisTRT3T35pyrfu7HscKAQ@mail.gmail.com>
	<4CADEF5F.7070600@canonical.com>
	<AANLkTimHatLx7PP6BQc=zxOyBarKiFuTpLbeDpWh7kdJ@mail.gmail.com>
	<AANLkTikgxaA1E4EMpan63-s48MefDsvRPXfYxfYRV3XX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 315512414B
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Oct 2010 10:54:04 +0200 (CEST)
Received: by ewy8 with SMTP id 8so983080ewy.38
	for <alsa-devel@alsa-project.org>; Sat, 09 Oct 2010 01:54:03 -0700 (PDT)
In-Reply-To: <AANLkTikgxaA1E4EMpan63-s48MefDsvRPXfYxfYRV3XX@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/10/8 Davyd McColl <davydm@gmail.com>

> On 8 October 2010 01:05, Raymond Yau <superquad.vortex2@gmail.com> wrote:
>
>>  2010/10/8 David Henningsson <david.henningsson@canonical.com>
>>
>> As you have not provided any output of alsa-info.sh  , it is impossible to
>> say this case is a regression or not
>>
> Apologies. ALSA information can be found here:
> http://www.alsa-project.org/db/?f=e0b199a8e8de35452f761359e753f0f668bb9551
>
> In addition, the original bug I submitted can be found here:
> https://bugs.launchpad.net/bugs/655351
>
> There is a full hardware info dump as made by apport alongside that.
>
> If the driver cannot find the [Pin Complex] Speaker at Int when you select
>> model=auto.
>> it assume that it is a desktop instead of a laptop
>>
> The machine presenting the issue is indeed a desktop, not a laptop.
>
> -d
>


According to the output of alsa-infos.h, the motherboard seem has 6 audio
jacks and spdif out at the rear panel ,  green/pink jack at front panel

In theory the model should be 6stack-dig but hda-emu seem has several error
messages when using your codec-info.

The ALC888 series are high-performance 7.1+2 Channel High Definition Audio
Codecs providing ten DAC channels that simultaneously support 7.1 sound
playback, plus 2 channels of independent stereo sound output (multiple
streaming) through the front panel stereo outputs. The series integrates two
stereo ADCs that can support a stereo microphone

There are five volume controls and mute switches In the Block diagram (page
5 of alc888 datasheet) and the driver had created

The driver only implement stream_analog_alt_capture, but the 2 channels of
indpendent stereo has not been implemented if you look at the comment in
patch_realtek.c


Node 0x25 [Audio Output] wcaps 0x11: Stereo
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24

    formats [0x1]: PCM
Node 0x26 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=0

  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x25 0x0b




Headphones don't mute master sound is quite different from your previous
posts and David 's post

You expect all the 4 audio jacks in the rear panel should be muted when the
headphone is plugged in


>> This first appeared on my upgrade to 9.04

http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=2134ea4f37d36addbe86d4901f6c67a22a5db006

since the virtual master volume control and playback switch is to allow
codecs that have no real hardware master volume registers

The virtual master playback switch of reatek codecs 's slave  contains the
following switches

static const char *alc_slave_sws[] = {
       "Front Playback Switch",
       "Surround Playback Switch",
       "Center Playback Switch",
       "LFE Playback Switch",
       "Side Playback Switch",
       "Headphone Playback Switch",
       "Speaker Playback Switch",
       "Mono Playback Switch",
       "iSpeaker Playback Switch",
       NULL,
}


You should notice that the Left/Right balance control of Kmix was removed
because both left/right channels are increase/decrease at the same time when
you moved the volume slider  of the virtual master volume control

Your problem can be solved if someone implement stream_analog_alt_playback
for the headphone so that you can use the new playback device to play audio
to the headphone only

    /* FIXME: setup DAC5 */
    /*spec->stream_analog_alt_playback = &alc880_pcm_analog_alt_playback;*/

This feature is not new , the alt playback device is /dev/adsp in the oss
driver ,

PA will has two sinks for the internal audio , you just switch the profile
to the independent headphone profile or use the sound preference to switch
the audio stream from analog-output sink to independent headphone sink
