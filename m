From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0001141]: Word clock output from Delta 1010LT stops when envy24control starts
Date: Sun, 29 May 2005 07:34:17 +0200
Message-ID: <2879a74e3586e5ed4fe153ae15339b69@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9E7701C3
	for <alsa-devel@alsa-project.org>; Sun, 29 May 2005 07:34:17 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1141> 
======================================================================
Reported By:                rsutphin
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   1141
Category:                   envy24control
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-29-2005 07:34 CEST
Last Modified:              05-29-2005 07:34 CEST
======================================================================
Summary:                    Word clock output from Delta 1010LT stops when
envy24control starts
Description: 
Hello,

I have the following:
1. Planet CCRMA on Fedora Core 3
2. 2.6-10-2.1.11.rhfc3.ccrma kernel with low latency patches
3. alsa-tools 1.0.8-1.rhfc3.ccrma
4. M-Audio Delta 1010LT soundcar
5. jack audio connection kit 0.99.36-0.1.
6. Behringer DDX-3216 digital mixer

The word clock out from the 1010LT is connected to the word clock in on
the DDX-3216. The DDX-3216 is set to sync to word clock in. S/PDIF is
connected between the 1010LT and the DDX-3216.

Word clock sync between the 1010LT and the DDX-3216 works properly until
envy24control is started. When envy24control is started, the DDX-3216
displays a message stating that no word clock signal is present. Changing
master clock settings on Hardware Settings tab of envy24control has no
effect. 

I have been unable to get word clock output from the 1010LT to re-start
without restarting the computer


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-29-05 07:34 rsutphin       New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
