From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 2/3] ASoC: dapm: Use DAPM mutex for DAPM
 ops instead of codec mutex.
Date: Thu, 08 Mar 2012 11:23:45 +0000
Message-ID: <1331205825.3782.0.camel@odin>
References: <1331116707-10016-1-git-send-email-lrg@ti.com>
	<1331116707-10016-2-git-send-email-lrg@ti.com>
	<20120307194604.GH3107@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
	[74.125.149.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A70D10B9FA
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 12:23:49 +0100 (CET)
Received: by mail-ww0-f49.google.com with SMTP id dr1so232598wgb.18
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 03:23:47 -0800 (PST)
In-Reply-To: <20120307194604.GH3107@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-03-07 at 19:46 +0000, Mark Brown wrote:
> On Wed, Mar 07, 2012 at 10:38:26AM +0000, Liam Girdwood wrote:
> 
> Applied, thanks.
> 
> > +enum snd_soc_dapm_subclass {
> > +	SND_SOC_DAPM_CLASS_INIT	= 0,
> > +	SND_SOC_DAPM_CLASS_PCM	= 1,
> 
> I think I'd rather this were called _RUNTIME or something, we may not
> have a stream involved at all in some cases.

I'll update this incrementally.

Liam
