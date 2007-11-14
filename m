From: Mike Gorse <mgorse@mgorse.dhs.org>
Subject: interrupting snd_pcm_writei or snd_pcm_drain?
Date: Wed, 14 Nov 2007 12:34:07 -0400 (GMT+4)
Message-ID: <Pine.LNX.4.64.0711141223080.30648@mailserver.duxsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.duxsys.com (116-79-51-66.reonbroadband.com
	[66.51.79.116]) by alsa0.perex.cz (Postfix) with ESMTP id 9CD3E2478D
	for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2007 17:34:09 +0100 (CET)
Received: from [127.0.0.1] (helo=localhost.localdomain ident=mgorse)
	by mailserver.duxsys.com with esmtp (Exim 4.63)
	(envelope-from <mgorse@mgorse.dhs.org>) id 1IsLBn-000828-CA
	for alsa-devel@alsa-project.org; Wed, 14 Nov 2007 12:34:07 -0400
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

I've noticed that it is unsafe to call snd_pcm_writei or snd_pcm_drain in 
a pthread with its cancelation type set to asynchronous. 
snd_pcm_dmix_sync_area can lower a semaphore, and, if the thread is 
canceled while the semaphore is down, then a subsequent call to the sound 
device (calling snd_pcm_close, for instance) will also lower the semaphore 
and cause deadlock.  Is this a known issue, and is there a way around it 
other than to always use deferred cancelation when calling these 
functions?

Thanks,
-Mike G-
