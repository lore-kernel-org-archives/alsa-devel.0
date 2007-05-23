From: Rossco <r.maclachlan@strath.ac.uk>
Subject: Re: ICE1724 alsa driver
Date: Wed, 23 May 2007 17:55:02 +0000 (UTC)
Message-ID: <loom.20070523T194915-68@post.gmane.org>
References: <loom.20070522T233114-523@post.gmane.org>
	<9723.25499-31972-2031248606-1179930079@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id F078024667
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2007 19:55:24 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hqv3L-0001er-99
	for alsa-devel@alsa-project.org; Wed, 23 May 2007 19:55:15 +0200
Received: from cpc2-cowc2-0-0-cust277.renf.cable.ntl.com ([86.16.109.22])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 23 May 2007 19:55:15 +0200
Received: from r.maclachlan by cpc2-cowc2-0-0-cust277.renf.cable.ntl.com with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 23 May 2007 19:55:15 +0200
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

 <dustin <at> seznam.cz> writes:

> 
> Hello Ross,
> 
> what kind of SPDIF receiver the HV-7.1CH Hitpoint card uses? 
> 
> http://www.hitpoint.com.tw/computer/en/product/soundcard/via/hv-71ch.htm
> 
> I guess it is the chip right next to the two TOSLINK connectors. If it is
CS8415 (looks similar), support for
> this chip could be taken from aureon.c, or perhaps the whole aureon code would
fit this card better than the
> amp.c code with Chaintec AV710.
> 
> Regards,
> 


Hi Pavel,

I replied to you be email, just realised this should probably have been through
the list. It is a CS8415. I would be grateful if you could advise how I might go
about trying the aureon.c with the hitpoint (I am new to ALSA and indeed linux).
Or is this something that needs further developer attention and information
about the card (I will provide anything required)?

Regards,

Ross
