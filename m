From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000669]: Creative SB Live! 24-bit External (USB) works only at a minimal level.
Date: Sat, 3 Dec 2005 16:51:37 +0100
Message-ID: <68576dfa04d6dcf828676b24c8850815@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 486A216F
	for <alsa-devel@alsa-project.org>; Sat,  3 Dec 2005 16:51:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=669> 
======================================================================
Reported By:                Henni
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   669
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo 2004.3
Kernel Version:             2.6.9-cko3
======================================================================
Date Submitted:             11-23-2004 19:23 CET
Last Modified:              12-03-2005 16:51 CET
======================================================================
Summary:                    Creative SB Live! 24-bit External (USB) works only
at a minimal level.
Description: 
The Creative SB Live! 24-bit External is a "card" similar to the Audigy 2
NX (probably its litte brother).

With the snd-usb-audio the ''only'' thing working is the stereo output. I
read that the Audigy 2 NX works far better with the snd-usb-audio.
Probably there is a way to get the SB Live! 24-bit on a similar lvl?

PS: I added some informations about it as an attachment.

======================================================================

----------------------------------------------------------------------
 Henni - 05-23-05 12:37 
----------------------------------------------------------------------
I retested everything with ALSA Version 1.0.9-rc3 and now the Optical
Digital Out works perfect (I didn't test the Coaxial Out) with mplayer:

Tested with following output formats:

*) Dolby Digital AC3 2.0
*) Dolby Digital AC3 5.1
*) DTS 5.1
*) DTS 6.1
*) PCM

Only thing you have to is to set the AudioOut Device of mplayer to -ao
alsa:device=default (if you try to use -ao alsa without device=default it
tries to open a iec9.. device which doesn't work) and using Audiocodec
hwac3 (for DD) or hwdts (for DTS).

4 Channel and 6 Channel Mode are working perfectly (at the DigitalOut you
only get PCM-Stereo) using the Speaker outputs of the device.

There are no more problems setting the Volume higher than aroung 75% (in
the past it stopped playing and you had to reload the driver). The only
thing you have to do is to unmute it when you change the output at the
device (as an example if you unplug the digital-out and plug in
headphones.)

----------------------------------------------------------------------
 rev_jazz - 12-03-05 16:51 
----------------------------------------------------------------------
No digital passthrough for Creative Audigy 2 NX

I tried with alsa1.0.9a (on an ubuntu) to wake work the ac3 passthrough
(with an extarnal decoder) usiing the coaxial digital out. It didn't work
fine at all neither using mplayer with -ao alsa:device=default -ac hwac3
nor with xine. mplayer issues in two ways:
1- says :
alsa-init: 1 soundcard found, using: iec958:{CARD 0 AES0 0x02 AES1 0x82
AES2 0x0 0 AES3 0x02}
ALSA lib pcm.c:1959:(snd_pcm_open_conf) Invalid type for PCM iec958:{CARD
0 AES0  0x02 AES1 0x82 AES2 0x00 AES3 0x02} definition (id: iec958, value:
cards.pcm.ie c958)


or


2- sends to extarnal amplifier lots of crack and gap noise

It's to be no configuration way to make the ac3/dts digital out
passthrough work

regards,

jazz


PS: alsa default is set to PCM

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-04 19:23 Henni          New Issue                                    
11-23-04 19:23 Henni          File Added: output.txt                       
11-23-04 19:23 Henni          Distribution              => Gentoo 2004.3   
11-23-04 19:23 Henni          Kernel Version            => 2.6.9-cko3      
11-23-04 19:58 Henni          Issue Monitored: Henni                       
11-23-04 21:09 pzad           Note Added: 0002527                          
11-24-04 00:51 Henni          Note Added: 0002540                          
01-09-05 02:04 kempokaraterulzNote Added: 0003133                          
03-19-05 02:04 chaosmcgruff   Issue Monitored: chaosmcgruff                    
05-23-05 12:37 Henni          Note Added: 0004703                          
12-03-05 16:51 rev_jazz       Note Added: 0006899                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
