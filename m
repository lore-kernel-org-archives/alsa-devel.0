From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC don't apply] ASoC: Add support for optional
 auxiliary dailess codecs
Date: Fri, 26 Nov 2010 16:14:59 +0200
Message-ID: <20101126161459.0ae9d973.jhnikula@gmail.com>
References: <1290700058-9270-1-git-send-email-jhnikula@gmail.com>
	<20101126153548.a5a5f3c6.jhnikula@gmail.com>
	<20101126134151.GF30360@rakim.wolfsonmicro.main>
	<201011261555.34396.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 28AF7103D26
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 15:14:34 +0100 (CET)
Received: by eyg24 with SMTP id 24so979517eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 06:14:33 -0800 (PST)
In-Reply-To: <201011261555.34396.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 26 Nov 2010 15:55:34 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> > That's pretty much where I'm coming from - we already have most of the
> > infrastructure, we just need to get the devices into the system but once
> > we do that we should be able to cope with everything already.
> 
> So, if let's say I rewrite the tpa6130a2 driver as DAIless CODEC driver, and 
> connect to a system, where we already have a proper codec. What should I expect?
> Can this work with 'reasonable' ;) amount of work (or non) on the core side?
> 
I'm happy to hear does it work or not :-)

Basically you would need the cross-device set [1] and this RFC. The
corss-device set has some trivial merge issues I think now but I can
send you an updated version if you like. We don't want to merge
cross-device set before a problem with DAPMless codecs is solved.

Then in your machine driver you need to have this struct
snd_soc_aux_dev for tpa6130a2 and machine init for it would just add a
map that connects output of DAI codec into input of tpa6130a2 and call
snd_soc_dapm_sync as usual.


-- 
Jarkko
1.
http://mailman.alsa-project.org/pipermail/alsa-devel/2010-November/033583.html
