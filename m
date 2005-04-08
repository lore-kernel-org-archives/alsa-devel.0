From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000416]: Signal but no sound on digital out (Nforce 1)
Date: Fri, 8 Apr 2005 22:34:36 +0200
Message-ID: <4d41dacf89640ecd77b91c9692065b2e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 247E81D8
	for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2005 22:34:37 +0200 (MEST)
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
Last Modified:              04-08-2005 22:34 CEST
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
 bonbons - 08-01-04 18:19 
----------------------------------------------------------------------
After additionnal trying an looking around, digital out works (PCM mode).
But it seems not possible to mute or stop the digital output.
So the following lines are (partially) incorrect:

"Independently of the status of the "Digital" element in alsamixer (muted
or not) my digital reciever connected to the Digital output of my
mainboard displays availability of PCM signal, but the sound output to my
head-phones through Line-Out is not available on the digital out.
 
There is no sound at all output to the digital out, no matter what
selections are done in AlsaMixer."

The last part about mutichannel digital output is still unknown...

----------------------------------------------------------------------
 jdthood - 04-08-05 22:34 
----------------------------------------------------------------------
Submitter: Has this problem been solved in later ALSA releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-31-04 21:46 bonbons        New Issue                                    
07-31-04 21:46 bonbons        Distribution              => SuSE 9.0        
07-31-04 21:46 bonbons        Kernel Version            => 2.4.26          
08-01-04 18:19 bonbons        Note Added: 0001517                          
04-08-05 22:34 jdthood        Note Added: 0004378                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
