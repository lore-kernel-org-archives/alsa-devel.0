From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000621]: Audigy input
Date: Wed, 3 Nov 2004 08:18:47 +0100
Message-ID: <183b17fa10b1adb6b4521a40de0a6c20@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 129D32DD
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2004 08:18:47 +0100 (MET)
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
Status:                     new
======================================================================
Date Submitted:             10-31-2004 15:14 CET
Last Modified:              11-03-2004 08:18 CET
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
 KoxtaRF - 11-02-04 18:50 
----------------------------------------------------------------------
No, I didn't.... I didn't know that it's technically impossible to mute the
Master or PCM channel. However, I remember that I was able to choose the
input source to capture simply clicking space on it. Is there a way to
bring it back?

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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-31-04 15:14 KoxtaRF        New Issue                                    
10-31-04 15:15 KoxtaRF        Issue Monitored: KoxtaRF                     
10-31-04 15:16 KoxtaRF        Note Added: 0002293                          
11-02-04 09:31 pzad           Note Added: 0002295                          
11-02-04 18:50 KoxtaRF        Note Added: 0002298                          
11-03-04 08:18 pzad           Note Added: 0002303                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
