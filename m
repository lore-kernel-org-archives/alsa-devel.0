From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 0/2] ASoC: TWL4030: DAPM restructuring and
	Headset pop-attenuation fix
Date: Tue, 19 May 2009 09:46:40 +0300
Message-ID: <200905190946.40358.peter.ujfalusi@nokia.com>
References: <1242651725-15001-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090518130928.GD1629@sirena.org.uk>
	<5A47E75E594F054BAF48C5E4FC4B92AB03056A148C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id CA433244DA
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 08:47:02 +0200 (CEST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03056A148C@dbde02.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Monday 18 May 2009 18:28:52 ext Aggarwal, Anuj wrote:

> [Aggarwal, Anuj] I tried this on OMAP3 EVM. Ramp delay values 0-3 produces
> minor glitches in the beginning & end, value 4 gave me the best result so
> far on my EVM, I will try with some other EVMs as well before finalizing
> it. 5 and others produce a beep in the beginning and end. Just one
> question, is there any side-effect of choosing a large ramp delay? For e.=
g.
> in my case, it could be 437ms (19.2MHz clock).

It is less than half a second ;)
I'm not sure, but we could try later to add a timer to finish up the ramp-
down.
There could be (not foreseen) side effects...
At this point I think this (series) is a good start and it is better than w=
hat =

we had.

BTW: I'll wait for the verdict on the series and I will send a fix for the =

Handsfree pop attenuation also.

-- =

P=E9ter
