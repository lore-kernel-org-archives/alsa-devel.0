From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002042]: Compile error : /usr/local/src/alsa/alsa-driver/include/adriver.h:219: error: conflicting types for 'gfp_t'
Date: Thu, 20 Apr 2006 08:04:43 +0200
Message-ID: <9a15a87e0c3d958ffa1296cd32bf16e5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4C8CA18A
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2006 08:04:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2042> 
======================================================================
Reported By:                mnemotronic
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2042
Category:                   CORE - control
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Centos
Kernel Version:             2.6.9-34.ELsmp
======================================================================
Date Submitted:             04-20-2006 08:04 CEST
Last Modified:              04-20-2006 08:04 CEST
======================================================================
Summary:                    Compile error :
/usr/local/src/alsa/alsa-driver/include/adriver.h:219: error: conflicting types
for 'gfp_t'
Description: 
Can't compile using directions from
http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=Creative+Labs&card=Sound+Blaster+Live+7.1.&chip=SB0410%2C+P17&module=ca0106

error:
In file included from
/usr/local/src/alsa/alsa-driver/acore/memalloc.inc:13,
                 from /usr/local/src/alsa/alsa-driver/acore/memalloc.c:1:
/usr/local/src/alsa/alsa-driver/include/adriver.h:219: error: conflicting
types for 'gfp_t'
include/linux/gfp.h:134: error: previous declaration of 'gfp_t' was here

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-20-06 08:04 mnemotronic    New Issue                                    
04-20-06 08:04 mnemotronic    Distribution              => Centos          
04-20-06 08:04 mnemotronic    Kernel Version            => 2.6.9-34.ELsmp  
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
