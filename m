From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000506]: Hercules Fortissimo II (Gamesurround 5.1 digital edition) has no sound on headphone output
Date: Fri,  8 Oct 2004 20:25:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041008182520.6BA704800E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BE360275
	for <alsa-devel@alsa-project.org>; Fri,  8 Oct 2004 20:25:20 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000506
======================================================================
Reported By:                bekker
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     506
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             kernel 2.6.8-gentoo-r3.
======================================================================
Date Submitted:             09-19-2004 13:40 CEST
Last Modified:              10-08-2004 20:25 CEST
======================================================================
Summary:                    Hercules Fortissimo II (Gamesurround 5.1 digital edition) has no sound on headphone output
Description: 
the Fortissimo II card has seperate outputs for front, rear speakers and
headphone. I cannot get sound on the headphone. 

Front (HW:0,0) and rear speakers (HW:0,1) work.IEC958 (HW:0,2) is also
available but I have not tested it.

The slider marked as headphone in the mixer actually controls the rear
speaker volume. 


======================================================================

----------------------------------------------------------------------
 bekker - 09-19-2004 13:41 CEST 
----------------------------------------------------------------------
I had the same issue on Mandrake 9.2, Mandrake 10.

----------------------------------------------------------------------
 tiwai - 09-20-2004 17:39 CEST 
----------------------------------------------------------------------
So far, only 4.0 output is supported on cs46xx driver.

----------------------------------------------------------------------
 bekker - 09-21-2004 20:01 CEST 
----------------------------------------------------------------------
Fair enough. Is 5.1 support planned?

----------------------------------------------------------------------
 tiwai - 09-23-2004 18:34 CEST 
----------------------------------------------------------------------
Sorry, no plan AFAIK.
Benny might help for further development of 5.1 support (see
cs46xx source codes for his address).

----------------------------------------------------------------------
 tiwai - 10-06-2004 11:33 CEST 
----------------------------------------------------------------------
Well, I misinformed -- 5.1 output is supported on CS46xx when
dual codecs are detected.  But, in your case, the board seems to
have only one codec.

Could you show the files in /proc/asound/card0/codec*/* files?

----------------------------------------------------------------------
 bekker - 10-07-2004 22:25 CEST 
----------------------------------------------------------------------
I only have /proc/asound/card0/codec97#0/

ls -l /proc/asound/card0/codec97#0/:

-r--r--r--  1 root root 0 Oct  7 22:25 ac97#0-0
-r--r--r--  1 root root 0 Oct  7 22:25 ac97#0-0+regs

Hope this helps

----------------------------------------------------------------------
 tiwai - 10-08-2004 12:15 CEST 
----------------------------------------------------------------------
Oh I meant the contents of the files :)  Please attach them.

----------------------------------------------------------------------
 bekker - 10-08-2004 14:38 CEST 
----------------------------------------------------------------------
ac97#0-0:

0-0/0: Cirrus Logic CS4294 rev 5

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Crystal Semi 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended modem ID: codec=0 HSET LIN1
Modem status     : GPIO MREF ADC1 DAC1 HADC HDAC
Line1 rate       : 48000Hz
Headset rate     : 48000Hz

ac97#0-0+regs

0:00 = 1990
0:02 = 0d0d
0:04 = 1e1e
0:06 = 0000
0:08 = 0000
0:0a = 0000
0:0c = 0000
0:0e = 001f
0:10 = 0a0a
0:12 = 0e0e
0:14 = 0000
0:16 = 0d0d
0:18 = 0b0b
0:1a = 0000
0:1c = 0909
0:1e = 8000
0:20 = 0000
0:22 = 0007
0:24 = 0000
0:26 = 000f
0:28 = 0000
0:2a = 0000
0:2c = bb80
0:2e = bb80
0:30 = bb80
0:32 = bb80
0:34 = bb80
0:36 = 8080
0:38 = 8080
0:3a = 0000
0:3c = 0005
0:3e = 00cf
0:40 = bb80
0:42 = bb80
0:44 = bb80
0:46 = 8080
0:48 = 8080
0:4a = 8080
0:4c = 03fe
0:4e = fffe
0:50 = 03ff
0:52 = 0000
0:54 = 0018
0:56 = 0000
0:58 = 0000
0:5a = 0502
0:5c = 0000
0:5e = 0200
0:60 = 0023
0:62 = 8000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0000
0:74 = 0000
0:76 = 0000
0:78 = 007a
0:7a = 0000
0:7c = 4352
0:7e = 592d

----------------------------------------------------------------------
 tiwai - 10-08-2004 15:22 CEST 
----------------------------------------------------------------------
What happens if you apply the patch below?

----------------------------------------------------------------------
 bekker - 10-08-2004 20:25 CEST 
----------------------------------------------------------------------
how do I apply this patch?

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-19-04 13:40 bekker         New Bug                                      
09-19-04 13:40 bekker         Distribution              => Gentoo Linux    
09-19-04 13:40 bekker         Kernel Version            => kernel 2.6.8-gentoo-r3.
09-19-04 13:41 bekker         Bugnote Added: 0001784                       
09-20-04 17:39 tiwai          Bugnote Added: 0001789                       
09-21-04 20:01 bekker         Bugnote Added: 0001808                       
09-23-04 18:34 tiwai          Bugnote Added: 0001830                       
10-06-04 11:33 tiwai          Bugnote Added: 0002019                       
10-07-04 22:25 bekker         Bugnote Added: 0002040                       
10-08-04 12:15 tiwai          Bugnote Added: 0002046                       
10-08-04 14:38 bekker         Bugnote Added: 0002051                       
10-08-04 15:22 tiwai          Bugnote Added: 0002052                       
10-08-04 15:23 tiwai          File Added: cs46xx-force-cl.dif                    
10-08-04 20:25 bekker         Bugnote Added: 0002056                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
