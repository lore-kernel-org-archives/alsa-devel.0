From: louis@museresearch.com
Subject: Timing of linked devices
Date: Fri, 12 Jun 2009 15:52:03 -0700 (PDT)
Message-ID: <49237.65.105.226.50.1244847123.squirrel@master.museresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.museresearch.com (master.museresearch.com [69.59.28.231])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E20E243FF
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 00:52:11 +0200 (CEST)
Received: from localhost ([127.0.0.1] helo=master.museresearch.com)
	by master.museresearch.com with esmtpa (Exim 4.69)
	(envelope-from <louis@museresearch.com>) id 1MFFbP-00054y-Hh
	for alsa-devel@alsa-project.org; Fri, 12 Jun 2009 15:52:03 -0700
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

I am developing an application which opens both inputs and outputs for
digital and s/pdif (so, 4 devices).  The sync IDs all match.  However,
under certain conditions, I am receiving partial buffers from the input. 
So, I have a few questions:

Does linking input and output devices, from a programmer's perspective,
mean that input is ready at precisely the same time that the device is
ready to output a buffer?  Or, does it only mean that the ins and outs
will be synchronized for each given buffer?  More to the point, will
blocking on a write also accurately tell the program when the device is
ready for a read (including under non-ideal circumstances like after a
bunch of xruns)?

And, in the case that I am doing a non-blocking read (pcm_read) from a
buffer which is not yet ready, should I receive an outdated buffer, a
blank buffer, or one which has both partially new and  partially old data?

I am using ALSA 1.0.15 and the ICE1724 driver.

Thanks in advance for your help!
- Louis
