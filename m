From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000505]: SPDIF sound distorted on non-48000 rates
Date: Wed, 29 Sep 2004 18:02:04 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040929160204.7C46D5003@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D55B52D4
	for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2004 18:02:04 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000505
======================================================================
Reported By:                ramendik
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     505
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               RH-based
Kernel Version:             2.6.8.1
Resolution:                 fixed
======================================================================
Date Submitted:             09-19-2004 10:03 CEST
Last Modified:              09-29-2004 18:02 CEST
======================================================================
Summary:                    SPDIF sound distorted on non-48000 rates
Description: 
I have an Intel ICH AC97 sound subsystem, on an Intel i865 motherboard(ASUS
P4P800). It has an analog output and an SPDIF output.When I play 48Khz
files, thinks are OK on all outputs. But when I play 44.1 Khz files, the
sound on the SPDIF output is audibly distorted. The analog output is OK.

I am using the 2.6.8.1 kernel, and tried both the ALSA inside it (1.0.4)
and newer alsa-driver 1.0.7rc1. This same problem shows up with 2.6.6 and
2.6.7 kernels. So apparently it's present across several versons of ALSA.

======================================================================

----------------------------------------------------------------------
 tiwai - 09-23-2004 18:37 CEST 
----------------------------------------------------------------------
Which ac97 codec?  Please attach /proc/asound/card0/codec97#0/* files.
Also, check the IEC958 status bits (run iecset) during playback of
44.1kHz samples.

----------------------------------------------------------------------
 ramendik - 09-23-2004 19:50 CEST 
----------------------------------------------------------------------
Well, iecset showed 48000 Hz during the playback of 44100 Hz samples. So
apparently this is the bug. Here is the full result:

# iecset
Mode: consumer
Data: audio
Rate: 48000 Hz
Copyright: protected
Emphasis: none
Category: PCM coder
Original: original
Clock: 1000 ppm

----------------------------------------------------------------------
 ramendik - 09-23-2004 19:52 CEST 
----------------------------------------------------------------------
I have uploaded both files from /proc/asound/card0/codec97#0/ .

----------------------------------------------------------------------
 ramendik - 09-23-2004 19:58 CEST 
----------------------------------------------------------------------
BTW, "iecset rate 44100" does make things better on 44100 Hz - but breaks
them on 48000.

----------------------------------------------------------------------
 tiwai - 09-23-2004 20:06 CEST 
