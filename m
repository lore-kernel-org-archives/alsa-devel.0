From: "thewade" <pdman@aproximation.org>
Subject: Many problems: no midi, jackd errors, hdspmixer segfault still, general speed
Date: Thu, 28 Oct 2004 19:13:53 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410290113.i9T1DrQL017748@sanctuary.aproximation.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sanctuary.aproximation.org (k203.denver.dsl.forethought.net [216.241.42.203])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B486530F
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2004 03:13:55 +0200 (MEST)
Received: from sanctuary.aproximation.org (localhost.localdomain [127.0.0.1])
	by sanctuary.aproximation.org (8.12.9/8.12.8) with ESMTP id i9T1Dr7F017749
	for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2004 19:13:53 -0600
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,
Firstly, my laptop\'s description, along with .config file, can
be found at:
http://www.aproximation.org/application/AMD64laptop.html
2.6.9-rc3-mm3-VP-T3 kernel
AMD64 laptop

<midi>
The midi does not work with my multiface:
> which modules have you loaded? is your interface listed in
> aconnect -li ?

[pdman at musicbox pdman]$ aconnect -li
client 0: \'System\' [type=kernel]
    0 \'Timer           \'
    1 \'Announce        \'

> about drove myself insane before someone suggested loading
> snd-seq-midi, this was after loading:
> snd-seq, snd-rawmidi, snd-virmidi, snd-seq-oss, etc......

I have no rawmidi module! What do I have to enable to get my
kernel build to include this?
[pdman at musicbox linux]$ cat .config | grep RAWMIDI
CONFIG_SND_RAWMIDI=y
except...
[pdman at musicbox pdman]$ ls -lR /lib/modules/2.6.9-rc3-mm3-VP-T3/kernel/ | grep snd-seq
-rw-r--r--  1 root root 15358 Oct 21 19:07 snd-seq-device.ko
-rw-r--r--  1 root root  7868 Oct 21 19:07 snd-seq-dummy.ko
-rw-r--r--  1 root root 85046 Oct 21 19:07 snd-seq.ko
-rw-r--r--  1 root root 13738 Oct 21 19:07 snd-seq-midi-event.ko
-rw-r--r--  1 root root 14178 Oct 21 19:07 snd-seq-midi.ko
-rw-r--r--  1 root root 13106 Oct 21 19:07 snd-seq-virmidi.ko
-rw-r--r--  1 root root 57519 Oct 21 19:07 snd-seq-oss.ko
[pdman at musicbox pdman]$ ls -lR /lib/modules/2.6.9-rc3-mm3-VP-T3/kernel/ | grep snd-rawmidi
[pdman at musicbox pdman]$ ls -lR /lib/modules/2.6.9-rc3-mm3-VP-T3/kernel/ | grep snd-virmidi
-rw-r--r--  1 root root  8868 Oct 21 19:07 snd-virmidi.ko

> if it is listed in aconnect, you should be able to get it via
> mididev. make sure youve turned on oss
> emulation and configured alsa --with-sequencer as well..

Im using alsa built into the kernel...

How do I get the rawmidi module, if indeed this is where Im
getting hung up on?
hdsploader
hdspmixer
modprobe snd-seq-midi
runs fine, but does not alter the response of aconnect
</midi>

<jackd>
jackd runs fine for a little while with pd, and then all of a
sudden gets all kinds of xruns and basically freezes up my machine
until I kill it.
jackd -v -R -P6 -dalsa -dhw:1 -r48000 -p64 -n2 -m -i18 -o18 -H -M
started with \'sudo qjackdctl\'
</jackd>

<hdspmixer>
hdspmixer still segfaults when I run it.
It unmutes my card but does not display.
the gdb info at:
http://sourceforge.net/mailarchive/message.php?msg_id=9684182
</hdspmixer>

<general>
Why is my AMD Opteron 64 3400+ laptop running linux
2.6.9-rc3-mm3-VP-T3 have lower latency than my AMD Athlon 2600+
WinXP desktop, but run pd patches slower?
Something that might help solving the other problems is the following
warning
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip acpi_ec_read+0xdc/0x11d
</general>

Thanks for all the help! Sorry to lump all these questions togeather.
-thewade


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
