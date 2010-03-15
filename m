From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [PATCH 2/2] Quick fix for the audio clocks on
	SAM9-L9261
Date: Mon, 15 Mar 2010 10:32:58 +0000
Message-ID: <201003151032.58958.gineera@aspect135.co.uk>
References: <20100312105817.4392b594@rechenknecht2k7>
	<20100312110032.2e57fdce@rechenknecht2k7>
	<20100312110241.3d97237b@rechenknecht2k7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip05ir2.opaltelecom.net (out1.ip05ir2.opaltelecom.net
	[62.24.128.241]) by alsa0.perex.cz (Postfix) with ESMTP id 11E4724490
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 11:33:06 +0100 (CET)
In-Reply-To: <20100312110241.3d97237b@rechenknecht2k7>
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
To: Benjamin Valentin <benpicco@zedat.fu-berlin.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Friday 12 March 2010 10:02, Benjamin Valentin wrote:
> Signed-off-by: Dimitar Dimitrov <dimitar@olimex.com>
>
> From 10a85229b2357c89d5170efde5ac0e1cba4c9f9e Mon Sep 17 00:00:00 2001
> From: Dimitar Dimitrov <dimitar@olimex.com>
> Date: Wed, 27 May 2009 08:11:37 +0300
> Subject: [PATCH] Quick fix for the audio clocks on SAM9-L9261
>
> This patch together with support from SAM9-L9261 hardware fix an issue with
> audio clocks. AT73C213 needs MCLK and BCLK with equal phase. The MCLK from
> AT91SAM9XXX clock output and BCLK from the SSC TK clock output are not
> phase-synchronized. Thus the SAM9-L9261 board provides external hardware
> divison by 8 from MCLK to BCLK, ensuring zero phase difference.
>
> See: http://www.at91.com/phpbb/viewtopic.php?t=2633

I am interested to examine this issue, but the link seems dead; is the info 
available elsewhere?

Thanks

Alan
