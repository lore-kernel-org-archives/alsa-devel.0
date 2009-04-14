From: Scott Serr <serrs@theserrs.net>
Subject: getting HDAudio IDs
Date: Tue, 14 Apr 2009 16:09:19 -0600
Message-ID: <49E5098F.6070009@theserrs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.geeksite.org (mail.geeksite.org [63.227.241.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B2B9103813
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 00:09:31 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
	by mail.geeksite.org (Postfix) with ESMTP id 0D2B24BDF75
	for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2009 22:09:26 +0000 (UTC)
Received: from mail.geeksite.org ([127.0.0.1])
	by localhost (hosting.geeksite.org [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id fTxyIpz9MFA8 for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 16:09:21 -0600 (MDT)
Received: from [192.168.6.189] (75-174-24-36.bois.qwest.net [75.174.24.36])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.geeksite.org (Postfix) with ESMTP id 444824BDF73
	for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2009 16:09:21 -0600 (MDT)
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

Hi All,

I've found a great way to get HDAudio vendor/device IDs when audio 
drivers are loaded: /proc/asound/card?/codec?

But to remake my particular (barebones) distro with with audio support, 
it will be repetitive and time consuming.  I'm wondering what would be 
involved in making a user space utility that would return the HDAudio ID?

A guy on #alsa came up with some good ideas.  Potentially following the 
lead of others directly accessing the hardware from user space 
http://samba.org/picturebook/ but using libpci instead.  Maybe we can 
use "single cmd mode" so we don't need interrupts.

My original idea:
It might be that a smart developer could grab a bunch of alsa/hdaudio 
driver source and torture it into userland.... just to get these IDs.

Should I quit now?  Is it doable?  Are there people here with the 
skills/experience to do this?

BTW, in the kernel config:
#CONFIG_SOUND is not set

Thanks,
Scott
