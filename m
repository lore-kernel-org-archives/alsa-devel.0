From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Hg update problems
Date: Thu, 31 Jan 2008 11:33:26 +1300
Message-ID: <200801311133.27010.linux@audioscience.com>
References: <mailman.479441.1201678517.26582.alsa-cvslog@lists.sourceforge.net>
	<200801302110.17979.linux@audioscience.com>
	<s5hir1bloa4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 555A1247C5
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 23:31:46 +0100 (CET)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JVH00M64AJVKY40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 31 Jan 2008 11:31:07 +1300 (NZDT)
In-reply-to: <s5hir1bloa4.wl%tiwai@suse.de>
Content-disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Wierd, I can see your checkin in a browser at 
http://hg.alsa-project.org/alsa-driver/  

14 hours ago:  	asihpi version 3.09.09
changeset 3506: 	e600ecb8fbd7
tag:	tip
author: 	tiwai

Also I see it in a clean clone of the repo.

but hg pull on my original repo still gets nothing same as before, head is out 
of date - details:
eliot@zaphod:~/src/alsahg/alsa-driver$ hg -v --debug heads
changeset:   3507:86adcd0d6d849d5f8d41448d3cd4d1a8660d6214
tag:         tip
description:
Added tag v1.0.16rc2 for changeset 1dc44ca35555


Tracing (strace) further I see that Hg queries the repository like this
http://hg.alsa-project.org/alsa-driver/?cmd=heads
and gets back
86adcd0d6d849d5f8d41448d3cd4d1a8660d6214
So the remote repo is telling me that my local is up to date, even though the 
web interface shows more recent tip.

Very wierd...

Anyone else see this or shed any light on it?
--
Eliot
