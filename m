From: David Henningsson <david.henningsson@canonical.com>
Subject: Asynchronous audio USB chips: choppy playback since
	3.8-rc7
Date: Wed, 03 Apr 2013 12:15:25 +0200
Message-ID: <515C013D.8090909@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CEFF26535C
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 12:15:26 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: 1136110@bugs.launchpad.net, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi ALSA developers,

Just to get your attention here on what seems to be an USB audio 
regression.

The bug is described in detail here:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1136110?comments=all

Quoting the bug:

"
This bug seems to affect only a certain kind of hardware, which is 
called "Asynchronous USB Digital Audio Codec (DAC)". It's said that such 
a DAC hosts the clock itself (USB Device Host). An ordinary DAC, so 
called "Synchronous USB DAC", uses the clock hosted by the mother board, 
which is not affected by this bug.

When this bug affects an asynchronous USB DAC, the audio played by the 
DAC is constantly interrupted. The playback itself does not stop, but 
the output becomes discontinous, filling with constant crackling noises, 
destroying everything the DAC plays.
"

According to the bug reporter, which seems to have done quite a bit of 
research, this started between 3.8-rc6 and 3.8-rc7 as well as stable 
kernels and the bug also lists a few commits which could be the cause, 
none under sound/usb though.




-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
