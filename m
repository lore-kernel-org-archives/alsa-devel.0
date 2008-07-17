From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Several versions of 1.0.15??
Date: Thu, 17 Jul 2008 16:44:44 +0100
Message-ID: <200807171644.44764.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (smtp-out-2.talktalk.net [62.24.128.232])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D484243B8
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jul 2008 17:26:02 +0200 (CEST)
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
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Sorry to have a flood of posts; I have a flood of problems, though.

We are building (ARM) from 2.6.24.4 kernel, and experiencing issues like 
segfaults with aplay and alsamixer that might relate to incompatible versions 
of driver, lib, utils, so I have tried to check carefully.  The kernel has 
1.0.15, dated 20 Nov 07, but when I check Alsa-git:

http://git.alsa-project.org/?p=alsa-kernel.git;a=history;f=include/sound/
version.h;hb=fe0a3fe324811385b64790d42079bf534798a0cd

3 tags are shown of 1.0.15, the first is 16-10-07, the last 20-11-07.

However, the 1.0.15 tarballs (driver, lib, utils) at
	ftp://ftp.alsa-project.org/pub
are dated 15-10-07.  (Which I presume is what the builds will grab.)

A lot of changes were commited on 16-10-07, and some up to 20-11-07.  Is it 
possible for this to cause a problem?  Should I attempt to create snapshots 
of 20-11-07 to build correctly with the kernel, or is it concern about 
nothing.

Alan
