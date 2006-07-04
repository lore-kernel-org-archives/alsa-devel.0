From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001244]: error with firmware with echo
	layla20
Date: Tue, 4 Jul 2006 22:02:58 +0200
Message-ID: <49dae7b387b306026db491cd3209ea07@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B04A3239
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Jul 2006 22:02:58 +0200 (MEST)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1244> 
======================================================================
Reported By:                hennewou
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1244
Category:                   PCI - echoaudio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.11
======================================================================
Date Submitted:             07-09-2005 02:22 CEST
Last Modified:              07-04-2006 22:02 CEST
======================================================================
Summary:                    error with firmware with echo layla20
Description: 
I get this error when loading snd-layla20 card:

ACPI: PCI interrupt 0000:02:0d.0[A] -> GSI 21 (level, low) -> IRQ 177
ALSA /usr/src/modules/alsa-driver/pci/echoaudio/echoaudio.c:41:
get_firmware(): Firmware not available (-2)
Echoaudio Layla20: probe of 0000:02:0d.0 failed with error -2

I compiled an alsa driver for layla20 (I had to patch the alsa-driver tree
a year ago for linux-2.4.25, and that worked (and still does).


(By the way, For some reason I can only compile snd-layla20 according to
debian package manager (apt-get install alsa-source ....) . With the
original alsa-driver-1.0.9a.tar.bz2, the echoaudio modules refuse to
compile.)
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001310 Driver cant find firmware for Layla24
======================================================================

----------------------------------------------------------------------
 rlrevell - 08-10-05 01:08 
----------------------------------------------------------------------
Submitter: do the fix(es) described in #1310 help you?

----------------------------------------------------------------------
 Adrian Bunk - 07-04-06 22:02 
----------------------------------------------------------------------
Please reopen this bug if there's still some problem present not already
handled in #1310.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-09-05 02:22 hennewou       New Issue                                    
07-09-05 02:22 hennewou       Distribution              => Debian          
07-09-05 02:22 hennewou       Kernel Version            => 2.6.11          
08-05-05 05:36 oxi            Issue Monitored: oxi                         
08-05-05 08:48 perex          Relationship added       related to 0001310  
08-05-05 08:49 perex          Assigned To              perex =>            
08-05-05 08:49 perex          Description Updated                          
08-05-05 08:50 perex          Status                   assigned => new     
08-10-05 01:08 rlrevell       Note Added: 0005744                          
08-16-05 05:17 oxi            Issue End Monitor: oxi                       
07-04-06 22:02 Adrian Bunk    Note Added: 0010829                          
07-04-06 22:02 Adrian Bunk    Resolution               open => duplicate   
07-04-06 22:02 Adrian Bunk    Category                 0_compilation problem_!!!
=> PCI - echoaudio
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
