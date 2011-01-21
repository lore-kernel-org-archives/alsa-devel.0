From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: UCM questions
Date: Fri, 21 Jan 2011 23:37:08 +0000
Message-ID: <1295653028.3348.698.camel@odin>
References: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
	<20110121113744.GA18682@sirena.org.uk> <1295623491.3348.284.camel@odin>
	<AANLkTi=V9ouox2vp5VYA+_gmsOCCecBKOjpd58DsuaxK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 9F5D424439
	for <alsa-devel@alsa-project.org>; Sat, 22 Jan 2011 00:37:12 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 11so2364851wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 15:37:12 -0800 (PST)
In-Reply-To: <AANLkTi=V9ouox2vp5VYA+_gmsOCCecBKOjpd58DsuaxK@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-01-21 at 15:03 -0600, pl bossart wrote:
> > Originally, verbs were mapped 1:1 with cards, however Jaroslav recently
> > added support for multiple cards per verb.
> 
> Does this mean for a given verb UCM will return a list of devices on
> different cards that can be used, and the application will choose from
> the list?

UCM does return the appropriate sink and source PCM device for the given
use case if required. e.g the OMAP4 has multiple PCM devices, some are
for high quality hifi whilst others are lower power tones. 

>  Or are these multiple cards supposed to be used
> simultaneously?
> I probably need more expresso here..

It's to allow multiple cards to be used simultaneously, e.g. a use case
could also involve aspects of two sound cards, maybe one for capture and
the other for playback.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
