From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000714]: On newer xboxes, the xbox=1 workaround does not solve the problem.
Date: Tue, 11 Jan 2005 16:54:05 +0100
Message-ID: <f500e52f4c8eeae179aec5acfd667a25@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B7778290
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2005 16:54:05 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=714> 
======================================================================
Reported By:                davidmpye
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   714
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.4.28
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-08-2004 01:35 CET
Last Modified:              01-11-2005 16:54 CET
======================================================================
Summary:                    On newer xboxes, the xbox=1 workaround does not
solve the problem.
Description: 
This is a followup to bug 221, and the workaround that was added to ALSA
1.0.7.

Unfortunately, on newer xboxes, the chip reports less info than before,
making another change necessary - this change is backwards compatible, and
doesn't break earlier xboxes, of course. 

Please see attached patch.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000221 ac97 detect fails on xbox/i8x0
======================================================================

----------------------------------------------------------------------
 davidmpye - 12-08-04 13:51 
----------------------------------------------------------------------
Whoops, found a bug in this already!

That line should read:

if ((ac97->scaps&AC97_SCAP_DETECT_BY_VENDOR)==0 && (ac97->id == 0x00000000
|| ac97->id == 0xffffffff)) {

As it is a one-liner, are you happy for me just to paste this line above,
or would you like me to regen the patch?

Thanks,

David.

Again,

Signed-off-by: David Pye <dmp@davidmpye.dyndns.org>

----------------------------------------------------------------------
 tiwai - 12-08-04 20:15 
----------------------------------------------------------------------
Thanks, applied to CVS now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-08-04 01:35 davidmpye      New Issue                                    
12-08-04 01:35 davidmpye      Distribution              => Debian          
12-08-04 01:35 davidmpye      Kernel Version            => 2.4.28          
12-08-04 01:52 davidmpye      Note Added: 0002772                          
12-08-04 12:17 tiwai          Note Added: 0002780                          
12-08-04 12:21 tiwai          Relationship added       related to 0000221  
12-08-04 13:47 davidmpye      Note Added: 0002783                          
12-08-04 13:51 davidmpye      Note Added: 0002784                          
12-08-04 20:15 tiwai          Status                   new => resolved     
12-08-04 20:15 tiwai          Resolution               open => fixed       
12-08-04 20:15 tiwai          Assigned To               => tiwai           
12-08-04 20:15 tiwai          Note Added: 0002794                          
12-08-04 20:15 tiwai          Assigned To              tiwai =>            
01-11-05 16:54 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
