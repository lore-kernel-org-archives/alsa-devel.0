From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001068]: enable dmix by default
Date: Tue, 24 May 2005 09:29:55 +0200
Message-ID: <64e5eb312181e4f9a8c7c0302c7fffa6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A93991D7
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2005 09:29:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1068> 
======================================================================
Reported By:                mandreiana
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1068
Category:                   mixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-21-2005 06:49 CEST
Last Modified:              05-24-2005 09:29 CEST
======================================================================
Summary:                    enable dmix by default
Description: 
Please see this bug report:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=155421

Someone suggested to change /etc/asound.conf so dmix is turned on, but
please enable it by default.
======================================================================

----------------------------------------------------------------------
 mandreiana - 04-29-05 09:08 
----------------------------------------------------------------------
I've upgraded to 1.0.9.rc2, please close this

----------------------------------------------------------------------
 Martin Pitt - 05-24-05 09:29 
----------------------------------------------------------------------
Please do not close it right now. I'm using 1.0.9rc3, dmix really is
enabled by default, but only for the first card. All subsequent cards do
not use dmix. Is this on purpose? If not, will it be fixed in 1.0.9 final?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-21-05 06:49 mandreiana     New Issue                                    
04-21-05 07:59 pzad           Note Added: 0004546                          
04-21-05 08:39 mandreiana     Note Added: 0004547                          
04-21-05 08:42 mandreiana     Note Added: 0004548                          
04-29-05 09:08 mandreiana     Note Added: 0004578                          
05-24-05 09:29 Martin Pitt    Note Added: 0004707                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
