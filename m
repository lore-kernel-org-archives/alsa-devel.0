From: Carlos Pita <carlosjosepita@yahoo.com.ar>
Subject: More hotplug problems
Date: Mon, 29 Nov 2004 08:53:58 -0300
Message-ID: <200411290853.58117.carlosjosepita@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp207.mail.sc5.yahoo.com (smtp207.mail.sc5.yahoo.com [216.136.129.97])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 469432BE
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2004 12:50:07 +0100 (MET)
Content-Disposition: inline
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

I have an audigy so hotplug loads snd-emu10k1.

In /lib/modules/2.6.8-1-k7/modules.dep:

  /lib/modules/2.6.8-1-k7/kernel/sound/pci/emu10k1/snd-emu10k1.ko:

     /lib/modules/2.6.8-1-k7/kernel/sound/core/snd-rawmidi.ko
     /lib/modules/2.6.8-1-k7/kernel/sound/core/snd-pcm.ko
     /lib/modules/2.6.8-1-k7/kernel/sound/core/snd-timer.ko
     /lib/modules/2.6.8-1-k7/kernel/sound/core/seq/snd-seq-device.ko
     /lib/modules/2.6.8-1-k7/kernel/sound/pci/ac97/snd-ac97-codec.ko
     /lib/modules/2.6.8-1-k7/kernel/sound/core/snd-page-alloc.ko
     /lib/modules/2.6.8-1-k7/kernel/sound/synth/snd-util-mem.ko
     /lib/modules/2.6.8-1-k7/kernel/sound/core/snd-hwdep.ko
     /lib/modules/2.6.8-1-k7/kernel/sound/core/snd.ko
     /lib/modules/2.6.8-1-k7/kernel/sound/soundcore.ko

The fact is that snd-seq is not listed as a dependency of snd-emu10k1,
which I guess is right. But, since I'm using udev I can't autoload it later
(on demand) because there is no /dev/snd/seq file.
Should I add snd-seq to /etc/modules?
Or perhaps 'above snd-seq-device snd-seq' to /etc/modules.conf?

If the day comes when I finally get hotplug & udev & alsa & OSS emu
working fine, I will post a mini-HOWTO on the subject.

Thank you.
Regards,
Carlos


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
