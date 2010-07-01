From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Thu, 1 Jul 2010 23:03:36 +0800
Message-ID: <AANLkTikOko5al3xH5HdeEMawQ9bJOAcCrneWRUhXP1s7@mail.gmail.com>
References: <htls4d$phr$1@dough.gmane.org> <huicj9$t30$1@dough.gmane.org>
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
	<AANLkTikj8_3oYu4ERIGHVhlbFKCVQW4P6PCENqblLWgh@mail.gmail.com>
	<i09lsl$le$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C42A103866
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Jul 2010 17:03:37 +0200 (CEST)
Received: by vws11 with SMTP id 11so2476721vws.38
	for <alsa-devel@alsa-project.org>; Thu, 01 Jul 2010 08:03:36 -0700 (PDT)
In-Reply-To: <i09lsl$le$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, bnocera@redhat.com
List-Id: alsa-devel@alsa-project.org

2010/6/28 Colin Guthrie <gmane@colin.guthr.ie>

> 'Twas brillig, and Raymond Yau at 28/06/10 02:47 did gyre and gimble:
>
> > The tooltip of gnome volume control in Fedora 13 clearly indiacte that
> 100%
> > is 0dB for intel8x0 which use ac97 codec  when you put the cursor on top
> of
> > the speaker icon at the system bar
> >
> > https://bugzilla.gnome.org/show_bug.cgi?id=618551
> >
> > according to gnome-media-developer  Bastien Nocera
> >
> > In any case, we only display what PulseAudio tells us, so you should poke
> the
> > PulseAudio devs about this.
> >
> > This is the code in question:
> > gdouble
> > gvc_mixer_stream_get_decibel (GvcMixerStream *stream)
> > {
> >         g_return_val_if_fail (GVC_IS_MIXER_STREAM (stream), 0);
> >
> >         return pa_sw_volume_to_dB(
> >                         (pa_volume_t)
> > gvc_channel_map_get_volume(stream->priv->channel_map)[VOLUME]);
> > }
> >
> >
> >
> > if you don't have any ac97 sound card , you can user virtualbox which has
> an
> > emulated intel8x0 sound card
>
> Dude, we've talked about this already. The PA server applies no software
> amplification and has set the controls provided by ALSA to their
> maximum, which we call 0dB.
>

This is completely wrong when you rename ALSA driver's max_dB to PA 's 0dB

Most applications does not provide any software gain/atten too, when the
ALSA drivers 's volume control is at Max dB (e.g. +12dB for ac97 PCM ) , it
is still 12dB as long as you changed the hardware volume control to 12dB,
it can be 0dB only if PA can provide -12dB (software atten)


the dB value of playback/capture in  gnome-volume-control and "alsamixer
-c0" should be the same for any sound card.

a simple test case is using aplay which did not provide any software
gain/atten

For the ac97 sound card with PCM -34.5dB to +12 dB ( assume that you have
already set the ac97 "Master" to 0dB )

1) aplay -Dhw:0,0 any.wav with "alsamixer -c0 " "Master" at 0.dB and "PCM"
at 12.dB

2) aplay -Dpulse any.wav with gnome volume control at max(0dB) 100%

In both case, "alsamixer -c0" tell you that it is +12dB in playback gain
but gnome-volume-control tell you that it is 0dB gain

if you use  decibel meter, voltmeter or oscilloscope to measure the output
signal
those meters should tell you those two signals are at same level

PA should not rename the dB value on volume scale just because the
computation of the dB value is complicated since user cannot rely on this
shifted dB scale to perform distortion free line level playback/recording
(this require to set both playback and capture volume control at 0dB)

In simple word,  PA is actually provide a wrong dB value to gnome volume
control for those driver which the max_dB is > 0

PA 's renamin max_dB to 0dB  is not limited to those drivers with max_dB > 0


it also affect those driver with max_dB < 0

http://thread.gmane.org/gmane.linux.alsa.devel/73114/focus=73125

Original range (127): -63.5 .. 0 dB
Limited range  (100): -63.5 .. -13.5 dB


http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=30ad5ed04017f7e77b25cf40f18c26396903cd23;hp=19892334499ed21ed4dc30084ad8700253f9cb2f

http://git.0pointer.de/?p=pulseaudio.git;a=commit;h=7bc5cd78454bee5990d29a0ba04482a505a08346

PA cannot rename -13.5dB as 0dB after the driver limited the max_dB to
-13.5dB by reducing the number of steps of the control




>> No. -inf dB is -inf dB. If the card does not go down to -inf dB, PA will
extend the range in >> software. If a card only goes down to -12dB minimum
the range -12dB -> -infdB will be >> done in software. Lennart explained
this very clearly to you already.

It is unlikely for PA just provide software atten for this range (-inf dB to
min dB) since PA volume control has 65536 steps

As most sound cards only provide 32 to 256 steps by hardware (e.g.
DAC/ADC/codec)

The value returned by get_playback_dB() may different from set_playback_dB()
when the driver cannot set the dB value between two hardware steps  (e.g.
ac97 codec  1.5dB per step , so you cannot set playback volume to -0.1dB by
using hw volume control alone,   this is still true even when some HDA codec
support 0.25 dB per step )

This mean that if PA want to set playback volume to -0.1dB,
it have to set the hardware control to 0dB and peform software atten -0.1dB
or set the hardware control to -1.5dB and perform software gain +1.4dB

Can you explain whether PA perform software atten in the above case ?


PA seem did not care about the difference of variable "f" before and after
calling snd_mixer_selem_set_playback_dB() and
snd_mixer_selem_get_playback_dB() to perform necessary software gain/atten
(difference of f )


static int element_set_volume(pa_alsa_element *e, snd_mixer_t *m, const
pa_channel_map *cm, pa_cvolume *v) {


        if (e->has_dB) {
            long value = to_alsa_dB(f);

            if (e->direction == PA_ALSA_DIRECTION_OUTPUT) {
                /* If we call set_play_volume() without checking first
                 * if the channel is available, ALSA behaves ver
                 * strangely and doesn't fail the call */
                if (snd_mixer_selem_has_playback_channel(me, c)) {
                    if ((r = snd_mixer_selem_set_playback_dB(me, c, value,
+1)) >= 0)
                        r = snd_mixer_selem_get_playback_dB(me, c, &value);
                } else
                    r = -1;
            } else {
                if (snd_mixer_selem_has_capture_channel(me, c)) {
                    if ((r = snd_mixer_selem_set_capture_dB(me, c, value,
+1)) >= 0)
                        r = snd_mixer_selem_get_capture_dB(me, c, &value);
                } else
                    r = -1;
            }

            if (r < 0)
                continue;

#ifdef HAVE_VALGRIND_MEMCHECK_H
            VALGRIND_MAKE_MEM_DEFINED(&value, sizeof(value));
#endif

            f = from_alsa_dB(value);

        } else {
