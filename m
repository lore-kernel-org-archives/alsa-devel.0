From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: wrong decibel data?
Date: Mon, 14 Jun 2010 08:25:26 +0800
Message-ID: <AANLkTimwvTxPe66fk4hq2-eiky-8Yqd12vN6WYkh9qdQ@mail.gmail.com>
References: <htls4d$phr$1@dough.gmane.org> <4BFE7840.4070004@ladisch.de>
	<htm0et$eb4$1@dough.gmane.org> <htm9mn$n1c$1@dough.gmane.org>
	<AANLkTinK1xWFSpudCrdHwfgnaGyMEn41DY0VGakJlHX6@mail.gmail.com>
	<huicj9$t30$1@dough.gmane.org>
	<AANLkTimts4qRRneVmfY1Qw55OJ4ZwMqpVjp-wM3PTd2s@mail.gmail.com>
	<hulnlp$m00$1@dough.gmane.org>
	<AANLkTikqAJFo7kIjeJ2O1ulg9GUPZniF1NQNu6PAv0cH@mail.gmail.com>
	<hur2pt$uaa$1@dough.gmane.org>
	<20100613135349.GB5818@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1C1AB24478
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 02:25:29 +0200 (CEST)
Received: by vws6 with SMTP id 6so4562676vws.38
	for <alsa-devel@alsa-project.org>; Sun, 13 Jun 2010 17:25:27 -0700 (PDT)
In-Reply-To: <20100613135349.GB5818@tango.0pointer.de>
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

2010/6/13 Lennart Poettering <mznyfn@0pointer.de>

> On Thu, 10.06.10 17:11, Colin Guthrie (gmane@colin.guthr.ie) wrote:
>
> >
> > 'Twas brillig, and Raymond Yau at 10/06/10 04:16 did gyre and gimble:
> > > Can you explain how PA handle the volume controls of ac97 codec ?
> > >
> > > PCM -34.5dB to +*12* dB
> > > Master -46.5dB to 0dB
> > >
> > > The total dB range (PCM + MASTER) is -81dB to +*12*dB
> > >
> > >
> > > Most user concern about recording without distrotion. (i.e. best result
> when
> > > Capture Volume at 0dB , PCM and Master Volume at 0dB ) and they need
> where
> > > are 0dB points
> >
> > I'm not 100% sure how this is handled, but I know it's not ignored.
> > You'll have to ask Lennart directly or dig in the code to see for sure.
>
> If the ALSA volume range is -x dB to +y dB, then the PA volume range
> will be -x-y dB to 0dB (i.e. shifted by -y dB). On top of that most
> volume controls should then mark the ALSA 0dB point as "base" volume on
> the slider, at what PA then calls -y dB.
>
> That way we will expose 0dB as maximum hw amplitude uniformly on all
> sound cards and have a special point on the slider that is hinted to be
> the "comfort" point.
>
> This is all explained on
> http://pulseaudio.org/wiki/WritingVolumeControlUIs#BaseVolumes
>


shifted +12dB to 0dB is completely wrong

+12dB is 4.00 if 0dB is 1.0 (floating point )

you can performed clubsoda 's  experiement as in
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/581650

>> "This is important because if I use those maximum settings and play any
audio which peaks above -12dB, the output will clip and sound distorted."


if your sound card have ac97 codec ., you can use audacity to record the
output from hw:0,0 and you will see clipping occur when you set "PCM" volume
above 0dB
