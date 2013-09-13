From: David Henningsson <david.henningsson@canonical.com>
Subject: USB Audio initialization race
Date: Fri, 13 Sep 2013 15:56:00 -0400
Message-ID: <52336DD0.2010802@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 68DC22619D7
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 21:56:03 +0200 (CEST)
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
Cc: clemens@ladisch.de, stern@rowland.harvard.edu, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

I'm sometimes seeing that USB audio devices are not initialized 
correctly by PulseAudio, but I can't reproduce this myself.

I have, however, spotted what I think is a race condition in the driver 
code, if a device has more than one interface. snd_card_register is 
called once for every interface, which means that it will be shown to 
userspace after the first interface has been probed. So the race could 
look like:

1) The first interface is probed, which might contain the mixer controls
2) snd_card_register is called, which sends a signal to userspace
3) PulseAudio probes the device and notices that it has no PCMs, so it 
ignores the device
4) The second interface is probed, which adds the PCMs
5) snd_card_register is again called, which is a no-op since the card 
already exist
6) User is unhappy because his plugged in sound card did not show up in 
PulseAudio.

So, assuming all this is right, it seems like we need some type of 
callback from the usb driver when all the interfaces for the sound card 
has been probed, so we can call snd_card_register at that point instead. 
Thoughts?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
