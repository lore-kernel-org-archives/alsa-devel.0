From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: ALSA patch Nvidia 8 channel hdmi audio
Date: Wed, 3 Jun 2009 02:00:54 +0200
Message-ID: <200906030200.54455.marek.vasut@gmail.com>
References: <410e92830906021458x3d47a1d6jebba8bbe1150e76d@mail.gmail.com>
	<200906030022.07693.marek.vasut@gmail.com>
	<410e92830906021530l767478c4tae72c4b161583b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id D3378244FD
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 02:00:55 +0200 (CEST)
Received: by fxm18 with SMTP id 18so9222272fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 02 Jun 2009 17:00:54 -0700 (PDT)
In-Reply-To: <410e92830906021530l767478c4tae72c4b161583b6@mail.gmail.com>
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
To: Alan Alan <alanwww1@gmail.com>
Cc: alsa-devel@alsa-project.org, Wei Ni <wni@nvidia.com>
List-Id: alsa-devel@alsa-project.org

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
