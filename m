From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000621]: Audigy input
Date: Thu, 31 Mar 2005 20:25:53 +0200
Message-ID: <594d0545a3afb43b5e8ae5c71099213b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4A55624B
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2005 20:25:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=621> 
======================================================================
Reported By:                KoxtaRF
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   621
Category:                   alsamixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             10-31-2004 15:14 CET
Last Modified:              03-31-2005 20:25 CEST
======================================================================
Summary:                    Audigy input
Description: 
I get exactly the same issue as the guy who posted this message:

http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg13087.html

I cannot select any input source to be captured in alsamixer . Moreover,
many of the output sliders cannot be muted by pressing M (like Master or
PCM).
======================================================================

----------------------------------------------------------------------
 pzad - 11-03-04 08:18 
----------------------------------------------------------------------
> I didn't know that it's technically impossible to mute the Master or PCM
channel. 

This is posible, but need changes in driver or usage of ld10k1 (dl10k1).

>However, I remember that I was able to choose the input source to capture
simply clicking space on it. Is there a way to bring it back?

Previous versions uses AC97 ADC and you choose capture source on this
AC97. Now, philips ADC is used (it is 24 bit and has better SNR). AC97 ADC
is used only for Mic. I think, this will be step back. Under windows you
can not capture from only line in too. You can capture only "Analog Mix".

In previous alsa version you can set capture source only on sources mixed
in AC97 all other source didn't have capture switch (Audigy CD,
AudigyDrive inputs, ...).

----------------------------------------------------------------------
 jdthood - 03-20-05 13:29 
----------------------------------------------------------------------
It looks as if this report can be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-31-04 15:14 KoxtaRF        New Issue                                    
10-31-04 15:15 KoxtaRF        Issue Monitored: KoxtaRF                     
10-31-04 15:16 KoxtaRF        Note Added: 0002293                          
11-02-04 09:31 pzad           Note Added: 0002295                          
11-02-04 18:50 KoxtaRF        Note Added: 0002298                          
11-03-04 08:18 pzad           Note Added: 0002303                          
03-20-05 13:29 jdthood        Note Added: 0004085                          
03-31-05 20:25 jdthood        Status                   new => resolved     
03-31-05 20:25 jdthood        Resolution               open => not an issue
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
