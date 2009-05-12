From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: [PATCH 0/1] ASoC: TWL4030: Headset ramp down fix
Date: Tue, 12 May 2009 11:44:21 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03056015EE@dbde02.ent.ti.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<dfeb90390905110557m79ce9a51n5b8b73e5a736d05b@mail.gmail.com>
	<2ee9e08d0905112059x52fc667fu91e7eb34082d3ad3@mail.gmail.com>
	<20090512083304.1d91f188.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 2253B246B5
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 08:14:34 +0200 (CEST)
In-Reply-To: <20090512083304.1d91f188.jhnikula@gmail.com>
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
> Sent: Tuesday, May 12, 2009 11:03 AM
> To: Anuj Aggarwal
> Cc: Arun KS; Peter Ujfalusi; sakoman@gmail.com; Aggarwal, Anuj; alsa-
> devel@alsa-project.org; broonie@opensource.wolfsonmicro.com; Aarti Dewan
> (Corp HR), Noida
> Subject: Re: [alsa-devel] [PATCH 0/1] ASoC: TWL4030: Headset ramp down
> fix
> 
> On Tue, 12 May 2009 09:29:55 +0530
> Anuj Aggarwal <anuj.aggarwal@gmail.com> wrote:
> 
> > Moreover, I am hearing a sine-tonish kind of sound, always in the
> > beginning. It lasts only for less than a sec but is very prominent
> > and occurs always.
> >
> > Has anyone noticed this too?
> >
> I haven't noticed (yet) but can you post your use case here how to
> reproduce it. It would help to hunt is the problem OMAP & TWL4030
> specific or is it somewhere else.
[Aggarwal, Anuj] There is nothing specific to my use case. I am just 
trying to playback an audio file (16bit, stereo, 44.1khz) and hearing 
this sine-tonish sound everytime in the beginning.
This artifact was not there when I was using ALSA; it started coming
only when I moved to the newer ASoC framework.
> 
> 
> --
> Jarkko
