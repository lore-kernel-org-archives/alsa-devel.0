From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000348]: Used CVS version for audigy ls card.  Volume is always at full even when muted
Date: Fri, 27 Aug 2004 20:11:21 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040827181121.5F2B92C003@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9F67A18F
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2004 20:11:53 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000348
======================================================================
Reported By:                ezelkow1
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     348
Category:                   CORE - control
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.6-1.435
======================================================================
Date Submitted:             06-28-2004 06:18 CEST
Last Modified:              08-27-2004 20:11 CEST
======================================================================
Summary:                    Used CVS version for audigy ls card.  Volume is always at full even when muted
Description: 
I have an audigy ls card.  I had no sound when i first installed fedora
core 2.  I went applied the patch found at
:http://www.superbug.demon.co.uk/alsa/  to the 1.0.5a drivers before
installing the cvs version.  This gave me sound but no control.  Today i
have updated the cvs version and I still have the same problem.  My volume
is constantly maxed out, even with all channels muted in alsamixer.  I
have no other mixer apps running and the volume problem happens in every
app i use.
======================================================================

----------------------------------------------------------------------
 jcdutton - 06-28-2004 13:06 CEST 
----------------------------------------------------------------------
This driver is still in development. As I find out how things work, I am
adding to it. If you download audigyls.c and AudigyLS.conf again from
http://www.superbug.demon.co.uk/alsa/ you will find they have changed.
The version that has Analog volume controls is "Version: 0.3". See line 4
of audigyls.c to check version number.
I am generally uploading new versions of audigyls.c about twice a day.

The only PLAYBACK controls that currently do anything are: -
Analog Front
Analog Rear
Analog Center/LFE
SPDIF Front
SPDIF Rear
SPDIF Center/LFE

For CAPTURE from Mic in or Line in. (The AudigyLS uses the AC97 playback
channel for capture. The AC97 capture channel is not used at all.)
Master
Mic  (The one marked as playback)
Mic boost
Line (The one marked as playback)
Digital/Analog ( switch must be in Analog mode for CAPTURE. )
CAPTURE feedback into PLAYBACK.

----------------------------------------------------------------------
 jcdutton - 08-27-2004 20:11 CEST 
----------------------------------------------------------------------
Can you please verify which version of the audigyls.c file you have, by
doing:
grep Version ./alsa-driver/pci/emu10k1/audigyls.c

It should say:
 * Version: 0.0.14

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-28-04 06:18 ezelkow1       New Bug                                      
06-28-04 06:18 ezelkow1       Kernel Version            => 2.6.6-1.435     
06-28-04 13:06 jcdutton       Bugnote Added: 0001345                       
08-27-04 20:11 jcdutton       Bugnote Added: 0001650                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
