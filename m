From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001726]: Front and Rear channels swap after first play when playing Surround40 on au8830
Date: Mon, 3 Apr 2006 14:24:15 +0200
Message-ID: <ea7ab4b91ca1223a545f55f99012ac53@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DA02210A
	for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2006 14:24:15 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1726> 
======================================================================
Reported By:                Raymond
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   1726
Category:                   PCI - au88x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 1
Kernel Version:             2.4.22-1.2199.nptl
======================================================================
Date Submitted:             01-08-2006 17:41 CET
Last Modified:              04-03-2006 14:24 CEST
======================================================================
Summary:                    Front and Rear channels swap after first play when
playing Surround40 on au8830
Description: 
The front and rear channels are correct for playing Surround40 only at the
first time after the driver is loaded. 

The front and rear channels (Surround40) always swapped afterward using
speaker-test or xine. 

Playing stereo sound is OK.


 speaker-test -c4 -D hw:0,0
 
speaker-test 1.0.11rc2
 
Playback device is hw:0,0
Stream parameters are 48000Hz, S16_LE, 4 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 2 to 8192
Period size range from 1 to 512
Periods = 4
Buffer time size 2525
To choose buffer_size = 8192
To choose period_size = 2048
was set period_size = 512
was set buffer_size = 8192
 0 - Front Left
 1 - Front Right
 3 - Rear Right
 2 - Rear Left
Time per period = 11.856821
 0 - Front Left
 1 - Front Right
 3 - Rear Right
 2 - Rear Left

======================================================================

----------------------------------------------------------------------
 Raymond - 03-31-06 10:22 
----------------------------------------------------------------------
ponchick,

I have uploaded a diff(alsa-driver-1.0.11rc4) which implement the
"subdevice playback volume" in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1835 , this allow a true
"front" and
"rear" device for au8830 with 4-channels codec.

The following "front" device can only be used by au8830 with 4-channels
codec.

<confdir:pcm/front.conf>

AU8830.pcm.front.0 {
    @args [ CARD ]
    @args.CARD {
        type string
    }
    type hooks
    slave.pcm {
        type hw
        card $CARD
        device 0
    }
    hooks.0 {
        type ctl_elems
        hook_args [
            {
                interface PCM
                device 0
                name "Subdevice Playback Volume"
                index { @func private_pcm_subdevice }
                value [ 0 0 -64 -64 ]
            }
        ]
    }
} 

Please note that the modified "front" and "rear" device cannot be used
with your another au8830 with stereo codec

----------------------------------------------------------------------
 Raymond - 04-03-06 14:24 
----------------------------------------------------------------------
With respect to the change in speaker-test.c , the number of fifo error in
the system log seem to increase with the number of loops to test

-l,--nloops     specify number of loops to test, 0 = infinite


@@ -665,6 +664,7 @@
   double phase = 0;
   int    err, n;
 
+  snd_pcm_prepare(handle);
   if (test_type == TEST_WAV) {
     int bufsize = snd_pcm_frames_to_bytes(handle, period_size);
     n = 0;
@@ -674,6 +674,7 @@
 			      snd_pcm_bytes_to_frames(handle, err * channels))) < 0)
 	break;
     }
+    snd_pcm_drain(handle);
     return err;
   }

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-08-06 17:41 Raymond        New Issue                                    
01-08-06 17:41 Raymond        Distribution              => Fedora Core 1   
01-08-06 17:41 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
01-27-06 16:45 Raymond        File Added: au88x0_surround40.patch               
    
02-04-06 06:26 Raymond        Note Added: 0007912                          
02-10-06 05:36 ponchick       Note Added: 0007987                          
02-10-06 06:32 Raymond        Note Added: 0007991                          
02-10-06 10:50 ponchick       Note Added: 0007998                          
02-10-06 11:25 Raymond        Note Added: 0008000                          
02-10-06 13:49 Raymond        Note Added: 0008003                          
02-10-06 13:56 Raymond        Note Edited: 0008003                         
02-12-06 07:48 Raymond        Note Edited: 0008003                         
02-12-06 10:12 Raymond        Note Edited: 0008000                         
02-16-06 05:37 ponchick       Note Added: 0008085                          
02-16-06 08:12 Raymond        Note Added: 0008088                          
02-16-06 10:12 Raymond        Note Added: 0008090                          
02-16-06 10:28 Raymond        Note Edited: 0008090                         
02-16-06 16:07 Raymond        Note Added: 0008097                          
02-17-06 03:35 ponchick       Note Added: 0008104                          
02-17-06 04:28 Raymond        Note Added: 0008105                          
02-17-06 04:35 Raymond        Note Edited: 0008105                         
02-17-06 05:56 Raymond        Note Edited: 0008105                         
02-17-06 06:09 Raymond        Note Edited: 0008105                         
02-26-06 07:22 ponchick       Note Added: 0008198                          
02-26-06 13:28 Raymond        Note Added: 0008200                          
02-26-06 14:08 Raymond        Note Edited: 0008200                         
02-27-06 06:57 ponchick       Note Added: 0008216                          
02-27-06 14:09 Raymond        Note Added: 0008222                          
02-28-06 04:42 Raymond        Note Added: 0008239                          
03-03-06 07:18 Raymond        Note Added: 0008334                          
03-03-06 09:19 Raymond        Note Edited: 0008334                         
03-24-06 14:57 Raymond        File Added: AU8830.conf                      
03-24-06 15:04 Raymond        Note Added: 0008918                          
03-31-06 10:22 Raymond        Note Added: 0009043                          
04-03-06 14:24 Raymond        Note Added: 0009096                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
