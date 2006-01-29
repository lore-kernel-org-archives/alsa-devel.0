From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001748]: sound driver will not load (CS4237B chip)
Date: Sun, 29 Jan 2006 15:13:32 +0100
Message-ID: <4c881d5c8383abfcb068ed878a38640b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B68F0188
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2006 15:13:32 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0001779.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1748> 
======================================================================
Reported By:                briand
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1748
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 3
Kernel Version:             2.6.9-1.667
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-14-2006 23:47 CET
Last Modified:              01-24-2006 11:16 CET
======================================================================
Summary:                    sound driver will not load (CS4237B chip)
Description: 
with BIOS set to "PnPOS" for sound chip:
  `/sbin/modprobe snd-cs4236` produces the following on stdout:
  "FATAL: Error inserting snd_cs4236 \
   (/lib/modules/2.6.9-1.667/kernel/sound/isa/cs423x/snd-cs4236.ko): \
   No such device"

   -- occurs with 1.0.10, 1.0.11rc1, and (currently) 1.0.11rc2
   alsaconf reports I have no sound card.
   cat /proc/asound/cards reports I have no sound card.


with BIOS set to "Enable" for sound chip:

 `/sbin/modprobe snd-cs4236 port=0x530 cport=0x538 isapnp=0 dma1=1 dma2=0
irq=5`

  ..produces nothing on stdout/stderr, but the laptop speakers click once,
and dmesg shows:

 "ALSA /path/to/alsa/source/isa/cs423x/cs4236_lib.c:305: CS4236+ chip
detected, but control port 0x538 is not valid"

  - that message shows up in dmesg regardless of what i specify for
'cport=' parameter (with, of course, the corresponding port value in the
error message).

  alsaconf seems to find the card, test the card, and reports all is fine;
offers to modify /etc/modprobe.conf (with parameters shown above), and
congratulates me.
  cat /proc/asound/cards reports I have no sound card.


