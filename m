From: John Rigg <aldev@jrigg.co.uk>
Subject: alsa-utils-1.0.24.2 won't compile on x86_64 -
	CoreFoundation error
Date: Sun, 22 Jan 2012 21:19:47 +0000
Message-ID: <20120122211947.GA3594@localhost0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vm2962.vps.tagadab.com (vm2962.vps.tagadab.com [95.172.24.202])
	by alsa0.perex.cz (Postfix) with ESMTP id C420F103813
	for <alsa-devel@alsa-project.org>; Sun, 22 Jan 2012 22:14:32 +0100 (CET)
Received: from [78.32.150.178] (helo=localhost0.localdomain)
	by vm2962.vps.tagadab.com with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <noreply@jrigg.co.uk>) id 1Rp4c2-0002HI-0B
	for alsa-devel@alsa-project.org; Sun, 22 Jan 2012 21:06:06 +0000
Received: from anon by localhost0.localdomain with local (Exim 4.69)
	(envelope-from <noreply@jrigg.co.uk>) id 1Rp4pH-0000xs-Ag
	for alsa-devel@alsa-project.org; Sun, 22 Jan 2012 21:19:47 +0000
Content-Disposition: inline
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

Apologies if this should have gone to alsa-user instead, but I've
just tried compiling alsa-utils-1.0.24.2 on a Debian testing amd64 system,
and configure gave a list of errors related to CoreFoundation.
There were several similar to this in config.log:

...
configure:4589: checking for CFPreferencesCopyAppValue
configure:4607: gcc -o conftest -g -O2   conftest.c  -Wl,-framework -Wl,CoreFoundation >&5
conftest.c:11:42: fatal error: CoreFoundation/CFPreferences.h: No such file or directory
compilation terminated.
...

I ran ./configure with default settings. 
Kernel is 3.2.1 compiled for k8 from kernel.org source.
alsa-lib-1.0.24.1 compiled and installed sucessfully.

Possibly a stupid question, but why is it checking for CoreFoundation
on a Linux system?

John
