From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: TWL4030: DAPM restructuring and
 Headset pop-attenuation fix
Date: Tue, 19 May 2009 10:33:16 +0300
Message-ID: <20090519103316.7b1ed16b.jhnikula@gmail.com>
References: <1242651725-15001-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090518130928.GD1629@sirena.org.uk>
	<5A47E75E594F054BAF48C5E4FC4B92AB03056A148C@dbde02.ent.ti.com>
	<200905190946.40358.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f175.google.com (mail-ew0-f175.google.com
	[209.85.219.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 0DA3324664
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 09:31:04 +0200 (CEST)
Received: by ewy23 with SMTP id 23so4672044ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 19 May 2009 00:31:03 -0700 (PDT)
In-Reply-To: <200905190946.40358.peter.ujfalusi@nokia.com>
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
Cc: "ext Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 19 May 2009 09:46:40 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> On Monday 18 May 2009 18:28:52 ext Aggarwal, Anuj wrote:
> 
> > [Aggarwal, Anuj] I tried this on OMAP3 EVM. Ramp delay values 0-3
> > produces minor glitches in the beginning & end, value 4 gave me the
> > best result so far on my EVM, I will try with some other EVMs as
> > well before finalizing it. 5 and others produce a beep in the
> > beginning and end. Just one question, is there any side-effect of
> > choosing a large ramp delay? For e.g. in my case, it could be 437ms
> > (19.2MHz clock).
> 
> It is less than half a second ;)
> I'm not sure, but we could try later to add a timer to finish up the
> ramp- down.
> There could be (not foreseen) side effects...
> At this point I think this (series) is a good start and it is better
> than what we had.
> 
For my Beagle the power-up/-down low-frequency pop goes more silent as
the ramp time increases. Sharp power-down snap is there with '27/20/14
ms' and '55/40/27 ms' but not times above.

Beep sound is here when ramp is '109/81/55 ms' and above. As ramp time
increases, the beep sound frequency goes down. Codec HW issue?

I don't have any objections to these two patches and as the music still
plays fine so probably these can be pushed in safely.


-- 
Jarkko
