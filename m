From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoC V2: restrict sample rate and
 size in Freescale MPC8610 sound drivers
Date: Mon, 04 Aug 2008 12:35:39 -0500
Message-ID: <48973DEB.3010101@freescale.com>
References: <1217867506-19730-1-git-send-email-timur@freescale.com>
	<20080804164337.GA4193@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id CABD124338
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Aug 2008 19:35:44 +0200 (CEST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m74HZf7Z001426
	for <alsa-devel@alsa-project.org>; Mon, 4 Aug 2008 10:35:41 -0700 (MST)
In-Reply-To: <20080804164337.GA4193@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Mon, Aug 04, 2008 at 11:31:46AM -0500, Timur Tabi wrote:
> 
>> A future version of this driver will lift the sample size restriction.
>> Supporting independent sample rates is more difficult, because only certain
>> codecs provide dual independent clocks.
> 
> Generally the approach here is for the platform drivers to allow as much
> flexability as they can and rely on the codec and/or machine drivers to
> restrict things as needed.  Even where both codec and platform can
> support separate clocks they can be made shared by the board design.

In order for me to get the SSI to handle dual clock signals, I need actual
hardware that implements those signals so that I can test it.

-- 
Timur Tabi
Linux kernel developer at Freescale
