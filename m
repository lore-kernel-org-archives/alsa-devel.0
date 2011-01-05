From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: omap: rx51: Add stereo output
 support to audio jack
Date: Wed, 5 Jan 2011 18:29:24 +0200
Message-ID: <20110105182924.cf90b12c.jhnikula@gmail.com>
References: <1294242360-1903-1-git-send-email-jhnikula@gmail.com>
	<20110105155509.GC746@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id F3A5C243AF
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 17:29:05 +0100 (CET)
Received: by ewy19 with SMTP id 19so6389850ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 05 Jan 2011 08:29:04 -0800 (PST)
In-Reply-To: <20110105155509.GC746@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Peter@alsa-project.org, Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 5 Jan 2011 15:55:09 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, Jan 05, 2011 at 05:46:00PM +0200, Jarkko Nikula wrote:
> 
> > This support could have been implemented earlier but I was targeting to have
> > ASoC cross-device support first. But as there's no DAPM widgets anymore in
> > TPA6130, I don't see any other way to implement this than by registering TPA6130
> > controls to aic34a with tpa6130a2_add_controls and by using
> > tpa6130a2_stereo_enable.
> 
> Having thought about it for at least a second I think we should have a
> DAPM context in the cards for all the board-level stuff - does that seem
> resonable?  The patch itself looks good:
> 
I don't know. Probably it would be good if machine widgets are in own
context. Like having own debugfs/sysfs directory for them etc.

In this case it would be just enough if the tpa6130 is a codec driver
having DAPM widgets. Then machine driver wouldn't need any these
exported special tpa6130a2_ functions and soc-dapm could take care of
power changes according to audio map and other info.

But as far as I understood there's no any better way to get rid of pops
in tpa6130a2.


-- 
Jarkko
