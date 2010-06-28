From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Mon, 28 Jun 2010 09:47:20 +0800
Message-ID: <AANLkTikj8_3oYu4ERIGHVhlbFKCVQW4P6PCENqblLWgh@mail.gmail.com>
References: <htls4d$phr$1@dough.gmane.org> <htm9mn$n1c$1@dough.gmane.org>
	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>
	<huicj9$t30$1@dough.gmane.org>
	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>
	<hulnlp$m00$1@dough.gmane.org>
	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>
	<hur2pt$uaa$1@dough.gmane.org>
	<20100613135349.GB5818@tango.0pointer.de>
	<AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>
	<hv4pfi$gqr$3@dough.gmane.org>
	<AANLkTilTZ-QMAZPTx78J8-DPIozFO2G6s5VtX9f83-3X@mail.gmail.com>
	<hv4vs6$a6q$1@dough.gmane.org>
	<AANLkTilbaa94Vlc266FBzDyRkL_G2VSiOdZoLS4vG8Tw@mail.gmail.com>
	<AANLkTimxTM73el7iCE6nwUJMPFpYa0dY2R9SYxa3_j6N@mail.gmail.com>
	<hv5dkf$tv8$1@dough.gmane.org>
	<AANLkTim5rmjxS6YV7j3QEXSW-EyUv2rsT3k2ZzOz-o9o@mail.gmail.com>
	<hvput5$a6o$1@dough.gmane.org>
	<AANLkTilwbCSM7rPLUlAKtTUv1UepbHzvyZTh4CsElOJm@mail.gmail.com>
	<hvqqf9$p3j$1@dough.gmane.org>
	<AANLkTim8KsRcWcg3lkqb8RZqhPT_Bp53dwwlQ3ccay1L@mail.gmail.com>
	<hvsj32$6cm$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id A58FF245E7
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 03:47:22 +0200 (CEST)
Received: by vws11 with SMTP id 11so2704648vws.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 18:47:20 -0700 (PDT)
In-Reply-To: <hvsj32$6cm$1@dough.gmane.org>
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

2010/6/23 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 23/06/10 02:15 did gyre and gimble:
> > why PA server still insist to open front device for capturing ?
>
> Couldn't tell you. Perhaps Lennart is unaware that it is considered
> invalid? I'll ask him.
>
> > http://thread.gmane.org/gmane.linux.alsa.devel/67912/focus=68248
> >
> > As Takashi had already mention that
> >
> > "I agree that the capture from "front" PCM isn't considered as valid.
> > The "front", "rear", "center_lfe" definitions are rather for
> multi-channel
> > playbacks. The capture on these channels aren't useful in most cases."
> >
> > you can perform an experiement
> >
> > pcm.test {
> >     type softvol
> >     slave.pcm "hw:0,0"
> >     control {
> >         name "PA Playback Volume"
> >         card 0
> >     }
> >
> > arecord -D test -f CD -d 10 -v test.wav
> >
> > you will find "PA Playback Volume" in playback screen of alsamixer
> >
> > I am not sure the softvol control created when PA open front device
> > for playback and capture is used for playback or capture
> >
> > BTW , PA still using "front" to open CTL device too
>
> You'll have to ask Lennart directly about that bit.
>

arecord -Dfront:0 -v -f cd | aplay -Dfront:0 -v -f cd

the softvol control was seem to used by arecord and aplay concurrently

Using front device for capture
1)  HDA, the problem is softvol plugin,
2)  emu10k1 , the problem is the hook controls in front playback device
which change the route of volume of the DSP hardware mixer
3)



>
> I can't speak for him with regards to the full setup of the mixer path
> probing stuff, so perhaps "front" should be edited out of this for
> paths. It would likely be a fairly trivial change to configuration files
> rather than any code changes.
>
> Col
>
>
Well , He had already hardcoded to use "hw:card_number" in dbverify.c , it
is only PA server still try to open mixer device "front"

The tooltip of gnome volume control in Fedora 13 clearly indiacte that 100%
is 0dB for intel8x0 which use ac97 codec  when you put the cursor on top of
the speaker icon at the system bar

https://bugzilla.gnome.org/show_bug.cgi?id=618551

according to gnome-media-developer  Bastien Nocera

In any case, we only display what PulseAudio tells us, so you should poke the
PulseAudio devs about this.

This is the code in question:
gdouble
gvc_mixer_stream_get_decibel (GvcMixerStream *stream)
{
        g_return_val_if_fail (GVC_IS_MIXER_STREAM (stream), 0);

        return pa_sw_volume_to_dB(
                        (pa_volume_t)
gvc_channel_map_get_volume(stream->priv->channel_map)[VOLUME]);
}



if you don't have any ac97 sound card , you can user virtualbox which has an
emulated intel8x0 sound card
