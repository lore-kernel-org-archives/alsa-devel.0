From: Carlos Pita <carlosjosepita@yahoo.com.ar>
Subject: Re: More hotplug problems
Date: Mon, 29 Nov 2004 14:54:17 -0300
Message-ID: <200411291454.17595.carlosjosepita@yahoo.com.ar>
References: <Pine.HPX.4.33n.0411291816050.9175-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0411291816050.9175-100000@studcom.urz.uni-halle.de>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> it tries to open /dev/aloadSEQ (minor number 1) to trigger the autoloading.

Mmmm. But udev hasn't created that one either. In fact, it is not under
/sys so udev has got no chance to create it. Perhaps the sysfs entry
is created by a module that is not loaded in my system.

Another problem I had is when loading snd-virmidi from /etc/modules.
In my debian (sarge), /etc/rcS.d/S20modutils would be executed before
/etc/rcS.d/S40hotplug (S20 < S40), so I get virmidi as my first soundcard, ugly.

There are a number of alternatives:
  1) create /etc/hotplug/pci/snd-emu10k1 (since I have an audigy card)
      and modprobe snd-virmidi and snd-pcm from it. This works because
      /etc/hotplug/pci.agent will call /etc/hotplug/pci/<module> as a setup
      script after modprobe'ing snd-emu10k1.
  2) add 'install modulename command' rules to /etc/modprobe.d/alsa.local
      triggering the modprobe of snd-virmidi from the one for snd-emu10k1
      and snd-seq from snd-seq-device (for example).
  3) create /etc/rcS.d/S99modutils.local and modprobe snd-virmidi and
      snd-pcm from it.
  4) modprobe snd-virmidi and snd-pcm from /etc/init.d/alsa.
  5) more???

I'm successfuly using alternative 2.

A last problem in debian sarge (I've already reported the bug) with
udev && virmidi is the rule
  KERNEL="midi[CD0-9]*",  NAME="snd/%k"
in
  /etc/udev/rules.d/udev.rules
which makes udev create OSS devices midi[1-9] under /dev/snd instead
of the correct /dev path. A trivial fix is changing the RE to "midiC[D0-9]*".

I'm writing a HOWTO about all this stuff. In a few days I will post it to the
list.

Regards,
Carlos

> 
> HTH
> Clemens
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now. 
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
