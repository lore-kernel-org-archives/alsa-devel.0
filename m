From: robert.devanna@nospammail.net
Subject: Re: After kernel upgrade to v ~~> 4.1.0, no audio
 output unless UNPLUG/RE-PLUGIN of audio jack on card;
 OK with earlier kernels
Date: Sun, 05 Jul 2015 16:04:19 -0700
Message-ID: <1436137459.1465301.315813009.197BC41D@webmail.messagingengine.com>
References: <1436128748.1442900.315748449.28688C30@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id E23042604E3
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 01:04:20 +0200 (CEST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 2E29520364
 for <alsa-devel@alsa-project.org>; Sun,  5 Jul 2015 19:04:20 -0400 (EDT)
In-Reply-To: <1436128748.1442900.315748449.28688C30@webmail.messagingengine.com>
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

As add'l info

with guidance from #irc, I've tried 

adding 

	/etc/modprodbe.d/50-sound.conf
		...
	+	options snd-hda-intel power_save_controller=0

and adding

	/etc/init.d/after.local
		...
	+	hda-verb /dev/snd/hwC0D0 0x1c SET_POWER_STATE 0

and launching

	cat /usr/local/scripts/alsa-fix.sh 
		#!/bin/bash
		sudo hda-verb /dev/snd/hwC0D0 0x1c SET_POWER_STATE 0

as a KDE startup script,

and exec'ing

	hda-verb /dev/snd/hwC0D0 0x1c SET_POWER_STATE 0

@ desktop shell as uid=<myuser>

None work.

The one thing that DOES work, so far, is @ desktop shell, exec of

	sudo hda-verb /dev/snd/hwC0D0 0x1c SET_POWER_STATE 0

as sudo (root).

On exec, I hear a 'pop' through the speakers, and immediately after I can play audio -- withOUT having to physically UNPLUG/REPLUGIN the jack.

Clearly, I can't figure out how to automate this workaround -- not clear where else to try it.  Begs the question why it only works in this case.

- Rob
