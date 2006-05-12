From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0002116]: no sound in kernel 2.6.16-1-686
Date: Fri, 12 May 2006 20:30:12 +0200
Message-ID: <828e6f65bbdd2cc128b4c9cab49461c8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CEF51175
	for <alsa-devel@alsa-project.org>; Fri, 12 May 2006 20:30:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2116> 
======================================================================
Reported By:                mramirez
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   2116
Category:                   speakertest
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-12-2006 01:07 CEST
Last Modified:              05-12-2006 20:30 CEST
======================================================================
Summary:                    no sound in kernel 2.6.16-1-686
Description: 
I have updated my kernel from 2.6.15-1-486 to 2.6.16-1-686, and now the
sound not work. 

I run alsaconf, but not solve the problem. 

if i boot on kernel 2.6.15-1-486 the sound work. (only in this version)

somebody help me?



======================================================================

----------------------------------------------------------------------
 tiwai - 05-12-06 18:37 
----------------------------------------------------------------------
Then how about to begin with more detailed descriptions of your hardware
and problems?

----------------------------------------------------------------------
 mramirez - 05-12-06 20:30 
----------------------------------------------------------------------
Laptop model:DELL INSPIRON 6400
Procesor: Intel dual core t2200
Chipset: Intel&#174;  945GM
Sound card: HDA Intel, SigmatelStac9200 <- this information is from
alsamixer

i updated my kernel with #apt-get install linux-headers-2.6.16-1-686 and
restart my computer in this kernel version,  and the sound not work.

but, if i boot on 2.6.15 version, the sound work.

that another information you need?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-12-06 01:07 mramirez       New Issue                                    
05-12-06 16:07 tiwai          Note Added: 0009777                          
05-12-06 18:34 mramirez       Note Added: 0009785                          
05-12-06 18:37 tiwai          Note Added: 0009787                          
05-12-06 20:30 mramirez       Note Added: 0009790                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
