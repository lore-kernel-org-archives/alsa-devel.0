From: Timur Tabi <timur@freescale.com>
Subject: Re: How can I make sure the period size is a multiple
 of 16?
Date: Thu, 06 Sep 2007 12:07:11 -0500
Message-ID: <46E033BF.1010104@freescale.com>
References: <46DDE137.2070507@freescale.com>
	<200709051229.54852.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 10BD2103811
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 19:07:15 +0200 (CEST)
In-Reply-To: <200709051229.54852.linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Eliot Blennerhassett wrote:

> You need to add some constraints to your driver, in the open callback.
> E.g.
> snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 16);

Thanks.  snd_pcm_hw_constraint_step() is not documented anywhere, and the 
comments in the source code don't provide any clues, either.  Even the "ALSA 
Driver API" document just lists the function, but doesn't actually tell you 
what it does.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
