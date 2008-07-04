From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/3] ALSA SoC: Add OpenFirmware helper for
	matching bus and codec drivers
Date: Fri, 4 Jul 2008 07:05:17 -0400
Message-ID: <FECB7589-9A1B-48E5-805F-4253E6FECC9F@freescale.com>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<9e4733910807020827k115fe63r7a0dd09daffc1895@mail.gmail.com>
	<20080703163351.GJ2284@secretlab.ca>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id AAA82103800
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jul 2008 13:01:29 +0200 (CEST)
In-Reply-To: <20080703163351.GJ2284@secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, linuxppc-dev@ozlabs.org
List-Id: alsa-devel@alsa-project.org


On Jul 3, 2008, at 12:33 PM, Grant Likely wrote:

> Yes, but you hadn't written these functions when I wrote this helper.
> :-P.  I believe ASoC v2 makes all this stuff unnecessary, but I'm
> waiting for v2 to hit mainline before I port forward.

FYI, it took me about a month to port my drivers to ASoC V2.  I had  
more work than most people because I addressed issues that others  
drivers didn't.  For instance, my CS4270 driver is the only codec  
driver in V2 that supports multiple instances of itself.
