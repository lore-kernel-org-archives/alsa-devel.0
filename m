From: =?UTF-8?B?VGhvbWFzIEdsw6TDn2xl?= <thomas@coldfix.de>
Subject: alsactl monitor spins at 100% cpu after unplugging USB
	headphones
Date: Sun, 30 Sep 2018 16:32:31 +0200
Message-ID: <b240e23c-6be9-fd53-e62a-8ef65e5a9070@coldfix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from coldfix.de (coldfix.de [37.120.171.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BC8F2676A7
 for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2018 16:32:32 +0200 (CEST)
Received: from [192.168.0.66] (aftr-95-222-25-66.unity-media.net
 [95.222.25.66]) by coldfix.de (Postfix) with ESMTPSA id DB8885F733
 for <alsa-devel@alsa-project.org>; Sun, 30 Sep 2018 16:31:32 +0200 (CEST)
Content-Language: en-US-large
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

on both my desktop and laptop (archlinux), `alsactl monitor` beginns
spinning at 100% cpu when I unplug my USB headset. This happens every
time and can be reproduced as follows:

- plug in USB headphones
- start `alsactl monitor`
- unplug headphones

It happens only if the headphones are already plugged in when starting
alsactl.

The increased activity does not lead to spamming stdout or similar,
alsactl continues to perform seemingly correct, i.e. reports when I
change volume levels etc, but nothing apart from the ordinary.

I'm sorry if this is not the right place to report this issue or if the
problem is already, I couldn't find anything about it.


Below is the output from alsa-info.sh:

with headphones:

http://www.alsa-project.org/db/?f=0dfc632e3adafb8bc78a182e0a225bcb13bea9fa

after unplugging:

http://www.alsa-project.org/db/?f=41dbf0735fdd7cd2416a6b4a602505715d25b44f

Please let me know if you need further info.


Best regards,
Thomas
