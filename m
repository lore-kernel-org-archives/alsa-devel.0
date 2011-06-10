From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Do not attempt to change
 DAI sysclk if stream is active
Date: Fri, 10 Jun 2011 15:37:54 +0300
Message-ID: <20110610153754.3c91a03c.jhnikula@gmail.com>
References: <1307705335-2836-1-git-send-email-jhnikula@gmail.com>
	<20110610113529.GJ26436@opensource.wolfsonmicro.com>
	<20110610145610.a2061e74.jhnikula@gmail.com>
	<20110610115954.GK26436@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0175C103827
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jun 2011 14:36:45 +0200 (CEST)
Received: by ewy6 with SMTP id 6so906036ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2011 05:36:45 -0700 (PDT)
In-Reply-To: <20110610115954.GK26436@opensource.wolfsonmicro.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, stable@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 10 Jun 2011 12:59:54 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Jun 10, 2011 at 02:56:10PM +0300, Jarkko Nikula wrote:
> 
> > I was thinking to return -EBUSY here but went thinking is it really
> > worth of trouble? Machine drivers are calling this from their hw_params
> > callback  with the same configuration always (I suppose) for both
> > playback and capture and it sounded kind of overkill to check what is
> > existing configuration or skip the -EBUSY error.
> 
> One fairly common case is selecting the system clock rate to a fixed
> multiple of the sample rate so applications that try to set up different
> playback and record rates trigger issues.

Umm, yeah. I'll cook another version which returns -EBUSY but still
trying to keep this regression fix minimal. Anyway it's only pandora
that can trigger the regression in mainline.

-- 
Jarkko
