From: Timur Tabi <timur@freescale.com>
Subject: How can OSS applications support multiple streams?
Date: Thu, 08 Nov 2007 16:41:40 -0600
Message-ID: <473390A4.8070208@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id E7B51243E3
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 23:41:43 +0100 (CET)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	lA8MffcZ004094
	for <alsa-devel@alsa-project.org>; Thu, 8 Nov 2007 15:41:41 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lA8MfesW006401
	for <alsa-devel@alsa-project.org>; Thu, 8 Nov 2007 16:41:40 -0600 (CST)
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

I've written an ALSA driver that supports only one playback stream, because 
that's what our hardware supports.  I have a customer that has an OSS 
application that tries to open 32 simultaneous playback streams, which obviously 
doesn't work.  What do I (or the customer) need to do to get 32 streams to work? 
  Is this what a sound server is for?  If so, which one should I use?

-- 
Timur Tabi
Linux kernel developer at Freescale
