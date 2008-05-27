From: Peter Wurmsdobler <peter@wurmsdobler.org>
Subject: Re: Digital Audio Multiplexer of the i.MX27 processor
Date: Wed, 28 May 2008 00:03:12 +0100
Message-ID: <483C9330.6040402@wurmsdobler.org>
References: <200805271713.49868.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox84.server-home.net (webbox84.server-home.net
	[195.137.212.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 68A6E244EE
	for <alsa-devel@alsa-project.org>;
	Wed, 28 May 2008 01:03:12 +0200 (CEST)
In-Reply-To: <200805271713.49868.jbe@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Juergen Beisert <jbe@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Juergen,
> does anybody understand the DAM unit in the i.MX27 processor?
Not that I really understand the AUDMUX unit, but the current Freescale 
BSP (19 Dec 2007) contains an audio/alsa driver which makes use of the 
AUDMUX, or DAM, in order to route audio streams to/from the mx27's SSI1 
and SSI2 to the PMIC's SSIs. PMIC is a the power management and audio 
chip which is on the ADS board. Unfortunately I do not have the file 
with me, it is called ./sound/arm/mxc-pmic-alsa.c I believe.

I will be back in office next week, maybe we can have a chat then, if it 
is not too late.

Regards,
peter
