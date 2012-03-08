From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: omap McBSP: Clear rx_irq at probe
 time for OMAP4
Date: Thu, 08 Mar 2012 09:00:50 +0200
Message-ID: <4F585922.10607@bitmer.com>
References: <1331111839-14778-1-git-send-email-peter.ujfalusi@ti.com>
	<1331113708.3539.10.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F7B610B99A
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 08:00:47 +0100 (CET)
In-Reply-To: <1331113708.3539.10.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 03/07/2012 11:48 AM, Paul Menzel wrote:
> Dear Peter,
> 
> 
> Am Mittwoch, den 07.03.2012, 11:17 +0200 schrieb Peter Ujfalusi:
>> On OMAP4 we have one interrupt line per McBSP port.
>> At proble time tx, and rx irq value will be -ENXIO,
> 
> s/proble/probe/
> 
I think I have acked this earlier to plat-omap/mcbsp.c. You could add my
ack here

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
