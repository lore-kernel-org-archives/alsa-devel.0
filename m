From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000317]: Use a real SSL certificate issuer
Date: Wed, 29 Sep 2004 14:28:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040929122834.CFB145003@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 300E42D9
	for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2004 14:28:35 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000317
======================================================================
Reported By:                sehh
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     317
Category:                   OTHERS
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
======================================================================
Date Submitted:             05-31-2004 02:57 CEST
Last Modified:              09-29-2004 14:28 CEST
======================================================================
Summary:                    Use a real SSL certificate issuer
Description: 
I noticed that you use your own issued SSL certificate. Its
wise to avoid the commercialised and blood-drinking root
certificates which charge a fortune for a certification.

There is one solution thought, there is a non-profit
certificate authority which issues certificates free
of charge. We've used them for many of our web sites
with great success.

The url is:

http://www.cacert.org/


======================================================================

----------------------------------------------------------------------
 perex - 05-31-2004 11:53 CEST 
----------------------------------------------------------------------
Thanks for this good tip. I registered there. It looks promising. I will
try to generate a certificate request for signing when I find a little of
spare time.

And yes, I hate commercial certificates.

----------------------------------------------------------------------
 sehh - 05-31-2004 14:55 CEST 
----------------------------------------------------------------------
Superb!

----------------------------------------------------------------------
 perex - 09-29-2004 14:28 CEST 
----------------------------------------------------------------------
Once again, thanks. I've changed the certificate now. It works great.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-31-04 02:57 sehh           New Bug                                      
05-31-04 11:50 perex          Assigned To               => perex           
05-31-04 11:50 perex          Status                   new => assigned     
05-31-04 11:53 perex          Bugnote Added: 0001282                       
05-31-04 14:55 sehh           Bugnote Added: 0001283                       
09-29-04 14:28 perex          Bugnote Added: 0001971                       
09-29-04 14:28 perex          Resolution               open => fixed       
09-29-04 14:28 perex          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
