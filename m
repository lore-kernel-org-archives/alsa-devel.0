From: Alex Lee <lee188@singnet.com.sg>
Subject: Re: USB asynchronous mode feedback format
Date: Fri, 15 Oct 2010 22:41:38 +0800
Message-ID: <1287153698.3730.7.camel@laptop-alex>
References: <1287046026.4cb6c38a2a179@discus.singnet.com.sg>
	<201010151504.56742.julian@jusst.de>
	<1287149510.2344.8.camel@desktop-alex>
	<201010151624.46800.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp41.singnet.com.sg (smtp41.singnet.com.sg [165.21.103.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 396D524403
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Oct 2010 16:41:47 +0200 (CEST)
In-Reply-To: <201010151624.46800.julian@jusst.de>
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

On Fri, 2010-10-15 at 16:24 +0200, Julian Scheel wrote:

> 
> Don't see any syncpipe related errors. Only thing I see is:
> usb 1-1.3: new full speed USB device using ehci_hcd and address 11
> 11:1:1: endpoint lacks sample rate attribute bit, cannot set.
> 11:1:1: endpoint lacks sample rate attribute bit, cannot set.
> 
> Does not seem to be feedback related... Although it would be nice to know, 
> what's wrong there?

You probably need to fix that sample rate attribute bit for rate
feedback to work.

It is in the bmAttribute of the 
	//Audio endpoint specific descriptor
#define AUDIO_EP_ATRIBUTES	UAC_EP_CS_ATTR_SAMPLE_RATE	 // sampling freq,
no pitch, no pading

#define AUDIO_EP_DELAY_UNIT	0x00	 	// Unused
#define AUDIO_EP_LOCK_DELAY	0x0000		// Unused

Alex		