----------------------------------------------------------------------
How about the attached patch (it's already applied to CVS).

----------------------------------------------------------------------
 ramendik - 09-23-2004 22:16 CEST 
----------------------------------------------------------------------
Unfortunately the patch did NOT help. The distortion is in place, and when
a 44100 Hz file is played (using mplayer), iecset still shows a 48000 Hz
sample rate.

----------------------------------------------------------------------
 tiwai - 09-24-2004 12:14 CEST 
----------------------------------------------------------------------
What shows /proc/asound/cards entry?  If it's ICH4, ICH5 or ESB,
try hw:0,2 PCM for SPDIF output.

----------------------------------------------------------------------
 tiwai - 09-24-2004 12:16 CEST 
----------------------------------------------------------------------
Oh, hw:0,2 might be incorrect.  Please check /proc/asound/pcm
and choose the "IEC958" device.

----------------------------------------------------------------------
 ramendik - 09-24-2004 23:42 CEST 
----------------------------------------------------------------------
/proc/asound/cards:

0 [ICH5           ]: ICH - Intel ICH5
                     Intel ICH5 at 0xfebff400, irq 11

/proc/asound/pcm:

00-00: Intel ICH : Intel ICH5 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel ICH5 - MIC ADC : capture 1
00-02: Intel ICH - MIC2 ADC : Intel ICH5 - MIC2 ADC : capture 1
00-03: Intel ICH - ADC2 : Intel ICH5 - ADC2 : capture 1
00-04: Intel ICH - IEC958 : Intel ICH5 - IEC958 : playback 1

When I try alsaplayer -d hw:0,2 myfile.wav , it just says "no such
device". The same with 0,1 and 0,3.

But when I try with hw:0,4 , a strange thing happens. The file does not
start to play, alsaplayer reacts to any button presses (with the mouse) by
requesting a new filename. BUT, iecset shows 44100 Hz now - and this
happens both when the played file is 44100 Hz and when it is 48000 Hz! I
have tried setting the rate back to 48000 Hz with iecset, then running
alsaplayer -d hw:0,4 myfile.wav again ; and iecset showed 44100 Hz again!

----------------------------------------------------------------------
 ramendik - 09-27-2004 05:20 CEST 
----------------------------------------------------------------------
The strange behaviour with hw:0,4 happens both with and without the patch
that is attached here...

----------------------------------------------------------------------
 tiwai - 09-27-2004 15:14 CEST 
----------------------------------------------------------------------
Ok, could you try the new patch (ich4-spdif.dif) for ALSA driver
and ich4-spdif-lib for alsa-lib?  They are to the lastet CVS version.
Hopefully they can be applied to 1.0.7rc1, too.

----------------------------------------------------------------------
 Clemens Ladisch - 09-27-2004 18:22 CEST 
----------------------------------------------------------------------
I uploaded a new version of the patch.

"... & ICH_PCM_SPDIF_MASK" obviously should have been "... &
~ICH_PCM_SPDIF_MASK".

----------------------------------------------------------------------
 ramendik - 09-28-2004 23:37 CEST 
----------------------------------------------------------------------
Finally tested. Sorry for the delay.

Well, with this new patch, when playing directly to hw:0,4 (and only in
this case!), the spdif rate changes in teh right way. 

But for some reason (this was there before, not in the patch) one has to
be root to play to hw:0,4 . Otherwise "access denied"...

And besides, one would expect the sound to work right even when playing to
the default device. And, most important to me, even when using OSS
emulation.

----------------------------------------------------------------------
 ramendik - 09-28-2004 23:42 CEST 
----------------------------------------------------------------------
UPD: read the FAQ and fixed the root-needed problem.

The questions of the default device and of OSS emulation still stand.
After all, sometimes one can want to get output on both SPDIF and the
line-out at the same time.

----------------------------------------------------------------------
 tiwai - 09-29-2004 18:02 CEST 
----------------------------------------------------------------------
Ok, patches are now applied to CVS.

You can't route the same signal to both analog and SPDIF at the same
time on AC97.  It's the design of the chip.  If you'd like to do it,
you have to do it on software (e.g. asoundrc configuration).

For the SPDIF over OSS emulation, use alsa-oss wrapper library.
It can't be done properly on kernel module only.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-19-04 10:03 ramendik       New Bug                                      
09-19-04 10:03 ramendik       Distribution              => RH-based        
09-19-04 10:03 ramendik       Kernel Version            => 2.6.8.1         
09-19-04 10:05 ramendik       Bug Monitored: ramendik                      
09-23-04 18:37 tiwai          Bugnote Added: 0001831                       
09-23-04 19:50 ramendik       Bugnote Added: 0001839                       
09-23-04 19:51 ramendik       File Added: ac97#0-0                         
09-23-04 19:52 ramendik       File Added: ac97#0-0+regs                    
09-23-04 19:52 ramendik       Bugnote Added: 0001843                       
09-23-04 19:58 ramendik       Bugnote Added: 0001845                       
09-23-04 20:06 tiwai          Bugnote Added: 0001846                       
09-23-04 20:06 tiwai          File Added: intel-spdif-fix.dif                    
09-23-04 22:16 ramendik       Bugnote Added: 0001852                       
09-24-04 12:14 tiwai          Bugnote Added: 0001871                       
09-24-04 12:16 tiwai          Bugnote Added: 0001872                       
09-24-04 23:42 ramendik       Bugnote Added: 0001906                       
09-27-04 05:20 ramendik       Bugnote Added: 0001931                       
09-27-04 15:14 tiwai          Bugnote Added: 0001938                       
09-27-04 15:14 tiwai          File Added: ich4-spdif.dif                    
09-27-04 15:15 tiwai          File Added: ich4-spdif-lib.dif                    
09-27-04 18:20 Clemens LadischFile Added: ich4-spdif.dif                    
09-27-04 18:22 Clemens LadischBugnote Added: 0001941                       
09-28-04 23:37 ramendik       Bugnote Added: 0001961                       
09-28-04 23:42 ramendik       Bugnote Added: 0001962                       
09-29-04 18:02 tiwai          Bugnote Added: 0001974                       
09-29-04 18:02 tiwai          Assigned To               => tiwai           
09-29-04 18:02 tiwai          Resolution               open => fixed       
09-29-04 18:02 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
