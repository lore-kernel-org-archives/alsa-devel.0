From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH] ASoC: TWL4030: Disable DACs in analog
 loopback
Date: Thu, 30 Apr 2009 05:53:19 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705F63E05C4@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F63E05BA@dlee07.ent.ti.com>
	<200904301146.49080.peter.ujfalusi@nokia.com>
	<2C7D3DF36ADFFC479B44490D912B616705F63E05BE@dlee07.ent.ti.com>
	<200904301328.48853.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FC271037FA
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Apr 2009 12:53:27 +0200 (CEST)
In-Reply-To: <200904301328.48853.peter.ujfalusi@nokia.com>
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
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


> > > But I'm afraid, this patch does break the Digital loopback,
> > > which needs the DACs to be powered, in case when the capture
> > > path is set in analog mode the ADC(s) also need to be powered.

> > I think that digital loopback should mix TX with RX only when
> > both digital paths are enabled, i.e. in a full-duplex scenario.

> Well, yes... short of. You can still enable the digital 
> loopback without active stream. The TWL codec will be in the same
> state as it if you are using full duplex mode. The only difference
> is that the CPU dai is not running.
> The analog loopback also mixing the RX and TX data, but in 
> the analog domain. If you have only the loopback enabled (analog or
> digital) the RX path is silent in both cases...

I got your point, thanks for the explanation. I think that we can take
this part of the patch:

+	/* Enable master analog loopback mode if any analog switch is enabled*/
+	misc = twl4030_read_reg_cache(w->codec, TWL4030_REG_MISC_SET_1);
+	if (twl4030->bypass_state & 0xF)
+		misc |= TWL4030_FMLOOP_EN;
+	else
+		misc &= ~TWL4030_FMLOOP_EN;
+	twl4030_write(w->codec, TWL4030_REG_MISC_SET_1, misc);

This bit MISC_SET_1[FMLOOP_EN] needs to set to 1 when any of the analog
bypass switches are enabled. Without setting this bit, the loopback is
kind of weak.

If it's fine for you, I can create a new patch for supporting the
VDL analog bypass switch and add above change in that same patch.
