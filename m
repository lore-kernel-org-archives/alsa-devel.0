From: Timur Tabi <timur@freescale.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Tue, 29 May 2007 13:10:09 -0500
Message-ID: <465C6C81.2060105@freescale.com>
References: <46531097.5040600@freescale.com>	
	<1179934677.12071.30.camel@a10072.wolfsonmicro.main>	
	<46574453.10808@freescale.com>	
	<1180354247.5816.30.camel@a10072.wolfsonmicro.main>	
	<465B716F.7090908@freescale.com>
	<1180428790.5816.76.camel@a10072.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 77089243C2
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 20:10:14 +0200 (CEST)
In-Reply-To: <1180428790.5816.76.camel@a10072.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:

> Some codecs can only support a small range of sample rates e.g. 8k &
> 48k, whilst your controller may support more. This just makes sure the
> audio is set a rate the codec can handle, otherwise audio quality will
> probably suffer.

What about boards where the codec does *not* dictate the available sample rates?  That is, 
what if the SOC can't generate the frequencies necessary to drive the codec at all the 
rates it supports?  The codec driver would then need to be told by the machine driver 
which sample rates are going to be used.  When the codec driver is initialized, it needs 
to set the snd_soc_codec.dai field to point to the codec's DAI, and that structure 
contains the list of supported sample rates.

I guess in the PowerPC world, the codec driver can query the codec node in the device 
tree, but ideally there would need to be some standard interface.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
