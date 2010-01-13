From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoC: support more sample rates on
	raumfeld devices
Date: Wed, 13 Jan 2010 09:35:55 -0600
Message-ID: <4B4DE85B.6020502@freescale.com>
References: <1263378338-21791-1-git-send-email-daniel@caiaq.de>
	<20100113130208.GD27473@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id E95B4103844
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 16:36:12 +0100 (CET)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o0DFZuXx025762
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 08:36:06 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o0DFf93l001270
	for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2010 09:41:10 -0600 (CST)
In-Reply-To: <20100113130208.GD27473@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Wed, Jan 13, 2010 at 11:25:38AM +0100, Daniel Mack wrote:
>> Add support for sample rates other than 44100Khz on raumfeld audio
>> devices. Force the codec's supported sample rates as the table of
>> supported rates which is calculated at run-time does not suffice: if we
>> call snd_soc_dai_set_sysclk() at stream startup, half of the possible
>> rates are missing.
> 
> I'm not massively enthusiastic about this - I'd much rather be able to
> give the CODEC a hook to let it know what MCLK rates it can have and a
> callback to update them.  It's a perfect case for the clock API but of
> course we can't use that off-SoC :/

This is how I was planning on doing it for the P1022DS.

-- 
Timur Tabi
Linux kernel developer at Freescale
