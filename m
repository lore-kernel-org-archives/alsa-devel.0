From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 2/3] ASoC: soc-dapm: API to attach
 DAPM_SUPPLY to be used for dai
Date: Fri, 26 Aug 2011 20:05:02 +0100
Message-ID: <20110826190420.GA2943@opensource.wolfsonmicro.com>
References: <1314365603-8947-1-git-send-email-peter.ujfalusi@ti.com>
	<1314365603-8947-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BEF4F247E6
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 21:05:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314365603-8947-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 26, 2011 at 04:33:22PM +0300, Peter Ujfalusi wrote:
> There are cpu dais, which require special ordering during stream
> stop (OMAP4's McPDM interface for example) in a system level.
> OMAP4 McPDM required to be stopped after the attached codec's
> (twl6040) DAC/ADC has been stopped.

> This requironment can be solved with a use of DAPM_SUPPLY
> widget attached to the codec's ADC/DAC from machine driver.

This wasn't really what I meant - what I meant was that we ought to be
able to change the ordering of DAPM with regard to the stream shutdown
without having to have anything more than flags in the devices that can
or need to do it (I'd expect more the CODECs more than the CPUs).
