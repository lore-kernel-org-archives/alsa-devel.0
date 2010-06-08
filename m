From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Tue, 8 Jun 2010 08:47:21 +0800
Message-ID: <AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
	<q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>
	<hp744t$5b5$1@dough.gmane.org>
	<r2y4f3252891004160648xa8590219i359286b5a9dece4f@mail.gmail.com>
	<hqbv5m$cmf$1@dough.gmane.org>
	<g2t4f3252891004201932k53dae8a1me8f7e968f8a28b5b@mail.gmail.com>
	<hqmbmm$hsj$1@dough.gmane.org>
	<i2r4f3252891004211816ldfedff21nfe61537043c9b22f@mail.gmail.com>
	<htls4d$phr$1@dough.gmane.org> <4BFE7840.4070004@ladisch.de>
	<htm0et$eb4$1@dough.gmane.org> <htm9mn$n1c$1@dough.gmane.org>
	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>
	<huicj9$t30$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C7F0D10389B
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 02:47:23 +0200 (CEST)
Received: by pvg13 with SMTP id 13so171089pvg.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Jun 2010 17:47:22 -0700 (PDT)
In-Reply-To: <huicj9$t30$1@dough.gmane.org>
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

2010/6/7 Colin Guthrie <gmane@colin.guthr.ie>

> >
> > if  floating point 0.0 is -inf dB , and 1.0 is 0dB ,
> >
> > 0.5 is -6dB , 0.25 is -12 dB , 0.125 is -24dB and 0.0625 is -48dB
>
>
> This is just a pure mapping from dB->linear, but as this linear mapping
> is generally not "natural" there are several different approaches to
> presenting this to users. In PA, a cubic mapping is used on top of this
> basic conversion, to map to the percentage scale (0.0 to 1.0 if you like).
>

Seem that my value is still wrong , every -6dB half the volume

so 1.5 is +6dB , 1.0 is 0dB, -6dB is 0.5 , -12 dB is 0.25, -18dB is 0.125,
-24dB is 0.0625

if shift 16 bit digital audio data to right by 1 bit is -6dB ,   -96dB is
0.000015



>
> So I'm not sure what point you're making by providing these numbers. Can
> you explain?
>
> > how can PA master volume control at 10~15% equivalent to HDA 's -48dB ?
>
> Not sure what you mean here, but I suspect it's the cubic mapping that
> is confusing you.
>
> Here is the function in PA's pulse/volume.c:
>
>  pa_volume_t pa_sw_volume_from_linear(double v) {
>
>    if (v <= 0.0)
>        return PA_VOLUME_MUTED;
>
>    /*
>     * We use a cubic mapping here, as suggested and discussed here:
>     *
>     * http://www.robotplanet.dk/audio/audio_gui_design/
>     *
>
> http://lists.linuxaudio.org/pipermail/linux-audio-dev/2009-May/thread.html#23151
>     *
>     * We make sure that the conversion to linear and back yields the
>     * same volume value! That's why we need the lround() below!
>     */
>
>    return (pa_volume_t) lround(cbrt(v) * PA_VOLUME_NORM);
>  }
>
>
can you provide the forumla for the "Master" volume control of pulse device
? ctl.pulse

there are 65536 steps ,
where are  0dB  , -6dB  and -inf dB on this cubic mapping ?
