From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/4] Fixes for missing boost controls in
	generic parser
Date: Fri, 18 Jan 2013 11:23:59 +0100
Message-ID: <1358504643-13593-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 243A3265E72
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 11:24:05 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id D5B43A3A49
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2013 11:24:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

this is a series of patches to fix the missing boost controls in the
generic parser.  I found the problem not only on AD1988 but some others,
and while debugging this issue, more issues have been revealed, thus
it became more volumes than expected.

All patches are found in sound-unstable tree test/hda-gen-parser
branch.  And, now both test/hda-gen-parser branch and test/hda-migrate
branch become identical.  It doesn't matter which branch you take.
Also, it's already merged in master branch of sound-unstable tree.

So.. at this point, it'd be helpful if anyone can test this tree, and
let me know any issues.


thanks,

Takashi
