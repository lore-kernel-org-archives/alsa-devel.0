From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000506]: Hercules Fortissimo II (Gamesurround 5.1 digital edition) has no sound on headphone output
Date: Fri,  8 Oct 2004 12:15:14 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041008101514.3490249052@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 80449215
	for <alsa-devel@alsa-project.org>; Fri,  8 Oct 2004 12:15:14 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000506
======================================================================
Reported By:                bekker
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     506
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             kernel 2.6.8-gentoo-r3.
======================================================================
Date Submitted:             09-19-2004 13:40 CEST
Last Modified:              10-08-2004 12:15 CEST
======================================================================
Summary:                    Hercules Fortissimo II (Gamesurround 5.1 digital edition) has no sound on headphone output
Description: 
the Fortissimo II card has seperate outputs for front, rear speakers and
headphone. I cannot get sound on the headphone. 

Front (HW:0,0) and rear speakers (HW:0,1) work.IEC958 (HW:0,2) is also
available but I have not tested it.

The slider marked as headphone in the mixer actually controls the rear
speaker volume. 


======================================================================

----------------------------------------------------------------------
 bekker - 09-19-2004 13:41 CEST 
----------------------------------------------------------------------
I had the same issue on Mandrake 9.2, Mandrake 10.

----------------------------------------------------------------------
 tiwai - 09-20-2004 17:39 CEST 
----------------------------------------------------------------------
So far, only 4.0 output is supported on cs46xx driver.

----------------------------------------------------------------------
 bekker - 09-21-2004 20:01 CEST 
----------------------------------------------------------------------
Fair enough. Is 5.1 support planned?

----------------------------------------------------------------------
 tiwai - 09-23-2004 18:34 CEST 
----------------------------------------------------------------------
Sorry, no plan AFAIK.
Benny might help for further development of 5.1 support (see
cs46xx source codes for his address).

----------------------------------------------------------------------
 tiwai - 10-06-2004 11:33 CEST 
----------------------------------------------------------------------
Well, I misinformed -- 5.1 output is supported on CS46xx when
dual codecs are detected.  But, in your case, the board seems to
have only one codec.

Could you show the files in /proc/asound/card0/codec*/* files?

----------------------------------------------------------------------
 bekker - 10-07-2004 22:25 CEST 
----------------------------------------------------------------------
I only have /proc/asound/card0/codec97#0/

ls -l /proc/asound/card0/codec97#0/:

-r--r--r--  1 root root 0 Oct  7 22:25 ac97#0-0
-r--r--r--  1 root root 0 Oct  7 22:25 ac97#0-0+regs

Hope this helps

----------------------------------------------------------------------
 tiwai - 10-08-2004 12:15 CEST 
----------------------------------------------------------------------
Oh I meant the contents of the files :)  Please attach them.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-19-04 13:40 bekker         New Bug                                      
09-19-04 13:40 bekker         Distribution              => Gentoo Linux    
09-19-04 13:40 bekker         Kernel Version            => kernel 2.6.8-gentoo-r3.
09-19-04 13:41 bekker         Bugnote Added: 0001784                       
09-20-04 17:39 tiwai          Bugnote Added: 0001789                       
09-21-04 20:01 bekker         Bugnote Added: 0001808                       
09-23-04 18:34 tiwai          Bugnote Added: 0001830                       
10-06-04 11:33 tiwai          Bugnote Added: 0002019                       
10-07-04 22:25 bekker         Bugnote Added: 0002040                       
10-08-04 12:15 tiwai          Bugnote Added: 0002046                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
