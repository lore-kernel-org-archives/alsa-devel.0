From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001726]: Front and Rear channels swap after first play when playing Surround40 on au8830
Date: Fri, 3 Mar 2006 07:18:29 +0100
Message-ID: <2bae370e60a68b11b367ab5c282ee2c5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 043A616C
	for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2006 07:18:29 +0100 (MET)
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
Last Modified:              03-03-2006 07:18 CET
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
 Raymond - 02-28-06 04:42 
----------------------------------------------------------------------
xine seem to work but mplayer does not, center can be sent to device 2
instead of device 0

<confdir:pcm/surround51.conf>

AU8830.pcm.surround51.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type multi
	slaves [
		{
			pcm {
				@func concat
				strings [
					"cards.AU8830.pcm.surround40.0:CARD=" $CARD
				]
			}
			channels 4
		}
		{
			pcm {
				@func concat
				strings [
					"cards.AU8830.pcm.surround40.0:CARD=" $CARD
				]
			}
			channels 1
		}
		{
			pcm {
				@func concat
				strings [
					"cards.AU8830.pcm.surround40.0:CARD=" $CARD
				]
			}
			channels 1
		}
	]
	bindings [
		{ slave 0 channel 0 }
		{ slave 0 channel 1 }
		{ slave 0 channel 2 }
		{ slave 0 channel 3 }
		{ slave 1 channel 0 }
		{ slave 2 channel 0 }
	]
}

----------------------------------------------------------------------
 Raymond - 03-03-06 07:18 
----------------------------------------------------------------------
As hook function is called when snd_xxx_pcm_open(), using hook and
subdevice volume control cannot provide a true "front" and "rear" device
since the hardware mixer is allocated at snd_xxx_hw_params().

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
