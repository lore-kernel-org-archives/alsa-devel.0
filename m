From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: OSX Core Audio ASYNC OUT with rate feedback format
 ?
Date: Fri, 01 Oct 2010 08:47:28 +0200
Message-ID: <4CA58400.4010506@ladisch.de>
References: <loom.20100930T054110-986@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id A2A7B1039C4
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 08:46:37 +0200 (CEST)
In-Reply-To: <loom.20100930T054110-986@post.gmane.org>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alex wrote:
> I have successfully interfaced the sdr-widget with Linux alsa-driver for ASYNC
> OUT with rate feedback.  Found out after much trial and error and reading of the
> usbaudio alsa-driver source code that you are using 12.13 as the format for the
> feedback rate !!!  I was trying with 10.14 (UAC1 v1.2 specs, I think) in 3 bytes,
> and 16.16 (USB 2.0) in 4 bytes for quite a number of days with no success !!!
> 
> However, 12.13 in 4 bytes, whilst working like a charm with Linux, does NOT work
> with OSX.

Linux currently doesn't look at the endpoint packet size to determine
the feedback format.

I'll change the driver so that it accepts any format.


Regards,
Clemens
