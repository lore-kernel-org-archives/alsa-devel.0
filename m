From: Robin Kreis <r.kreis@uni-bremen.de>
Subject: ad1988 spdif crackling (includes patch)
Date: Tue, 30 Oct 2012 13:02:27 +0100
Message-ID: <1351598547.646.18.camel@quip>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.uni-bremen.de (gabriel-2.zfn.uni-bremen.de [134.102.20.37])
 by alsa0.perex.cz (Postfix) with ESMTP id DD9A8264F42
 for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2012 13:02:29 +0100 (CET)
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

Hi!

For nearly three years, a bug has been known to cripple SPDIF output on
certain hardware.  It might work fine for a while, but will randomly
break, showing two symptoms:  PCM audio is distorted (similar to
clipping) while compressed audio (AC3 or DTS) will not work at all.
Muting an unmuting the master channel may temporarily fix it.

This affects at least all Asus P5B and P6B mainboards.

The solution is a simple one-liner, and has been known for a year:  
http://fjerhammer.dk/ad1988_spdif_crackling.patch (credits go to Javeed
Shaikh for the patch and fjerhammer for hosting it).  I can verify that
it fixes all issues on my setup.  Please apply it.

See also:
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/359361

Greetings,
Robin Kreis
