From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH 0/2] ASoC: TWL4030: DAPM
	restructuring	and	Headset pop-attenuation fix
Date: Mon, 18 May 2009 19:48:25 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705F69E87E2@dlee07.ent.ti.com>
References: <1242651725-15001-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090518130928.GD1629@sirena.org.uk>
	<5A47E75E594F054BAF48C5E4FC4B92AB03056A148C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id A31C72455A
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 02:48:37 +0200 (CEST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03056A148C@dbde02.ent.ti.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

> > > The following series aims to fix the Headset power on/off 
> > > pop noise problems.

> > Looks OK but given all the to and fro here I'd rather wait for some 
> > testing to make sure it works well on other system.s

> [Aggarwal, Anuj] I tried this on OMAP3 EVM. Ramp delay values 
> 0-3 produces minor glitches in the beginning & end, value 4 
> gave me the best result so far on my EVM, I will try with 
> some other EVMs as well before finalizing it. 5 and others 
> produce a beep in the beginning and end.
> Just one question, is there any side-effect of choosing a 
> large ramp delay? For e.g. in my case, it could be 437ms 
> (19.2MHz clock).

I tested on SDP3430, the best ramp delay value for my board seems to
be 3. Lower values give glitches and higher values present the beep
sound. In general, it has been reduced.

-Misa
