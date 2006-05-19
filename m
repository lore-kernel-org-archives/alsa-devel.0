From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002133]: Lacking support for simple USB "wireless" (via bluetooth A2DP) / no mixer
Date: Fri, 19 May 2006 15:49:36 +0200
Message-ID: <7a34da1526583543b9dcb344b585d41b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C11C01A2
	for <alsa-devel@alsa-project.org>; Fri, 19 May 2006 15:49:36 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2133> 
======================================================================
Reported By:                dx9s
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   2133
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Slackware 10.2
Kernel Version:             2.6.16.16
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-18-2006 08:12 CEST
Last Modified:              05-19-2006 15:49 CEST
======================================================================
Summary:                    Lacking support for simple USB "wireless" (via
bluetooth A2DP) / no mixer
Description: 
was using 2.6.15.6 (packed with alsa-driver 1.0.10rc3), updater to
2.6.16.16 (packed with alsa-driver 1.0.11rc2) and update alsa-driver to
1.0.11 (finial) as well other alsa-*-1.0.11

Hardware: Saitek A-250 http://www.saitekaudio.com/en/a250.asp

according to other resources I've seen, it is a wireless USB audio device
that uses a generic Bluetooth A2DP
(http://en.wikipedia.org/wiki/Bluetooth#Bluetooth_profiles) transport. I
have not used on WinHoles XP but it appears that it uses whatever Native
usb audio support that comes with XP -- so it appears to be generic.

Get error message (enabled advanced alsa debuging, "CONFIG_SND_DEBUG=y")

ALSA /root/src/alsa-driver-1.0.11/usb/usbaudio.c:2670: 3:1:0 : no or
invalid class specific endpoint descriptor

BTW> the Bluetooth transport is not available and only a USB audio device
appears to be present to the system

I have a pure guess that it might ALSO have problem with the hardware not
having a software controllable mixer (mixer is only remote unit). Also
purportedly, it also can function as a HID device from the "remote" (it
has play/pause, next and previous / which it claims will work with
WinHoles Media Player)

Summary: tweaking the driver to support this hardware? It has pretty good
sound for being so small (using the wired LINE input). I've come across
others out there (in the internet) that are interested in using it with
Linux and claim they reached somebody at the company -- which is how I
know it uses A2DP.

--Doug
======================================================================

----------------------------------------------------------------------
 dx9s - 05-19-06 06:04 
----------------------------------------------------------------------
it was a guess... I know very little about USB ... And I am not a driver
programmer (hacked a little bit to change defaults, and that is about
it).

applied the patch (cd alsa-driver-1.0.11; patch -p1 < a250.diff ; make
clean ; make)
got this:
/root/src/alsa-driver-1.0.11/usb/usbaudio.c: In function
`parse_audio_endpoints':
/root/src/alsa-driver-1.0.11/usb/usbaudio.c:2669: error: `KERN_WARN'
undeclared (first use in this function)
/root/src/alsa-driver-1.0.11/usb/usbaudio.c:2669: error: (Each undeclared
identifier is reported only once
/root/src/alsa-driver-1.0.11/usb/usbaudio.c:2669: error: for each function
it appears in.)
/root/src/alsa-driver-1.0.11/usb/usbaudio.c:2669: error: syntax error
before string constant

changed back to KERN_ERR and tried again (it compiled) -- make install,
(reboot for sanity, I know I could have rmmod/insmod)

so the code in question looks like this:

                if (!csep || csep[0] < 7 || csep[2] != EP_GENERAL) {
                        snd_printk(KERN_ERR "%d:%u:%d : no or invalid"
                                   " class specific endpoint
descriptor\n",
                                   dev->devnum, iface_no, altno);
                        csep = NULL;
                }

So not sure what KERN_WARN is missing / unavailable constant.

I am a C/C++ programmer and can usually figure out gcc messages
(sometimes, however some messages are really wierd).

Now just have to ask is KERN_WARN/KERN_ERR something that I should figure
out or what?

BTW> ran xmms for about 2 minutes and it works!!! cool cool cool that is
perhaps the fastest turn around (technically less than two hours!) I just
took to long to review any responses. So now this patch should be
concidered into the next RC???

(cd /proc/asound; cat cards devices):
 0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
                      Intel 82801DB-ICH4 with STAC9750,51 at 0xf4fff800,
irq 17
 1 [Headphones     ]: USB-Audio - CSR Bluetooth Headphones
                      CSR Bluetooth Headphones at usb-0000:00:1d.0-1, full
speed
  0: [ 0]   : control
  1:        : sequencer
 16: [ 0- 0]: digital audio playback
 20: [ 0- 4]: digital audio playback
 24: [ 0- 0]: digital audio capture
 25: [ 0- 1]: digital audio capture
 26: [ 0- 2]: digital audio capture
 27: [ 0- 3]: digital audio capture
 32: [ 1]   : control
 33:        : timer
 48: [ 1- 0]: digital audio playback

P.S.> Kudos!

P.S.^2> Getting some occational clicks (breaks) in the audio ... I don't
think they where there before 802.11b/g wireless activity or not...
(streaming internet radio now) or perhaps a conflict between two wireless
devices... will experiment some more... but audio with minor clicks is
better than NO audio at all!


P.S.^3> without disabling the wireless card, but playing files local (an
ISO of a DVD mount loopback and played with xine dvd:/path/to/dvd_dir and
point to hw:1) -- still get occastional clicks.. but it is minor. not sure
what other than buffering or rate conversion issue?! (different issue I am
sure) but it is sometimes completely missing for a long time, other times
several clicks back to back. -- however I am happy this patch (plus my
changes) works.


P.S.^4> grepped KERN_WARN (cd usb ; grep KERN_WARN) and found this
constant KERN_WARNING... I will try that instead and recompile and
re-install and test... perhaps it was a typo in the patch.. so instead of
my hack KERN_ERR -> KERN_WARNING ??!!??


P.S.^4.1> that worked... leaving that way.. changing my copy of the patch
to KERN_WARNING...



----------------------------------------------------------------------
 Clemens Ladisch - 05-19-06 15:49 
----------------------------------------------------------------------
The KERN_WARN was indeed just a typo.

The patch is now applied to the repository.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-18-06 08:12 dx9s           New Issue                                    
05-18-06 08:12 dx9s           Distribution              => Slackware 10.2  
05-18-06 08:12 dx9s           Kernel Version            => 2.6.16.16       
05-18-06 08:14 dx9s           Issue Monitored: dx9s                        
05-18-06 08:42 dx9s           Note Added: 0009862                          
05-18-06 09:45 Clemens LadischNote Added: 0009863                          
05-18-06 09:45 Clemens LadischFile Added: a250.diff                        
05-19-06 01:53 dx9s           Note Added: 0009870                          
05-19-06 01:59 dx9s           Note Edited: 0009870                         
05-19-06 02:00 dx9s           Note Edited: 0009870                         
05-19-06 02:01 dx9s           Note Edited: 0009870                         
05-19-06 04:06 dx9s           Note Edited: 0009870                         
05-19-06 06:00 dx9s           Note Edited: 0009870                         
05-19-06 06:04 dx9s           Note Edited: 0009870                         
05-19-06 15:49 Clemens LadischStatus                   assigned => resolved
05-19-06 15:49 Clemens LadischResolution               open => fixed       
05-19-06 15:49 Clemens LadischNote Added: 0009877                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
