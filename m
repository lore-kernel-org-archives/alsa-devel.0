From: noreply@alsa-project.org
Subject: [ALSA - lib 0000129]: Request to make front, rear and surround40 more flexible.
Date: Fri, 16 Jul 2004 14:37:59 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123759.7EFAC2C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C4C8F244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:37:59 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000129
======================================================================
Reported By:                jcdutton
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Bug ID:                     129
Category:                   ordinary pcm
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             03-12-2004 02:41 CET
Last Modified:              07-16-2004 14:37 CEST
======================================================================
Summary:                    Request to make front, rear and surround40 more flexible.
Description: 
test1.wav is a mono audio file.
aplay -Ddefault test1.wav
This produces sound on multiple speakers.
aplay -Dfront test1.wav
This produces no sound, but if test1.wav was a stereo file it would play.
aplay -Dsurround40 test1.wav
This produces no sound.

It would be nice if one selects a device that has 2 channels like "front",
and then one sets 1 channel in hw_params, alsa-lib should automatically
adjust the 1 channel to fill both output channels to the speakers.
The same with "surround40". If one sets 1 channel in hw_params, alsa-lib
should automatically adjust the 1 channel to fill all output channels.

Same problem happens with device "plug:front"
======================================================================

----------------------------------------------------------------------
 perex - 03-13-2004 18:36 CET 
----------------------------------------------------------------------
Please, could you remind me your hardware?

Note that the 'plug:front' combination should work also for mono streams.
I think that it's bug for your hardware configuration.

----------------------------------------------------------------------
 jcdutton - 03-13-2004 19:34 CET 
----------------------------------------------------------------------
I have a SB Audigy 2 and an ICH5 Intel8x0.

The SB Audigy 2 fails.

The ICH5 works. (for front only, but I think getting rear to work is a
different bug)

Output from lspci -n |grep 0401
0000:00:1f.5 Class 0401: 8086:24d5 (rev 02)
0000:03:06.0 Class 0401: 1102:0004 (rev 04)

----------------------------------------------------------------------
 perex - 03-14-2004 11:36 CET 
----------------------------------------------------------------------
Please, try the attached patch against alsa-lib - audigy.conf.patch.

----------------------------------------------------------------------
 perex - 03-20-2004 16:01 CET 
----------------------------------------------------------------------
Bug is fixed in CVS.

----------------------------------------------------------------------
 jcdutton - 03-20-2004 16:34 CET 
----------------------------------------------------------------------
Fix tested here, and works. Thankyou.

----------------------------------------------------------------------
 perex - 03-23-2004 15:18 CET 
----------------------------------------------------------------------
Confirmed.

----------------------------------------------------------------------
 perex - 03-23-2004 15:19 CET 
----------------------------------------------------------------------
Confirmed.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-12-04 02:41 jcdutton       New Bug                                      
03-13-04 18:34 perex          Assigned To               => perex           
03-13-04 18:34 perex          Status                   new => assigned     
03-13-04 18:36 perex          Bugnote Added: 0000598                       
03-13-04 19:34 jcdutton       Bugnote Added: 0000599                       
03-14-04 11:34 perex          File Added: audigy.conf.patch                    
03-14-04 11:36 perex          Bugnote Added: 0000600                       
03-20-04 16:01 perex          Bugnote Added: 0000648                       
03-20-04 16:01 perex          Resolution               open => fixed       
03-20-04 16:01 perex          Status                   assigned => resolved
03-20-04 16:34 jcdutton       Resolution               fixed => reopened   
03-20-04 16:34 jcdutton       Status                   resolved => feedback
03-20-04 16:34 jcdutton       Bugnote Added: 0000649                       
03-23-04 15:18 perex          Bugnote Added: 0000657                       
03-23-04 15:19 perex          Bugnote Added: 0000658                       
03-23-04 15:19 perex          Resolution               reopened => fixed   
03-23-04 15:19 perex          Status                   feedback => resolved
07-16-04 14:37 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
