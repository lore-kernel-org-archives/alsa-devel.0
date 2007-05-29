From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: ASoC and a codec that can't be controlled
Date: Tue, 29 May 2007 09:53:10 +0100
Message-ID: <1180428790.5816.76.camel@a10072.wolfsonmicro.main>
References: <46531097.5040600@freescale.com>
	<1179934677.12071.30.camel@a10072.wolfsonmicro.main>
	<46574453.10808@freescale.com>
	<1180354247.5816.30.camel@a10072.wolfsonmicro.main>
	<465B716F.7090908@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 209B024394
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2007 10:53:12 +0200 (CEST)
In-Reply-To: <465B716F.7090908@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2007-05-28 at 19:18 -0500, Timur Tabi wrote:
> Liam Girdwood wrote:
> 
> > Yes, although my feeling is that a codec "driver" would still be needed
> > to define the capabilities of your codec within the audio subsystem.
> > 
> > e.g. supported sample rates, interface formats, etc
> 
> I'm curious - why would the codec driver dictate all that?  On my board, the sample rates are determined by the I2S controller, not the codec, because in order to change the sample rate, I program new divisors into the I2S controller's registers.


Some codecs can only support a small range of sample rates e.g. 8k &
48k, whilst your controller may support more. This just makes sure the
audio is set a rate the codec can handle, otherwise audio quality will
probably suffer.

Liam
