From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/2] Fix usb-audio delay calculation
Date: Fri, 23 Nov 2012 16:21:46 +0100
Message-ID: <1353684108-16669-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3562B261644
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 16:21:56 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 0FF8DA30B9
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 16:21:56 +0100 (CET)
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

the following two patches are for fixing the wrong PCM delay reported
from usb-audio driver.  The first one is trivial, just to fix / optimize
for the capture direction.  The second one is a deeper fix for corner
cases like playback pause.


Takashi
