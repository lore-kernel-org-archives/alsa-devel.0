From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001909]: Labelling of controls for SB
	Extigy is confusing
Date: Wed, 2 Aug 2006 02:40:50 +0200
Message-ID: <c8de9dcc786f330801e9f72bcdda0efc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 87C7C167
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Aug 2006 02:40:50 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1909> 
======================================================================
Reported By:                andersin
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1909
Category:                   alsamixer
Reproducibility:            always
Severity:                   text
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-11-2006 16:33 CET
Last Modified:              08-02-2006 02:40 CEST
======================================================================
Summary:                    Labelling of controls for SB Extigy is confusing
Description: 
The controls for the SB Extigy are all labelled as Master. The names should
reflect the channel(s) that they control. Amixer shows this information
(albeit its mapping of controls to actual channels is off).
Additionally a Master 1 control exists that changes the volume of all
channels.
======================================================================

----------------------------------------------------------------------
 Raymond - 08-02-06 02:40 
----------------------------------------------------------------------
Would you post the content of test.state after 'alsactl store -f
test.state'  and output of 'amixer' ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-06 16:33 andersin       New Issue                                    
08-02-06 02:40 Raymond        Note Added: 0011384                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
