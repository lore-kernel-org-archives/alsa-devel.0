From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: [PATCH 0/2] ASoC: TWL4030: DAPM restructuring
	and	Headset pop-attenuation fix
Date: Mon, 18 May 2009 20:58:52 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03056A148C@dbde02.ent.ti.com>
References: <1242651725-15001-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090518130928.GD1629@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 828D810383B
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 17:29:05 +0200 (CEST)
In-Reply-To: <20090518130928.GD1629@sirena.org.uk>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "getarunks@gmail.com" <getarunks@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Monday, May 18, 2009 6:39 PM
> To: Peter Ujfalusi
> Cc: alsa-devel@alsa-project.org; sakoman@gmail.com; Aggarwal, Anuj;
> getarunks@gmail.com
> Subject: Re: [alsa-devel] [PATCH 0/2] ASoC: TWL4030: DAPM restructuring
> and Headset pop-attenuation fix
> 
> On Mon, May 18, 2009 at 04:02:03PM +0300, Peter Ujfalusi wrote:
> 
> > The following series aims to fix the Headset power on/off pop noise
> problems.
> 
> Looks OK but given all the to and fro here I'd rather wait for some
> testing to make sure it works well on other system.s
[Aggarwal, Anuj] I tried this on OMAP3 EVM. Ramp delay values 0-3 produces minor glitches in the beginning & end, value 4 gave me the best result so far on my EVM, I will try with some other EVMs as well before finalizing it. 5 and others produce a beep in the beginning and end.
Just one question, is there any side-effect of choosing a large ramp delay? For e.g. in my case, it could be 437ms (19.2MHz clock).
> 
> > I needed to move the APGA control from SND_SOC_DAPM_PGA to be
> handled with
> > _MIXER. Than adding a PGA to the headset outputs results correct power
> > sequences.
> 
> TBH it sounds like this is actually a mixer anyway - typically mixers do
> have some gain controls associated with them, the sort of PGA DAPM means
> is more an output stage driver.  Typically these have much more control
> of the gain and only one input and output.
