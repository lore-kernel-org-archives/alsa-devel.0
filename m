From: Alex Lee <lee188@singnet.com.sg>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 23:33:40 +0800
Message-ID: <1287070420.2975.21.camel@laptop-alex>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010141301.52856.julian@jusst.de>
	<20101014111612.GJ10432@buzzloop.caiaq.de>
	<201010141710.02194.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp43.singnet.com.sg (smtp43.singnet.com.sg [165.21.103.151])
	by alsa0.perex.cz (Postfix) with ESMTP id 10F052412E
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 17:33:44 +0200 (CEST)
In-Reply-To: <201010141710.02194.julian@jusst.de>
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
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org


> Would you agree that the data (this time blue channel) is delayed too much? 
> Looks like it's at least 2 cycles behind the LRCK toggle.
> Would it be possible that this is the reason for the DAC not understanding the 
> data?
> 

Yes it is delayed 2-3 cycles (should be only 1 cycle).  Also, as I
pointed out earlier, data is valid on falling edge of clock.  Should be
rising edge according to i2S.

Alex
