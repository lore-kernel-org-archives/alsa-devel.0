From: sbahling@mudgum.net
Subject: ICE1712_STDSP24_MUTE in hoontech driver
Date: Mon, 27 Sep 2004 09:12:23 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <49244.195.135.221.2.1096290765.squirrel@www.mudgum.net>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

What exactly is the ICE1712_STDSP24_MUTE bit used for? On my DSP24mkII
with ADCIII box, this bit set low disables all ports on the ADCIII. This
is the default setting of the driver.

Changing
    ice->hoontech_config = 0 ;
to:
    ice->hoontech_config = ICE1712_STDSP24_MUTE ;

in snd_ice1712_hoontech_init() of hoontech.c activates the ports on the box.

So the logic seems to be inverted unless it has a different function on
other boxes.

-Scott


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
