From: "Wei Ni" <wni@nvidia.com>
Subject: Re: ALSA patch Nvidia 8 channel hdmi audio
Date: Wed, 3 Jun 2009 15:14:19 +0800
Message-ID: <15F501D1A78BD343BE8F4D8DB854566B058A63F1@hkemmail01.nvidia.com>
References: <410e92830906021458x3d47a1d6jebba8bbe1150e76d@mail.gmail.com>
	<200906030022.07693.marek.vasut@gmail.com>
	<410e92830906021530l767478c4tae72c4b161583b6@mail.gmail.com>
	<200906030200.54455.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.112.152])
	by alsa0.perex.cz (Postfix) with ESMTP id A36742463F
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 09:14:26 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <200906030200.54455.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>, Alan Alan <alanwww1@gmail.com>
Cc: Peer Chen <pchen@nvidia.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, Marek and Alan
I'm a Nvidia engineer and develop this patch file.

I used mplayer to test. The channels are mapped good.
Running mplayer -ao alsa:device=hw=0.3 6ch.wav

I tried to use speaker-test to test, but I can't get the hdmi device name.
I used speaker-test -Dsurround51:NVidia -c6, the sound output from the analog jack.
Which device name should I use?

I use aplay -l, it show
**** List of PLAYBACK Hardware Devices ****
card 0: NVidia [HDA NVidia], device 0: ALC1200 Analog [ALC1200 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 1: ALC1200 Digital [ALC1200 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: NVidia [HDA NVidia], device 3: NVIDIA HDMI [NVIDIA HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

Thanks
Wei.

-----Original Message-----
From: Marek Vasut [mailto:marek.vasut@gmail.com] 
Sent: Wednesday, June 03, 2009 8:01 AM
To: Alan Alan
Cc: alsa-devel@alsa-project.org; Wei Ni
Subject: Re: ALSA patch Nvidia 8 channel hdmi audio

On Wednesday 03 of June 2009 00:30:04 Alan Alan wrote:
> Thank's for the info.
> How can i contact him ?

He and alsa-devel mailing list are both in CC already, please preserve them 
there or fix your mailer.
>
>
> 2009/6/3 Marek Vasut <marek.vasut@gmail.com>
>
> > I'm not the author of the patch, CCing alsa-devel and the original
> > author.
> >
> > On Tuesday 02 of June 2009 23:58:26 Alan Alan wrote:
> > > Hi Marek !
> > >
> > > I just read your emailing with nvidia devs about alsa supporting 8
> >
> > channel
> >
> > > lpcm over hdmi.
> > >
> > > I checked it out an i have to tell it is working awsome, except for a
> > > few bugs:
> > >
> > > The channels are wrong mapped. Running a speakertest -Dhdmi -c6 gives
> > > the following result (first where it should sound)
> > > FL - FL
> > > C - RL
> > > FR - FR
> > > RR - LFE
> > > RL - C
> > >
> > > The other thing i realized that playback is limited to 16 bits 48 khz.
> > > I think the minimum which is supported by nvidia hardware is 24bits 96
> > > (or 192) khz.
> > > Why not ?
> > >
> > > Could you contact the devs as i don't know how to reach them.
> > >
> > > ps.: Mybe my build methot was not 100% ok ? I used 1.020 Alsa with the
> > > oatched nvidia.c file. Anyway the amplifier shows multichannel LPCM and
> > > that's great news.



-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
