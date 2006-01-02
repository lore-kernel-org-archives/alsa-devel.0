From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0001677]: envy24control word clock lock indication is wrong way around
Date: Mon, 2 Jan 2006 21:55:12 +0100
Message-ID: <17bea621ff378b211bfb3b164b33efbd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 60E87161
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2006 21:55:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1677> 
======================================================================
Reported By:                johnrigg
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   1677
Category:                   envy24control
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             12-24-2005 18:03 CET
Last Modified:              01-02-2006 21:55 CET
======================================================================
Summary:                    envy24control word clock lock indication is wrong
way around
Description: 
The word clock `Locked' indication in envy24control's hardware settings is
backwards. It says `Locked' when there's no signal and `No signal' when
it's
locked.
I'm hoping I'll get a large pot of glue for Christmas so I can stick back
all the hair I've torn out over the last couple of weeks over this :-)

Merry Christmas

John
======================================================================

----------------------------------------------------------------------
 johnrigg - 12-26-05 13:12 
----------------------------------------------------------------------
The above behaviour happens when syncing clocks via the BNC word clock
in/out connectors. When syncing via S/PDIF the indicator just says
`Locked' whether it's locked or not. The only way to tell is if it's
locked jackd will run, if unlocked it won't.

----------------------------------------------------------------------
 johnrigg - 01-02-06 21:55 
----------------------------------------------------------------------
Now fixed in CVS. Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-24-05 18:03 johnrigg       New Issue                                    
12-26-05 13:12 johnrigg       Note Added: 0007150                          
01-02-06 21:55 johnrigg       Note Added: 0007392                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
