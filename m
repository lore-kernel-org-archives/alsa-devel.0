From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0001677]: envy24control word clock lock indication is wrong way around
Date: Mon, 2 Jan 2006 22:38:48 +0100
Message-ID: <8affeca7ae0a451c110eaaa25f6d68eb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 32E8F158
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2006 22:38:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1677> 
======================================================================
Reported By:                johnrigg
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - tools
Issue ID:                   1677
Category:                   envy24control
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-24-2005 18:03 CET
Last Modified:              01-02-2006 22:38 CET
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
 johnrigg - 01-02-06 21:55 
----------------------------------------------------------------------
Now fixed in CVS. Thanks.

----------------------------------------------------------------------
 rlrevell - 01-02-06 22:38 
----------------------------------------------------------------------
Fixed in upcoming 1.0.11 release

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-24-05 18:03 johnrigg       New Issue                                    
12-26-05 13:12 johnrigg       Note Added: 0007150                          
01-02-06 21:55 johnrigg       Note Added: 0007392                          
01-02-06 22:38 rlrevell       Status                   new => resolved     
01-02-06 22:38 rlrevell       Resolution               open => fixed       
01-02-06 22:38 rlrevell       Assigned To               => rlrevell        
01-02-06 22:38 rlrevell       Note Added: 0007393                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
