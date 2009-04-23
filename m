From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: trouble with alsa, wolfson, and TI OMAP35xx McBSP
Date: Thu, 23 Apr 2009 13:05:52 +0100
Message-ID: <20090423120552.GA20062@rakim.wolfsonmicro.main>
References: <dbdb2ea60904221058w67b775f3occ07f55938fe4d03@mail.gmail.com>
	<200904231220.14465.peter.ujfalusi@nokia.com>
	<200904231204.05991.gineera@aspect135.co.uk>
	<200904231452.24916.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A2F3F10381D
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 14:05:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904231452.24916.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 23, 2009 at 02:52:24PM +0300, Peter Ujfalusi wrote:

> I have a theory, which needs to be checked for the startup switch in OMAP:
> I think what is happening, that the McBSP module got enabled earlier then the 
> DMA is started. This leads to and underrun situation in McBSP (no data in the 
> buffer), so McBSP will transmit _something_ when the start condition for the 
> I2S is met. When the DMA starting to push data to McBSP, than valid data will 
> be shifted out.
> McBSP is shifting word by word manner. So if the first word transmit need to 
> be done, when the buffer is empty, it starts to shift the word, than the data 
> arrives from the DMA,  the next word will be valid data -> you will have a 
> nice channel switch.

> Is this makes sense?

Sounds entirely plausible to me.
