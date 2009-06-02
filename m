From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: ASoC: TWL4030 driver support multi channel playback
Date: Tue, 2 Jun 2009 13:25:33 +0300
Message-ID: <200906021325.33879.peter.ujfalusi@nokia.com>
References: <ef0d8a250906010720n144bb53bl4c6cc3e79e0f8db9@mail.gmail.com>
	<20090602095845.GA20046@rakim.wolfsonmicro.main>
	<ef0d8a250906020302q4c96dfb2y27dd5664c7f6ea9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 9147E103835
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 12:25:38 +0200 (CEST)
In-Reply-To: <ef0d8a250906020302q4c96dfb2y27dd5664c7f6ea9c@mail.gmail.com>
Content-Disposition: inline
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
Cc: ext Naveen Krishna Ch <naveenkrishna.ch@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tuesday 02 June 2009 13:02:38 ext Naveen Krishna Ch wrote:
> 2009/6/2 Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> > On Tue, Jun 02, 2009 at 03:24:11PM +0530, Naveen Krishna Ch wrote:
> > > I am done with the entire back porting of ASoC.
> > >
> > > I can see the dapm widgets getting ON/OFF and codec registers being
> >
> > changed.
> >
> > > But, there is no audio out.  Am i missing somthing
> > >
> > > A direct aplay should play the audio on the headset, right?

By default the headset outputs should work (AudioL2 and AudioR2 is routed t=
o =

the output).
Try with the following:
aplay -f dat /dev/urandom
If there is no noise, than from another terminal try to play with the alsa =

mixers...

>
> >  As a first step I would check that there is data being
> > transferred over the digital link to the CODEC, then look at the
> > audio routing to ensure that the signal is routed to the output.
>
> Thanks for suggestions..

If aplay exits with timeout, than it means that the clocks are not running. =

You can check the HW/SW pointers if they are moving while the playback is =

running:
cat /proc/asound/card0/pcm0p/sub0/status

-- =

P=E9ter
