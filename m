From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000283]: modprobe: Can't locate module snd-via82xx
Date: Tue,  7 Sep 2004 16:47:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040907144758.CF4BBE01F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1A7D824D
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 16:47:59 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000283
======================================================================
Reported By:                alihamed
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     283
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               RedHat
Kernel Version:             2.4.18-3
Resolution:                 fixed
======================================================================
Date Submitted:             05-19-2004 20:04 CEST
Last Modified:              09-07-2004 16:47 CEST
======================================================================
Summary:                    modprobe: Can't locate module snd-via82xx
Description: 
Hi;
Firstly Thanks for your services.
and i hope u support me in this problem.
I'm using RedHat 7.3 and My Card is VIA8233 as in Hardware Browser. I
followed steps in 

http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=VIA&card=&chip=via8233a&module=via82xx


but stop in this step:-
"modprobe snd-via82xx;modprobe snd-pcm-oss;modprobe snd-mixer-oss;modprobe
snd-seq-oss" 
because this error issue :-
 "modprobe: Can't locate module snd-via82xx
  modprobe: Can't locate module snd-pcm-oss
  modprobe: Can't locate module snd-mixer-oss
  modprobe: Can't locate module snd-seq-oss" 
Although My Path is ../alsa-utlis-1.0.4. addition I attempted replace xx
by 33 by no way.

Best Regards
Ali Hamed
======================================================================

----------------------------------------------------------------------
 perex - 09-07-2004 16:47 CEST 
----------------------------------------------------------------------
Sorry, here is not a place to answer basic installation questions. Use some
ALSA forum or alsa-user mailing list. Thanks.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-19-04 20:04 alihamed       New Bug                                      
05-19-04 20:04 alihamed       Distribution              => RedHat          
05-19-04 20:04 alihamed       Kernel Version            => 2.4.18-3        
09-07-04 16:47 perex          Bugnote Added: 0001717                       
09-07-04 16:47 perex          Resolution               open => fixed       
09-07-04 16:47 perex          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
