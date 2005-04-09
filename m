From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000321]: Left front channel always muted on boot
Date: Sat, 9 Apr 2005 17:24:57 +0200
Message-ID: <042adccf69bdeb7dd014a5968f36a011@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id F3835220
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 17:24:57 +0200 (MEST)
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


The following issue has been ACKNOWLEDGED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=321> 
======================================================================
Reported By:                64bitten
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   321
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     acknowledged
Distribution:               gentoo
Kernel Version:             2.6.6
======================================================================
Date Submitted:             06-02-2004 08:09 CEST
Last Modified:              04-09-2005 17:24 CEST
======================================================================
Summary:                    Left front channel always muted on boot
Description: 
ice1724 (M Audio Revolution 7.1 in my case) always restores the mixer
settings at boot, but the left front channel is muted regardless.  The fix
is to run alsamixer and adjust the slider again.  This forces the channel
to unmute.  Should I be worried "amixer scontrols" reports everything as
"Mono" as well?
======================================================================

----------------------------------------------------------------------
 K6-III - 12-17-04 03:15 
----------------------------------------------------------------------
Happens to me as well with the Revo 7.1.

----------------------------------------------------------------------
 herby - 12-17-04 06:46 
----------------------------------------------------------------------
I've got an M-Audio Revolution 7.1 as well.  I noted that after boot it
mutes a channel as well.  This was back using ALSA 0.9.6.  What I did to
get around it was to set the level down, then up a bit.  While it didn't
cure the base problem, it was a viable work around.  The problem has
existed for quite a few revisions.  While this does not provide a cure, it
does show that the problem has existed for a while.  If I remember, the
problem might be described in the ALSA development mailing list archives.

----------------------------------------------------------------------
 rlrevell - 12-17-04 06:51 
----------------------------------------------------------------------
Please try this:

reboot

amixer > amixer.bad

unmute the muted channel

amixer > amixer.good

then post the output of "diff amixer.bad amixer.good"

----------------------------------------------------------------------
 64bitten - 12-21-04 07:10 
----------------------------------------------------------------------
The files diff identically.  Please see the attached amixer.bad file as an
example of the output.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-02-04 08:09 64bitten       New Issue                                    
06-02-04 08:09 64bitten       Distribution              => gentoo          
06-02-04 08:09 64bitten       Kernel Version            => 2.6.6           
12-17-04 03:15 K6-III         Note Added: 0002845                          
12-17-04 06:46 herby          Note Added: 0002846                          
12-17-04 06:51 rlrevell       Note Added: 0002847                          
12-21-04 07:09 64bitten       File Added: amixer.bad                       
12-21-04 07:10 64bitten       Note Added: 0002896                          
04-09-05 17:24 jdthood        Status                   new => acknowledged 
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
