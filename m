From: Alex <lee188@singnet.com.sg>
Subject: Re: USB asynchronous mode feedback format
Date: Thu, 14 Oct 2010 01:28:25 +0000 (UTC)
Message-ID: <loom.20101014T031422-361@post.gmane.org>
References: <201010131750.18897.julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id DCC1B10386D
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 03:28:40 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P6CcZ-0005c8-Us
	for alsa-devel@alsa-project.org; Thu, 14 Oct 2010 03:28:40 +0200
Received: from 220.255.7.163 ([220.255.7.163])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2010 03:28:39 +0200
Received: from lee188 by 220.255.7.163 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2010 03:28:39 +0200
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

Julian Scheel <julian <at> jusst.de> writes:

> 
> 
> 
Hi Julian,

The current alsa rate feedback rate feedback format is 
12.13 in 4 bytes.  Clemens has a patch to make the rate 
feedback format automatic such that it will work with 
10.14 16.16 or any other formats.  We are still testing the 
patch put .  Currently with 12.13 format rate feedback 
works well.

Mac OSX can work with 10.14 and 16.16.

However, I think your problem lies elsewhere .

For example, AT91SAM7 has a limitation of EP siE of 64 
bytes for EP 3 used for ISO transfers.  There may also be 
a limitation in that the Same EP number cannot be used 
for both IN and OUT.

7
Alex
> 
