From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001469]: Japanese characters are broken with alsaconf
Date: Wed, 19 Oct 2005 18:13:08 +0200
Message-ID: <bda86a26ac227b4e738749488a35461e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E0AFC13D
	for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2005 18:13:08 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1469> 
======================================================================
Reported By:                speedking
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1469
Category:                   alsaconf
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-05-2005 18:01 CEST
Last Modified:              10-19-2005 18:13 CEST
======================================================================
Summary:                    Japanese characters are broken with alsaconf
Description: 
"alsaconf" displays broken characters for k/d button messages while using
Japanese.
======================================================================

----------------------------------------------------------------------
 tiwai - 10-19-05 18:11 
----------------------------------------------------------------------
The installation of wide-char ncurses lib strongly depends on the distro,
so I can't tell you here.
alsaconf uses dialog program, and this program must be linked with
libncursesw to process the wide-char properly.  If dialog is i18nized,
alsaconf should work as it is.

----------------------------------------------------------------------
 speedking - 10-19-05 18:13 
----------------------------------------------------------------------
The distro is RHEL 3 U5 x86 and x86_64.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-05-05 18:01 speedking      New Issue                                    
10-05-05 18:36 tiwai          Note Added: 0006431                          
10-19-05 17:47 speedking      Note Added: 0006493                          
10-19-05 18:11 tiwai          Note Added: 0006494                          
10-19-05 18:13 speedking      Note Added: 0006495                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
