From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: hda_intel driver and HDMI audio problems.
Date: Fri, 17 Dec 2010 23:07:54 +0000
Message-ID: <AANLkTi=G1QZX9cpdBeU0LtBHDEXO7f0tEiNzQs7b+0mt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 661041037FC
	for <alsa-devel@alsa-project.org>; Sat, 18 Dec 2010 00:07:55 +0100 (CET)
Received: by qwj8 with SMTP id 8so1211159qwj.38
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 15:07:54 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have a problem in that when I boot with the nouveau driver and ALSA,
HDMI audio does not work.
ALSA lets the application play to device hdmi:1,1  but no sound comes
out of the TV.
If I use the nvidia driver instead, sound comes out of the TV.

The problem is caused by the failure of the ALSA driver to collect the
"eld" info in all cases, even though the "eld_valid" is set.
Normally, the nouveau driver changing the state of the "eld_valid"
gpio will cause the ALSA driver to create a hotplug event that causes
ALSA to read the "eld" info, and thus sound works fine.

1) The nouveau driver sets the correct gpio pins and the ALSA audio driver can
see them set.
2) The hotplug event only happens when the state of the gpio pins changes.
3) The ALSA driver creates the hotplug event as a result of detecting the gpio
pins change.
4) nouveau modules seems to load before the alsa module, so the hotplug event
never gets created by the ALSA audio driver because it is not loaded
and does not see the gpio pin change.
5) If the nouveau driver is loaded after boot, the hotplug event is sent to
ALSA and it works fine.
6) If the ALSA driver is loaded after boot, it detects the gpio pins settings
and acts correctly and works fine.
7) The problem is only present if the nouveau and alsa module load at boot
time.
I am investingating (7) next.

I cannot really understand why (6) works and (7) fails.
Does anyone have any ideas?

Kind Regards

James
