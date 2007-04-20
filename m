From: John Dey <jsdey@optonline.net>
Subject: Buffer Overrun Messages
Date: Fri, 20 Apr 2007 16:36:57 -0400
Message-ID: <20267daccbbad88e814c591cac550e5b@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mta2.srv.hcvlny.cv.net (mta2.srv.hcvlny.cv.net [167.206.4.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 7482024355
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Apr 2007 22:37:05 +0200 (CEST)
Received: from robo1.jsdey.com (ool-44c1fb41.dyn.optonline.net [68.193.251.65])
	by mta2.srv.hcvlny.cv.net
	(Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
	with ESMTP id <0JGT00M2AD9N9NA0@mta2.srv.hcvlny.cv.net> for
	alsa-devel@alsa-project.org; Fri, 20 Apr 2007 16:37:00 -0400 (EDT)
Received: from [192.168.0.2] (robo2.jsdey.com [192.168.0.2])
	by robo1.jsdey.com (8.13.8/8.13.8) with ESMTP id l3KKaxpq006810	for
	<alsa-devel@alsa-project.org>; Fri, 20 Apr 2007 16:36:59 -0400
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

Hi,

I have been driving fluidsynth with with aplaymidi and get the 
following:  fluidsynth: ALSAsequencer buffer overrun, lost event.  I 
have played around with buffer size and buffer number and also run with 
and without jackd.  The sound out doesn't seem to be affect.  Can 
anyone give me some guidance on how to eliminate the error.  Could the 
error be caused by fluidsynth?  I have also run the program on 
PS2/Yellowdog linux and CCRMA fc5 (x86) both with similar results.  
Thanks.

John
