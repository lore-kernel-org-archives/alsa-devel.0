From: David Henningsson <david.henningsson@canonical.com>
Subject: idea: a reserve alsa plugin
Date: Thu, 02 May 2013 12:55:05 +0200
Message-ID: <51824609.30405@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E76E62610A5
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2013 12:55:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

Just had an idea which I'll write down here before I forget it 
again...and I'm not saying I'll implement this anytime soon either, but 
here goes:

There is a device reserve protocol between PulseAudio and JACK2 - when 
JACK needs the sound card, it'll send a dbus message to PulseAudio and 
grab a name in D-Bus.

However, there are plenty of applications who like to access ALSA 
directly, without going through JACK2 or PulseAudio. By making a 
"reserve" plugin, we could have this functionality for those apps too.

In practice, if the app usually opens "plughw:0" or "hw:0", it could 
instead open "reserve:plughw:0" or "reserve:hw:0" to also reserve the 
device from PulseAudio usage while the device is open. Meanwhile, 
PulseAudio is free to use other audio devices (which is not the case 
when using e g pasuspender).

How does that sound?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
