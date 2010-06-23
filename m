From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Wed, 23 Jun 2010 09:15:31 +0800
Message-ID: <AANLkTim8KsRcWcg3lkqb8RZqhPT_Bp53dwwlQ3ccay1L@mail.gmail.com>
References: <htls4d$phr$1@dough.gmane.org> <4BFE7840.4070004@ladisch.de>
	<htm0et$eb4$1@dough.gmane.org> <htm9mn$n1c$1@dough.gmane.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8472E244E8
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 03:15:34 +0200 (CEST)
Received: by vws20 with SMTP id 20so166210vws.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2010 18:15:32 -0700 (PDT)
In-Reply-To: <hvqqf9$p3j$1@dough.gmane.org>
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

> 'Twas brillig, and Raymond Yau at 22/06/10 16:29 did gyre and gimble:
> > 2010/6/22 Colin Guthrie <gmane@colin.guthr.ie>
> >> As I said above, anything that comes from alsa is considered h/w
> >> amplification for the purposes of PA's volume scale. It's not practical
> >> to differentiate them
> >
> >
> > Software gain is different from hardware gain.
>
> Really? Wow, thanks for that :p
>
> > Clipping due to software gain +12dB cannot compensated by -12dB by
> hardware
> > atten
>
> Another obvious statement, but not really anything to do with the
> discussion.
>
> This only becomes a problem if the softvol plugin is configured to go
> >0dB. And if it is, then I've got to ask why....
>
> You can configure all sorts of crazy and weird shit in alsa if you care
> to, but it's totally impractical for something higher in the stack to
> deal with all the nuances of the ultimate results of that configuration.
> As far as anything further up the stack is concerned, if it's
> represented in alsa, it's "hardware".
>
> Just like softmodems, I don't care further up the stack whether or not
> the functionality is implemented in firmware or software, I just care
> that I have an interface to use a modem.
>
> So, yes, of course you could configure softvol plugin to do nuts things
> in ALSA if you're that way inclined. I don't think anyone who is not
> trying to do weird things will do that, however, and I don't know of any
> particular h/w that is setup in a weird way by default either.
>
> >> Does any card actually configure softvol, by default, to provide any
> >> gain, > 0dB for outputs? If so, then this is IMO a bad idea.
> >>
> >
> > -51dB to 0dB is also software atten of softvol plugin
>
> So that's not > 0dB then is it?
>
> Col
>
>
>
>
As you have modified /usr/share/alsa/cards/HDA-Intel.conf

HDA-Intel.pcm.front.0 {
    @args [ CARD ]
    @args.CARD {
        type string
    }
    type softvol
    slave.pcm {
        type hw
        card $CARD
    }
    control {
        name "PCM Playback Volume"
        card $CARD
    }

you should notice that the front device has a softvol plugin with name "PCM
Playback Volume"

why PA server still insist to open front device for capturing ?

http://thread.gmane.org/gmane.linux.alsa.devel/67912/focus=68248

As Takashi had already mention that

"I agree that the capture from "front" PCM isn't considered as valid.
The "front", "rear", "center_lfe" definitions are rather for multi-channel
playbacks. The capture on these channels aren't useful in most cases."

you can perform an experiement

pcm.test {
    type softvol
    slave.pcm "hw:0,0"
    control {
        name "PA Playback Volume"
        card 0
    }

arecord -D test -f CD -d 10 -v test.wav

you will find "PA Playback Volume" in playback screen of alsamixer

I am not sure the softvol control created when PA open front device
for playback and capture is used for playback or capture

BTW , PA still using "front" to open CTL device too
