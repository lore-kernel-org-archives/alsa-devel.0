From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000724]: No apparent support for Creative Sounblaster 24 bit.
Date: Wed, 26 Jan 2005 13:18:03 +0100
Message-ID: <0b6fc45d411caa84aa6c89f65c41ec5b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 995BD209
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2005 13:18:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=724> 
======================================================================
Reported By:                sjberryman
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   724
Category:                   OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Fedora Core1, Core2 and Suse 9.2
Kernel Version:             2.6.9 2.4.28 2.6.8
======================================================================
Date Submitted:             12-13-2004 09:21 CET
Last Modified:              01-26-2005 13:18 CET
======================================================================
Summary:                    No apparent support for Creative Sounblaster 24 bit.
Description: 
No apparent support for Creative Sounblaster 24 bit.

Fedora does not find any sound device.

Susi finds a device but can't activate it.
======================================================================

----------------------------------------------------------------------
 Kane32 - 01-25-05 22:39 
----------------------------------------------------------------------
Aparently only 48.000Hz output works properly with this card (with 44.000Hz
the sound is stuttering), is this going to be fixed soon?
It would also be nice to use all speakers from my 7.1-soundsystem, will
this be implemented?

----------------------------------------------------------------------
 nadavkav - 01-26-05 13:18 
----------------------------------------------------------------------
i was emailing with james (who wrote the driver); and he wrote to me that
the mic/line-in and midi is not going to be implemented soon because the
info he got from creative is not enough to figure it all out.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-13-04 09:21 sjberryman     New Issue                                    
12-13-04 09:21 sjberryman     Distribution              => Fedora Core1, Core2
and Suse 9.2
12-13-04 09:21 sjberryman     Kernel Version            => 2.6.9 2.4.28 2.6.8
12-13-04 09:26 sjberryman     Issue Monitored: sjberryman                    
12-13-04 10:07 pzad           Note Added: 0002821                          
12-16-04 18:28 tiwai          Status                   new => resolved     
12-16-04 18:28 tiwai          Resolution               open => not an issue
12-16-04 18:28 tiwai          Assigned To               => tiwai           
12-16-04 18:28 tiwai          Assigned To              tiwai =>            
01-19-05 09:08 sjberryman     Status                   resolved => feedback
01-19-05 09:08 sjberryman     Resolution               not an issue => reopened
01-19-05 09:08 sjberryman     Note Added: 0003263                          
01-19-05 14:27 tiwai          Note Added: 0003266                          
01-22-05 22:15 nadavkav       Note Added: 0003379                          
01-22-05 23:20 fmoraes        Note Added: 0003381                          
01-25-05 22:39 Kane32         Note Added: 0003411                          
01-26-05 13:18 nadavkav       Note Added: 0003416                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
