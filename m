From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: [PATCH 0/1] ASoC: TWL4030: Headset ramp down fix
Date: Tue, 12 May 2009 12:20:29 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0305601625@dbde02.ent.ti.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<dfeb90390905110557m79ce9a51n5b8b73e5a736d05b@mail.gmail.com>
	<2ee9e08d0905112059x52fc667fu91e7eb34082d3ad3@mail.gmail.com>
	<20090512083304.1d91f188.jhnikula@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03056015EE@dbde02.ent.ti.com>
	<20090512093957.eabd929c.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id ABC6110382B
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 08:50:40 +0200 (CEST)
In-Reply-To: <20090512093957.eabd929c.jhnikula@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Anuj Aggarwal <anuj.aggarwal@gmail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "sakoman@gmail.com" <sakoman@gmail.com>, Arun KS <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Jarkko Nikula [mailto:jhnikula@gmail.com]
> Sent: Tuesday, May 12, 2009 12:10 PM
> To: Aggarwal, Anuj
> Cc: Arun KS; Peter Ujfalusi; sakoman@gmail.com; alsa-devel@alsa-
> project.org; broonie@opensource.wolfsonmicro.com; Anuj Aggarwal
> Subject: Re: [alsa-devel] [PATCH 0/1] ASoC: TWL4030: Headset ramp down
> fix
> 
> On Tue, 12 May 2009 11:44:21 +0530
> "Aggarwal, Anuj" <anuj.aggarwal@ti.com> wrote:
> 
> > > I haven't noticed (yet) but can you post your use case here how to
> > > reproduce it. It would help to hunt is the problem OMAP & TWL4030
> > > specific or is it somewhere else.
> > [Aggarwal, Anuj] There is nothing specific to my use case. I am just
> > trying to playback an audio file (16bit, stereo, 44.1khz) and hearing
> > this sine-tonish sound everytime in the beginning.
> > This artifact was not there when I was using ALSA; it started coming
> > only when I moved to the newer ASoC framework.
> 
> What HW do you use for testing and what was the previous kernel having
> ALSA drivers for it? Can you reproduce the problem with standard aplay
> from alsa-utils?
> 
> For instance I'm curious to know can we have some unknown issue with the
> 1 ksample FIFO inside OMAP3 McBSP2 which is not handled right now with
> the ASoC drivers but if the another kernel has workaround for it.
[Aggarwal, Anuj] I am currently working on OMAP3 EVM, on 2.6.29-rc3 kernel. The previous kernel version where I was using ALSA was 2.6.22. I am using aplay only and observing this artifact on ASoC alone.
> 
> 
> --
> Jarkko
