From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001102]: alsaconf man page installed as "alsaconf" rather than as "alsaconf.8"
Date: Fri, 13 May 2005 14:14:36 +0200
Message-ID: <7b300e7f1b440ca211113ea6dd8de449@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EBD602CA
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2005 14:14:36 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1102> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1102
Category:                   alsaconf
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-12-2005 18:55 CEST
Last Modified:              05-13-2005 14:14 CEST
======================================================================
Summary:                    alsaconf man page installed as "alsaconf" rather
than as "alsaconf.8"
Description: 
Running "make install" produces these commands, the first one correct, the
second one incorrectly omitting the ".8" suffix.

/usr/bin/install -c -m 644 ./alsactl.1
/home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-utils-1.0.8+1.0.9rc3/debian/alsa-utils/usr/share/man/man1/alsactl.1

/usr/bin/install -c -m 644 alsaconf.8
/home/jdthood/src/pkg-alsa/pkg-alsa/trunk/build-area/alsa-utils-1.0.8+1.0.9rc3/debian/alsa-utils/usr/share/man/man8/alsaconf
======================================================================

----------------------------------------------------------------------
 tiwai - 05-13-05 14:14 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-12-05 18:55 jdthood        New Issue                                    
05-13-05 14:14 tiwai          Status                   new => resolved     
05-13-05 14:14 tiwai          Resolution               open => fixed       
05-13-05 14:14 tiwai          Assigned To               => tiwai           
05-13-05 14:14 tiwai          Note Added: 0004643                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
