From: bugtrack@alsa-project.org
Subject: [ALSA - WWW server 0000431]: Wrong driver & docs link for Terratec EWS88D
Date: Mon, 27 Dec 2004 15:52:35 +0100
Message-ID: <77232aad4134c893a1657891ad764c26@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B609322B
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2004 15:52:35 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=431> 
======================================================================
Reported By:                ajw213
Assigned To:                tiwai
======================================================================
Project:                    ALSA - WWW server
Issue ID:                   431
Category:                   bad link
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-08-2004 14:14 CEST
Last Modified:              12-27-2004 15:52 CET
======================================================================
Summary:                    Wrong driver & docs link for Terratec EWS88D
Description: 
www.alsa-project.org/alsa-doc/

'Details' link for Terratec EWS88D goes to page for
chip=CS4624
module=cs46xx

but card chipset is actually same as ESW88MT, ie.
chip=Envy24
module=ice1712

This may mean the 'Notes' section is also wrong - although I can only get
[To] from the card, as the page says.
The chipset should be capable of [Rio][Tio][Aio] but I don't think the
driver can handle all of these for the EWS88D yet.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-26-04 15:40 
----------------------------------------------------------------------
Fixed now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-08-04 14:14 ajw213         New Issue                                    
10-20-04 11:16 perex          Note Added: 0002211                          
10-20-04 11:20 perex          Note Added: 0002212                          
10-20-04 11:22 perex          Note Deleted: 0002211                        
10-20-04 11:22 perex          Note Deleted: 0002212                        
11-26-04 15:40 tiwai          Status                   new => resolved     
11-26-04 15:40 tiwai          Resolution               open => fixed       
11-26-04 15:40 tiwai          Assigned To               => tiwai           
11-26-04 15:40 tiwai          Note Added: 0002608                          
12-27-04 15:52 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
