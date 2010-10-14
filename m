From: Daniel Mack <daniel@caiaq.de>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 13:56:20 +0200
Message-ID: <20101014115620.GL10432@buzzloop.caiaq.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<20101014104855.GI10432@buzzloop.caiaq.de>
	<3879AFD1-61E6-47FB-8ECB-8A7D7B233B3B@singnet.com.sg>
	<201010141344.23599.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 552F2103B4D
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 13:56:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201010141344.23599.julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alex <lee188@singnet.com.sg>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 14, 2010 at 01:44:23PM +0200, Julian Scheel wrote:
> Am Donnerstag, 14. Oktober 2010, 13:15:45 schrieb Alex:
> > Channel inversion is a known issue and u need to sync the channel to the
> > LRCK, and resync when the USB stream is stopped and restarted and when
> > doing sample rate changes (48 to 96 etc).
> 
> So far I only support one fixed sample rate (48 kHz) in the device. Regarding 
> the sync I am wondering how to determine the alignment of the data coming from 
> USB. Is there some way to be sure that the data frames do start with the left 
> channel when reading them from USB?

Yes, a USB packet always starts at a sample frame boundary. In other
words, after the SOF, the USB stream will start with the first byte of
the first channel. One USB packet must also transport multiple full
audio frames (ie, samples for all channels), and not only fractions
thereof.

> The output to the I2S is done in bigger chunks through the DMA engine of the 
> AT91SAM7 - it might be possible that I loose one packet in some case at this 
> place... This would actually cause a inversion on the channels...

If you lose one entire packet and catch up with the next one, there
shouldn't be any channel inversion, just a data dropout. However I would
add an extra check to assure your internal counters are in sync whenever
a SOF is received.

Daniel
