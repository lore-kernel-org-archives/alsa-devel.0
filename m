From: Julian Scheel <julian@jusst.de>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 13:44:23 +0200
Message-ID: <201010141344.23599.julian@jusst.de>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<20101014104855.GI10432@buzzloop.caiaq.de>
	<3879AFD1-61E6-47FB-8ECB-8A7D7B233B3B@singnet.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp2.work.de (smtp.work.de [212.12.45.188])
	by alsa0.perex.cz (Postfix) with ESMTP id E55F6103883
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 13:44:25 +0200 (CEST)
In-Reply-To: <3879AFD1-61E6-47FB-8ECB-8A7D7B233B3B@singnet.com.sg>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alex <lee188@singnet.com.sg>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 14. Oktober 2010, 13:15:45 schrieb Alex:
> > Great to hear that ASYNC OUT with rate feedback is working for u now :-)
> 
> Btw, are u using 12.13 format for Linux ?  U can try with OSX snow leopard,
> which can understand 10.14 and 16.16.  Apply Clemens' patch and linux can
> understand all formats - but users will have to wait for kernel 2.6.37 !

I changed my code to do 12.13 format now. Will try to connect it to my MacBook 
later.
 
> I have implemented a sophisticated rate feedback with ping pong audio
> buffer, calculation of gap between USB data and i2s data, determining
> whether gap is increasing or decreasing etc.

This actually looks like a good approach. Just studying your code.

> Channel inversion is a known issue and u need to sync the channel to the
> LRCK, and resync when the USB stream is stopped and restarted and when
> doing sample rate changes (48 to 96 etc).

So far I only support one fixed sample rate (48 kHz) in the device. Regarding 
the sync I am wondering how to determine the alignment of the data coming from 
USB. Is there some way to be sure that the data frames do start with the left 
channel when reading them from USB?
The output to the I2S is done in bigger chunks through the DMA engine of the 
AT91SAM7 - it might be possible that I loose one packet in some case at this 
place... This would actually cause a inversion on the channels...

> As for i2s for the DAC etc, u need to have the right timing for the various
> clocks.  As Daniel suggested, u need to scope the signals with a dual
> trace scope to see whether u are giving the DAC and other chips the right
> timing.

See my other mail with the attached measurement.

> If u are interested, u can take a look at our open source project
> sdr-widget.  Google for it.

Yep, I just discovered it. Really nice project. Covers even more than I want 
to do. My goal is only to have a 192kHz/24bit USB->I2S brige which can be used 
for high quality audio designs. If I would have seen your project before I 
might not even have started working on this. Well, now it's topic of my 
bachelor thesis, so I really should get this done (c:

Regards,
Julian
