From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000768]: HDSP speed/rate switching
Date: Fri, 31 Dec 2004 18:40:53 +0100
Message-ID: <699d8e392ff0ce55954b0abfdf8af847@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EBF6931B
	for <alsa-devel@alsa-project.org>; Fri, 31 Dec 2004 18:40:53 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=768> 
======================================================================
Reported By:                kme
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - tools
Issue ID:                   768
Category:                   hdsp progs
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             12-31-2004 18:40 CET
Last Modified:              12-31-2004 18:40 CET
======================================================================
Summary:                    HDSP speed/rate switching
Description: 
HDSP Muliface PCI:

HDSPconf/ALSA sampling rates do not switch between single and double speed
rates when file with new rate is played or when JACK requests new rate. 
Rate switches work as desired within each range (single: 32K-48k,
double:64k-96k)  Discussed on LAU here:

http://eca.cx/lau/2004/12/0947.html
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-31-04 18:40 kme            New Issue                                    
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
