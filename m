From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000416]: Signal but no sound on digital out (Nforce 1)
Date: Sun, 10 Apr 2005 23:49:52 +0200
Message-ID: <b07d87bf24c6b545b6b6e9b16402a5ae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 105FD16E
	for <alsa-devel@alsa-project.org>; Sun, 10 Apr 2005 23:49:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=416> 
======================================================================
Reported By:                bonbons
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   416
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE 9.0
Kernel Version:             2.4.26
======================================================================
Date Submitted:             07-31-2004 21:46 CEST
Last Modified:              04-10-2005 23:49 CEST
======================================================================
Summary:                    Signal but no sound on digital out (Nforce 1)
Description: 
Independently of the status of the "Digital" element in alsamixer (muted or
not) my digital reciever connected to the Digital output of my mainboard
displays availability of PCM signal, but the sound output to my
head-phones through Line-Out is not available on the digital out.

There is no sound at all output to the digital out, no matter what
selections are done in AlsaMixer.

Is there a means to switch output mode of digital output to DolbyDigital
as under Windows and really switch of the Digital output?
======================================================================

----------------------------------------------------------------------
 jdthood - 04-08-05 22:34 
----------------------------------------------------------------------
Submitter: Has this problem been solved in later ALSA releases?

----------------------------------------------------------------------
 bonbons - 04-10-05 23:49 
----------------------------------------------------------------------
With drivers with kernel 2.6.10 (1.0.6) the digital output was never
switched off, no matter what mixer settings were (using alsamixer)

I did test with drives included with Linux-2.6.11 kernel release (1.0.8):

No mixer item has effect on the output to digital out

I was playing sound with this command:
aplay -D plughw:0,2 file.wav

At same time on other console a toggled the mute flags on each channel
individually (using alsamixer), sound output was not muted at all, and
volume changes had no effect either.


PS: How can I test 5.1 channel output to digital out? As all playback I
currently got is stereo PCM

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-31-04 21:46 bonbons        New Issue                                    
07-31-04 21:46 bonbons        Distribution              => SuSE 9.0        
07-31-04 21:46 bonbons        Kernel Version            => 2.4.26          
08-01-04 18:19 bonbons        Note Added: 0001517                          
04-08-05 22:34 jdthood        Note Added: 0004378                          
04-10-05 23:49 bonbons        Note Added: 0004440                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
