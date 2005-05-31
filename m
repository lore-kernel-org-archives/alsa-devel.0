From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001004]: Doesn't accept all sample rates, when capturing sound in S16_LE or S16_BE format.
Date: Tue, 31 May 2005 17:56:50 +0200
Message-ID: <f9808f25e35379e3aa1efb041985bc17@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E381B1B6
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 17:56:50 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1004> 
======================================================================
Reported By:                hyp
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1004
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Slackware
Kernel Version:             2.4.29
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-21-2005 19:26 CET
Last Modified:              05-31-2005 17:56 CEST
======================================================================
Summary:                    Doesn't accept all sample rates, when capturing
sound in S16_LE or S16_BE format.
Description: 
When I request to capture sound with: 8000Hz, S16 LE, stereo the ioctl
returns me that the accepted values are the same as requested. But the
whole read()-ed data is captured with 44100 or 48000Hz (I don't know 
the right value, I guess it by ear), independendly from the requested
sample rate.

I tried to capture sound via sox's recorder. For example with command:
# rec -c 1 -d /dev/dsp0 -f s -r 8000 p.snd
When I started to play this file, I noticed that the file is captured 
with 44100 or 48000Hz sample rate, but in the .snd header are written
that the file is recorder with 8000Hz sample rate (as I have requested 
it). If I set the sample rate to 48000 and play the tune, it sounds 
good. Also this problem can be seen with my own oss recorder.

When I'm using anouther sound card, for example Creative Ensoniq 1371
or Creative EMU10K1 everything is good!

best regards.
======================================================================

----------------------------------------------------------------------
 hyp - 03-21-05 19:30 
----------------------------------------------------------------------
ups...
Intel ICH5 with Analog Devices AD1985

----------------------------------------------------------------------
 hyp - 03-22-05 09:43 
----------------------------------------------------------------------
I'm sorry for my confusion!!!
This is a side effect from an improper loading of snd-ca0106, which card
doesn't exist.
So this post can be closed...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-21-05 19:26 hyp            New Issue                                    
03-21-05 19:26 hyp            Distribution              => Slackware       
03-21-05 19:26 hyp            Kernel Version            => 2.4.29          
03-21-05 19:30 hyp            Note Added: 0004121                          
03-22-05 09:43 hyp            Note Added: 0004123                          
03-29-05 19:03 tiwai          Status                   new => resolved     
03-29-05 19:03 tiwai          Resolution               open => not an issue
03-29-05 19:03 tiwai          Assigned To               => tiwai           
05-31-05 17:56 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
