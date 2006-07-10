From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001950]: got error related to kde in
	console
Date: Mon, 10 Jul 2006 18:08:07 +0200
Message-ID: <e28b0879114a954f7d647a189fe53d7b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4CF1F244
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 18:08:07 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1950> 
======================================================================
Reported By:                zebul666
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1950
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               slackware
Kernel Version:             2.6.15.6
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-21-2006 17:05 CET
Last Modified:              07-10-2006 18:08 CEST
======================================================================
Summary:                    got error related to kde in console
Description: 
when i run something like (kde not running)
mpg321 somefile.mp3 
or ogg123 somefile.ogg

i got 
create link /home/stef/.kde/socket-titan
can't create mcop directory 

and no sound. 
titan is my hostname
why this kde stuff while i use a console application ?!!!!!

if kde is running there is no error and there is some sound. 

it seems it happens with alsa 1.0.11rc3 but not with alsa 1.0.10 with a
kernel 2.6.15.6 


======================================================================

----------------------------------------------------------------------
 zebul666 - 05-04-06 17:23 
----------------------------------------------------------------------
well, i have finally decided to read the doc of libao (that i found in the
source of libao 0.8.6 but it seems to be the doc for libao 0.8.5 ??) 

and libao have a ranking system to try to detect which driver to use 
Priority   Drivers
30  alsa, alsa09
20  oss, irix, sun
10  esd,arts
0  null, all file output

but although alsa has big priority it did not find alsa and decided to use
arts ??? or what else need /tmp/ksocket-stef ? 

so i made a /etc/libao.conf with 
default_driver=alsa09

which i should not have to do (because it is the first driver tested isn't
it ? )
and it works i do not have the error again. 
i fillled a bug report at libao dev.

----------------------------------------------------------------------
 zebul666 - 05-05-06 11:12 
----------------------------------------------------------------------
i recompiled and reinstalled libao after alsa-lib and now i do not need
anymore /etc/libao.conf to get things to work

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-21-06 17:05 zebul666       New Issue                                    
03-21-06 17:05 zebul666       Distribution              => slackware       
03-21-06 17:05 zebul666       Kernel Version            => 2.6.15.6        
03-21-06 17:10 tiwai          Note Added: 0008744                          
03-21-06 19:34 zebul666       Note Added: 0008757                          
03-21-06 19:40 tiwai          Note Added: 0008758                          
05-04-06 17:23 zebul666       Note Added: 0009617                          
05-05-06 11:12 zebul666       Note Added: 0009624                          
07-10-06 18:08 Adrian Bunk    Status                   new => closed       
07-10-06 18:08 Adrian Bunk    Resolution               open => not an issue
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