In looking at cs4236_lib.c, lines 301-307:

        ver1 = snd_cs4236_ctrl_in(chip, 1);
        ver2 = snd_cs4236_ext_in(chip, CS4236_VERSION);
        snd_printdd("CS4236: [0x%lx] C1 (version) = 0x%x, ext = 0x%x\n",
cport, ver1, ver2);
        if (ver1 != ver2) {
                snd_printk("CS4236+ chip detected, but control port 0x%lx
is not valid\n", cport);
                snd_device_free(card, chip);
                return -ENODEV;
        }

  ...it looks like ver1 and ver2 aren't agreeing.  ;)   Okay, so I
experimented a bit.  I commented out (#if 0 ... #endif) the if (ver1 !=
ver2) {...} block, and added:

   snd_printk("CS4236: [0x%lx] C1 (version) = 0x%x, ext = 0x%x\n", cport,
ver1, ver2);

 ...recompiled, reinstalled... and then:

  `modprobe snd-cs4236 port=0x530 cport=0x538 isapnp=0 dma1=1 dma2=0
irq=5`

  results in:

   /dev/dsp, /dev/audio, /dev/snd/* all appear, laptop speakers click once
(as before), followed quickly by a <blart>, and we're on our way...
almost.

  my shorthand dmesg (printk) shows me that the driver was unloading
because 0xFF did not equal 0xE8. (I'm going from memory here.  I'm
positive that the value of "ver1" was 0xFF -- not quite sure about "ver2",
but it's close.  ..it definitely wasn't 0xFF (obviously!) which is why the
driver load aborted).

  cat /proc/asound/cards reports card 0 is a CS4237B at IRQ 5, DMA 1,0

  in KDE, kmix loads and allows me to play with buttons/sliders - I can
get CD audio to play out the laptop speakers, but other audio does not
work.  xmms will load an mp3 file, but when I click the play button, the
display shows 0:00, and nothing plays.  No sound, and the "progress bar"
and "time remaining" stay at 0.

  in terminal, `alsamixer` results in a segmentation fault.

  ..incidentally, in this "hacked" module, it doesn't really matter what
(reasonable) value I specify for cport= in /etc/modprobe.conf (0x538,
0x120, 0x110 ...).  The result is the same.  kmix allows some adjustment,
cd audio plays, no other sound, and alsamixer seg faults.  No doubt, if I
were to work at it, I could generate a kernel panic with the right
value... ;)




======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001779 alsaconf creates incorrect configuratio...
======================================================================

----------------------------------------------------------------------
 briand - 01-21-06 03:48 
----------------------------------------------------------------------
...anybody?

I tried to file-attach the manufacturer's spec sheet for the CS4237B chip
(1.4M), but the upload software here kept crashing during the upload
phase.

----------------------------------------------------------------------
 rlrevell - 01-21-06 04:13 
----------------------------------------------------------------------
Don't bother uploading the spec sheet, if it's available on the web
already.

Did this ever work with any previous kernel?  Does the OSS driver work?

----------------------------------------------------------------------
 briand - 01-21-06 14:41 
----------------------------------------------------------------------
re: the spec sheet:  It is no longer available on the manufacturer's
(Cirrus Logic) web site.  I did find one place (an IBM laptop site,
concerned with making drivers for OS/2 and OS/2 Warp) that had a link to a
"local copy" of the PDF file.  So, the file is not easily found, but out
there.  If it is  needed/wanted, I have a copy I can send via email.

I have not tried installing any earlier kernel on this machine,
personally, but have read anecdotal evidence on the web (google search)
that sound had not worked with the OSS driver(s), and everyone (FC2 era
and earlier) that wrote about success with ALSA drivers did not get it to
work as a PnP device, ever.

I think the most recent modification to the driver (snd-cs4236) added the
section outlined above (in cs4236_lib.c) to solve some (other, unknown to
me) problems with actual cs4236 and cs4236b chips, but it appears (at that
point) to have broken support for the cs4237b chip at that time.  My
opinion here is bolstered by the fact that alsaconf purports to find the
chip (albeit, not when it's in PnP mode) and "goes through the motions" to
probe it, install the driver (and it always picks snd-cs4236), and even
claims to have !tested! it (admittedly, this test goes by pretty quick,
and no audio is heard outside of a couple clicks).  The actual driver,
however, doesn't load ("CS4236+ chip detected, but control port 0x538 is
not valid"), even when alsaconf is in the midst of
loading/testing/installing it.

I have not read anywhere online, nor talked to anybody (live or online)
that has had success loading the driver (recent vintage) in "explicit"
mode (it now aborts loading at the code snippet posted above), nor ever
having loaded it successfully in PnP mode.

My opinion (at this point) is that:

a) PnP has never worked for this chip, using any version of any driver,
and that 

b) those who have had success in the past (using snd-cs4232 and later,
snd-4236) did so by bypassing PnP (isapnp=0) and explicitly passing
parameters, using an ALSA driver created before the most recent changes to
the cs4236 library.

Perhaps all that is needed is for this chip to be properly "identified" so
that it passes the (ver1 == ver2) test [above].  Maybe it needs a whole
new driver; I don't know.  I am certainly willing to work with the
developers to help pinpoint the problem(s), and get sound working on this
laptop.  :)

----------------------------------------------------------------------
 perex - 01-22-06 10:18 
----------------------------------------------------------------------
What's output from this command on your machine (try to toggle the BIOS PnP
OS option as well)?

" for i in /sys/bus/pnp/devices/* ; do cat $i/id ; cat $i/resources ; done
"

----------------------------------------------------------------------
 briand - 01-22-06 17:38 
----------------------------------------------------------------------
1) ----- BIOS ---------------------
   Plug & Play O/S      [No]

   Audio:               [Enabled]
     SB I/O address:    [220h]
     WSS I/O address:   [530h]
     AdLib I/O address: [388h]
     Interrupt:         [IRQ 5]
     1st DMA channel:   [DMA 1]
     2nd DMA channel:   [DMA 0]
   --------------------------------

   with snd-cs4236 (compiled from 1.0.11rc2 source) installed during
boot:
       ----- /etc/modprobe.conf
---------------------------------------------
       alias snd-card-0 snd-cs4236
       alias sound-slot-0 snd-cs4236
       options snd-cs4236 port=0x530 cport=0x538 isapnp=0 dma1=1 dma2=0
irq=5
      
----------------------------------------------------------------------

[root@scribbler ~]# for i in /sys/bus/pnp/devices/* ; do cat $i/id ; cat
$i/resources ; done
cat: /sys/bus/pnp/devices/*/id: No such file or directory
cat: /sys/bus/pnp/devices/*/resources: No such file or directory
[root@scribbler ~]#

2) BIOS settings the same
   sound in /etc/modprobe.conf commented out

[root@scribbler ~]# for i in /sys/bus/pnp/devices/* ; do cat $i/id ; cat
$i/resources ; done
cat: /sys/bus/pnp/devices/*/id: No such file or directory
cat: /sys/bus/pnp/devices/*/resources: No such file or directory
[root@scribbler ~]#

3) ----- BIOS ---------------------
   Plug & Play O/S      [Yes]

   Audio:               [PnPOS]
   --------------------------------

   with snd-cs4236 (compiled from 1.0.11rc2 source) installed during
boot:
       ----- /etc/modprobe.conf
---------------------------------------------
       alias snd-card-0 snd-cs4236
       alias sound-slot-0 snd-cs4236
      
----------------------------------------------------------------------

[root@scribbler ~]# modprobe snd-cs4236
FATAL: Error inserting snd_cs4236
(/lib/modules/2.6.9-1.667/kernel/sound/isa/cs423x/snd-cs4236.ko): No such
device
[root@scribbler ~]# for i in /sys/bus/pnp/devices/* ; do cat $i/id ; cat
$i/resources ; done
cat: /sys/bus/pnp/devices/*/id: No such file or directory
cat: /sys/bus/pnp/devices/*/resources: No such file or directory
[root@scribbler ~]#

4) BIOS settings the same
   sound in /etc/modprobe.conf commented out

[root@scribbler ~]# for i in /sys/bus/pnp/devices/* ; do cat $i/id ; cat
$i/resources ; done
cat: /sys/bus/pnp/devices/*/id: No such file or directory
cat: /sys/bus/pnp/devices/*/resources: No such file or directory
[root@scribbler ~]#

----------------------------------------------------------------------
 perex - 01-22-06 19:45 
----------------------------------------------------------------------
hmm. does FC3 have sysfs enabled (post output from mount here)? the
directory /sys/bus/pnp should exist...

----------------------------------------------------------------------
 briand - 01-22-06 20:52 
----------------------------------------------------------------------
[root@scribbler ~]# mount
/dev/hda5 on / type ext3 (rw)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /dev/pts type devpts (rw,gid=5,mode=620)
usbfs on /proc/bus/usb type usbfs (rw)
/dev/hda2 on /boot type ext3 (rw)
none on /dev/shm type tmpfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)

----------------------------------------------------------------------
 perex - 01-22-06 21:20 
----------------------------------------------------------------------
I see. It seems that your system does not support ACPI and PnP BIOS access
might be disabled in your kernel (CONFIG_PNPBIOS). Try to find the right
cport value, it might be also something line 0x100, 0x110, 0x120 on some
systems. Also, if you have dual-boot machine, windows might provide the
resource map information for audio device.



----------------------------------------------------------------------
 briand - 01-22-06 22:35 
----------------------------------------------------------------------
I would presume those were the exact configuration gymnastics performed by
the alsaconf utility, when it "successfully exited" and modified my
/etc/modprobe.conf file to specify a cport=0x538 parameter.

I can assure you that, despite the output of alsaconf, I have tried a
rather large variety of cport= settings, including the one (0x538) it
recommended and most often quoted in various wikis, blogs, forums, and
bugtracker databases available on the web.

I just tried 0x100, 0x110, and 0x120 again, with the same (unsatisfactory)
result.  I am inferring from your statement that the alsaconf utility did
not, in fact, probe to find the correct control port, so I'll need to do
it manually. 
 
What would be the minimum value, maximum value, and incremental step for
this parameter? 0x100, 0x101, 0x102 ... 0xFFF   ??  

If so, that's a lot of rebooting... or is it sufficient to simply
/sbin/modprobe -r snd-cs4236 and /sbin/modprobe snd-cs4236 3,839 times?

----------------------------------------------------------------------
 rlrevell - 01-22-06 23:09 
----------------------------------------------------------------------
What if you enable CONFIG_PNPBIOS?

----------------------------------------------------------------------
 briand - 01-23-06 01:25 
----------------------------------------------------------------------
sure.  I'll try that.

what do I need to do?

There is no CONFIG_PNPBIOS verb anywhere in the kernel .config file...

----------------------------------------------------------------------
 rlrevell - 01-23-06 01:36 
----------------------------------------------------------------------
I guess it's CONFIG_PNP

----------------------------------------------------------------------
 briand - 01-23-06 02:15 
----------------------------------------------------------------------
ah, no.. I have (had?) a CONFIG_PNP verb, and it was set to 'yes'

...looks like it's something that was added after 2.6.9 ...I'm installing
2.6.15.1, and I'll turn on CONFIG_PNPBIOS in that kernel build, and report
back.

----------------------------------------------------------------------
 briand - 01-24-06 00:44 
----------------------------------------------------------------------
okay...

I downloaded, compiled, and installed 2.6.15.1 with CONFIG_PNPBIOS
enabled.

 1) my network card is no longer recognized.  :(
 2) ..but, I was able to run your script against the /sys/bus/pnp/devices
directory.

  ...from that listing, I determined that the cport may well be 0xF00
(hmm.. yeah, it would have taken quite a while to find that value by
picking sequential port numbers starting at 0x100!!).  

  Armed with this information, I modified /etc/modprobe.conf accordingly,
rebooted back into 2.6.9-1.667 with a side-trip into BIOS to turn PnP off
again, and I now have the driver loaded.

  ...but, I'm where I was with the "hacked" version -- I can play CDs, but
no digital sound formats.  xmms will load, for instance, an MP3 file, but
will not play it.  I can open KMix in KDE and fiddle with some (but not
all) settings (some show a slider, but won't allow me to move it, for
instance).  If I run 'alsamixer' at the terminal prompt, it promptly spits
out a segmentation fault and screws up my terminal settings (no
scrollback, no cursor, no linefeed until I close the ssh session and
re-open it, but even then the cursor and scrollback are still MIA).

   So, I guess this bug (cannot load driver) can be closed out.. but
there's obviously still a problem with a) alsaconf, which couldn't find
the correct control port, and lied about it, and b) mostly non-functional
CS4237B support in the CS4236 driver, as well as c) seg fault running
alsamixer.

   I guess there is progress here.. but still some work to be done.  :/

----------------------------------------------------------------------
 rlrevell - 01-24-06 01:12 
----------------------------------------------------------------------
When alsamixer segfaults do you see an Oops in the dmesg output?

Can you run alsamixer under gdb and get a backtrace?

Are you using the latest alsamixer?

----------------------------------------------------------------------
 rlrevell - 01-24-06 01:17 
----------------------------------------------------------------------
Also, do you have the same problem if you run alsa-driver 1.0.11-rc2 +
kernel 2.6.15.1 as 2.6.9?

----------------------------------------------------------------------
 briand - 01-24-06 01:31 
----------------------------------------------------------------------
no, there is no (additional) output in dmesg following the seg fault. 
Nothing in /var/log/messages, either.

the alsamixer on this laptop is from alsa-utils-1.0.11rc2, compiled and
installed mere moments after the cs4236 driver (from
alsa-driver-1.0.11rc2).

yes, I get the same results when the driver is loaded explicitly or via
PnP under 2.6.15.1 -- the only difference under that kernel seems to be
that PNPBIOS conflicts with detecting my network card, so i get to type on
the tiny laptop keyboard rather than this one. ;)

re: gdb -- it is installed on the laptop, but I have never set it up or
used it... if you'll tell me what to do to get the backtrace, I'd be happy
to oblige.

 :)

----------------------------------------------------------------------
 briand - 01-24-06 02:05 
----------------------------------------------------------------------
okay, easy enough to figure out.  ;)



-------------------------------------------------------------------------
 Program received signal SIGSEGV, Segmentation fault.
 [Switching to Thread -151070048 (LWP 2716)]
 0x00000000 in ?? ()
 (gdb) backtrace
 #0  0x00000000 in ?? ()
 #1  0x0804b307 in mixer_update_cbar (elem_index=0) at alsamixer.c:991
 #2  0x0804e4c1 in main (argc=1, argv=0xfee10b94) at alsamixer.c:1146
 (gdb)
 -------------------------------------------------------------------------

----------------------------------------------------------------------
 perex - 01-24-06 11:16 
----------------------------------------------------------------------
Too many problems. I'm closing this bug, please, open two new bugs (select
appropriate project) and add the relation to this bug:

1) alsaconf creates wrong configuration for snd-cs4236
2) alsamixer segfault (privide output from 'amixer contents' and 'amixer
scontents' commands to this new bug)
3) try aplay with some wav file, it if exits with -EIO (I/O error), then
provide related output from /var/log/messages and create another
bug-report
about digital audio output problem

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-14-06 23:47 briand         New Issue                                    
01-14-06 23:47 briand         Distribution              => Fedora Core 3   
01-14-06 23:47 briand         Kernel Version            => 2.6.9-1.667     
01-14-06 23:51 briand         Issue Monitored: briand                      
01-21-06 03:48 briand         Note Added: 0007733                          
01-21-06 04:13 rlrevell       Note Added: 0007734                          
01-21-06 14:41 briand         Note Added: 0007739                          
01-22-06 10:18 perex          Note Added: 0007744                          
01-22-06 17:38 briand         Note Added: 0007750                          
01-22-06 19:45 perex          Note Added: 0007751                          
01-22-06 20:52 briand         Note Added: 0007752                          
01-22-06 21:19 perex          Note Added: 0007753                          
01-22-06 21:20 perex          Note Edited: 0007753                         
01-22-06 22:35 briand         Note Added: 0007754                          
01-22-06 23:09 rlrevell       Note Added: 0007755                          
01-23-06 01:25 briand         Note Added: 0007756                          
01-23-06 01:36 rlrevell       Note Added: 0007757                          
01-23-06 02:15 briand         Note Added: 0007758                          
01-24-06 00:44 briand         Note Added: 0007765                          
01-24-06 01:12 rlrevell       Note Added: 0007766                          
01-24-06 01:17 rlrevell       Note Added: 0007767                          
01-24-06 01:31 briand         Note Added: 0007769                          
01-24-06 02:05 briand         Note Added: 0007770                          
01-24-06 11:16 perex          Status                   new => resolved     
01-24-06 11:16 perex          Resolution               open => fixed       
01-24-06 11:16 perex          Assigned To               => perex           
01-24-06 11:16 perex          Note Added: 0007772                          
01-29-06 15:13 perex          Relationship added       related to 0001779  
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
