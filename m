From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: When closing the port
 select PRCM source for CLKS signal
Date: Mon, 05 Mar 2012 14:33:25 +0200
Message-ID: <4F54B295.8090802@ti.com>
References: <1330940332-16188-1-git-send-email-peter.ujfalusi@ti.com>
	<20120305115808.GD3224@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from psmtp.com (na3sys009aog132.obsmtp.com [74.125.149.250])
	by alsa0.perex.cz (Postfix) with ESMTP id D7331244CF
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 13:33:21 +0100 (CET)
Received: by mail-lpp01m010-f41.google.com with SMTP id z14so6450206lag.14
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 04:33:19 -0800 (PST)
In-Reply-To: <20120305115808.GD3224@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 03/05/2012 01:58 PM, Mark Brown wrote:
> though it'd be better if the driver could remember and restore the
> setting when the device becomes active again so that machine drivers
> don't need to.

Yes, this is my long term plan regarding to the clock selection.
With this patch the omap3pandora can suspend after audio activity.

-- =

P=E9ter
