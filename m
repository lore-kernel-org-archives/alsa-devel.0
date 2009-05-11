From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Headset VMID ramp fix
Date: Mon, 11 May 2009 10:36:32 +0100
Message-ID: <20090511093632.GA15990@rakim.wolfsonmicro.main>
References: <1241763077-6851-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090508165501.954a61e7.jhnikula@gmail.com>
	<20090508172322.53be8d2c.jhnikula@gmail.com>
	<200905110922.41837.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ED7F924738
	for <alsa-devel@alsa-project.org>;
	Mon, 11 May 2009 11:36:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200905110922.41837.peter.ujfalusi@nokia.com>
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
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, alsa-devel@alsa-project.org, "getarunks@gmail.com" <getarunks@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 11, 2009 at 09:22:41AM +0300, Peter Ujfalusi wrote:

> Mark: what do you think, is it acceptable to add a maximum of 27ms delay to 
> the hsol_event:SND_SOC_DAPM_POST_PMD event?

Yes, that's fine.
