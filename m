From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dapm: Convert pin switches to use
	snd_soc_card
Date: Wed, 15 Feb 2012 18:11:14 +0000
Message-ID: <1329329474.14552.3.camel@odin>
References: <1329268340-25342-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329300564.7841.3.camel@odin>
	<20120215163608.GI2996@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog126.obsmtp.com (na3sys009aog126.obsmtp.com
	[74.125.149.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A8FA1039BC
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 19:19:38 +0100 (CET)
Received: by wibhm14 with SMTP id hm14so958490wib.37
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 10:17:57 -0800 (PST)
In-Reply-To: <20120215163608.GI2996@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-02-15 at 08:36 -0800, Mark Brown wrote:
> On Wed, Feb 15, 2012 at 10:09:24AM +0000, Liam Girdwood wrote:
> 
> > I covered all the machine drivers who directly used the old API with the
> > original patch but I'll also do some further audit for indirect users
> > like the pin switch.
> 
> Hrm, what about those that use the table based init?  I just did a spot
> check on spitz and it's still expecting to get a snd_soc_codec back.
> 
> But now I need breakfast... 

A lucky check ;-) It looks like spitz was the only one missing the
update as the other table inits are all fine. Patch forthcoming...

Liam
