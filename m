From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: alsa-utils 1.0.9 rc4: alsactl.h?
Date: 23 May 2005 12:35:27 -0700
Message-ID: <1116876927.16753.32.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp2.Stanford.EDU (smtp2.Stanford.EDU [171.67.16.125])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 94ABC25E
	for <alsa-devel@alsa-project.org>; Mon, 23 May 2005 21:35:34 +0200 (MEST)
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by smtp2.Stanford.EDU (8.12.11/8.12.11) with ESMTP id j4NJZS6x030810
	for <alsa-devel@alsa-project.org>; Mon, 23 May 2005 12:35:31 -0700
Received: from cmn37.stanford.edu (cmn37.stanford.edu [171.64.197.186])
	by cm-mail.stanford.edu (8.11.6/8.11.6) with ESMTP id j4NJZSb26527
	for <alsa-devel@alsa-project.org>; Mon, 23 May 2005 12:35:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by cmn37.stanford.edu (8.12.8/8.12.5) with ESMTP id j4NJZRKF004376
	for <alsa-devel@alsa-project.org>; Mon, 23 May 2005 12:35:27 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Looks like there's something missing in alsa-utils 1.0.9-rc4, it wants
alsactl.h but the file does not seem to be there...

-- Fernando

# find alsa-utils-1.0.9rc4/ -type f -exec grep alsactl.h {} \; -print
#include "alsactl.h"
alsa-utils-1.0.9rc4/alsactl/alsactl.c
#include "alsactl.h"
alsa-utils-1.0.9rc4/alsactl/names.c
#include "alsactl.h"
alsa-utils-1.0.9rc4/alsactl/power.c
#include "alsactl.h"
alsa-utils-1.0.9rc4/alsactl/state.c

# find alsa-utils-1.0.9rc4/ -name alsactl\*
alsa-utils-1.0.9rc4/alsactl
alsa-utils-1.0.9rc4/alsactl/alsactl.1
alsa-utils-1.0.9rc4/alsactl/alsactl.c




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
