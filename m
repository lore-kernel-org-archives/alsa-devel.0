From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000321]: Left front channel always muted on boot
Date: Thu, 20 Oct 2005 02:36:43 +0200
Message-ID: <b13ce4aa545c83568786fbe8332413ac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8DBF7169
	for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2005 02:36:43 +0200 (MEST)
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
Last Modified:              10-20-2005 02:36 CEST
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
 64bitten - 12-21-04 07:10 
----------------------------------------------------------------------
The files diff identically.  Please see the attached amixer.bad file as an
example of the output.

----------------------------------------------------------------------
 sst4 - 10-20-05 02:36 
----------------------------------------------------------------------
I have the same problem on Mandriva 10.2 - was lazy to report it.

I believe the problem existed in Mandriva 10.1 too.

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
10-20-05 02:36 sst4           Note Added: 0006497                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
