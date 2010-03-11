From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: tlv320dac33 fixes
Date: Thu, 11 Mar 2010 17:07:38 +0200
Message-ID: <20100311170738.a91bff10.jhnikula@gmail.com>
References: <1268317582-10284-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100311164628.f6c08a0b.jhnikula@gmail.com>
	<201003111655.12504.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f219.google.com (mail-ew0-f219.google.com
	[209.85.219.219])
	by alsa0.perex.cz (Postfix) with ESMTP id 8EA6E24366
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 16:06:18 +0100 (CET)
Received: by ewy19 with SMTP id 19so55004ewy.22
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 07:06:18 -0800 (PST)
In-Reply-To: <201003111655.12504.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Mar 2010 16:55:12 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> > Just curious: what would happen if the BCLK is cut while the McBSP is
> > operating?
> 
> The symptom is that we can not access to McBSP register address space causing 
> kernel panic, which can only be fixed by rebooting the device.
> The burst driven BCLK causes some internal state machine to stuck, leaving the 
> given McBSP port dead from the outside. Other ports operate after this event.
> Obviously this only bites in McBSP slave mode, and with codec like DAC33 which 
> have burst mode, in other cases the BCLK is always running (or McBSP is master).
> 
> > I'm thinking are there also other similar problems, e.g. if
> > the rate is not correct.
> 
> Hmmm, could be possible, but I did not experienced with such a problem.
> 
Thanks for sharing this info.

Sounds exactly similar problem what I encountered once with the OMAP2420
and EAC. I didn't debug that problem any further then but there also
some register accesses (not all) caused kernel panic if the external
clock was missing or if the rate wasn't correct.


-- 
Jarkko
