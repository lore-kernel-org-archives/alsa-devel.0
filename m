From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 0/1] ASoC: TWL4030: Headset ramp down fix
Date: Tue, 12 May 2009 09:39:57 +0300
Message-ID: <20090512093957.eabd929c.jhnikula@gmail.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<dfeb90390905110557m79ce9a51n5b8b73e5a736d05b@mail.gmail.com>
	<2ee9e08d0905112059x52fc667fu91e7eb34082d3ad3@mail.gmail.com>
	<20090512083304.1d91f188.jhnikula@gmail.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03056015EE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 90B3F103820
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 08:38:18 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 26so852289eyw.56
	for <alsa-devel@alsa-project.org>; Mon, 11 May 2009 23:38:17 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03056015EE@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Anuj Aggarwal <anuj.aggarwal@gmail.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "sakoman@gmail.com" <sakoman@gmail.com>, Arun KS <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 12 May 2009 11:44:21 +0530
"Aggarwal, Anuj" <anuj.aggarwal@ti.com> wrote:

> > I haven't noticed (yet) but can you post your use case here how to
> > reproduce it. It would help to hunt is the problem OMAP & TWL4030
> > specific or is it somewhere else.
> [Aggarwal, Anuj] There is nothing specific to my use case. I am just 
> trying to playback an audio file (16bit, stereo, 44.1khz) and hearing 
> this sine-tonish sound everytime in the beginning.
> This artifact was not there when I was using ALSA; it started coming
> only when I moved to the newer ASoC framework.

What HW do you use for testing and what was the previous kernel having
ALSA drivers for it? Can you reproduce the problem with standard aplay
from alsa-utils?

For instance I'm curious to know can we have some unknown issue with the
1 ksample FIFO inside OMAP3 McBSP2 which is not handled right now with
the ASoC drivers but if the another kernel has workaround for it.


-- 
Jarkko
