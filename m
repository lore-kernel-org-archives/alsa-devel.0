From: Alex <lee188@singnet.com.sg>
Subject: Re: OSX Core Audio ASYNC OUT with rate feedback format
	?
Date: Fri, 1 Oct 2010 01:20:43 +0000 (UTC)
Message-ID: <loom.20101001T031546-137@post.gmane.org>
References: <loom.20100930T054110-986@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 29B721037EE
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 03:20:52 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P1UIt-00069d-Tp
	for alsa-devel@alsa-project.org; Fri, 01 Oct 2010 03:20:51 +0200
Received: from 220.255.7.182 ([220.255.7.182])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 01 Oct 2010 03:20:51 +0200
Received: from lee188 by 220.255.7.182 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 01 Oct 2010 03:20:51 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Alex <lee188 <at> singnet.com.sg> writes:

> 
> Hi Daniel et al,
> 
> I have successfully interfaced the sdr-widget with Linux alsa-driver
>  for ASYNC 
> OUT with rate feedback.  Found out after much trial
>  and error and reading of the 
> usbaudio alsa-driver source code that you are
>  using 12.13 as the format for the 
> feedback rate !!!  I was trying with 10.14 (UAC1 v1.2 specs
> , I think) in 3 bytes, 
> and 16.16 (USB 2.0) in 4 bytes for quite a number of days
>  with no success !!!
> 
> However, 12.13 in 4 bytes, whilst working like a charm
>  with Linux, does NOT work 
> with OSX.
> 
> Would you know the format used by OSX?
> 
> Thanks.
> 
> Alex
> 

Hi Daniel et al,

Found out by reading the apple Core Audio source code that it is using 16.16 
format for rate feedback.  This is in accordance with USB 2.0 ISOCHRONOUS 
feedback specs.  The current configuration is UAC1 with HIGH speed.

I'm now testing the sdr-widget (with a version of firmware implementing 16.16) 
with OSX Snow Leopard as host.

Once this works we are going to implement the ASYNC OUT with rate feedback in 
UAC2, which will give us 48/96/192 khz 24 bit stereo capture and playback in 
both ASYNC IN and ASYNC OUT.

I am hoping that the same firmware could work in both OSX and Linux.

Is there any particular reason why the Linux driver uses 12.13 format ?

Alex
