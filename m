From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000397]: Bad sound quality on Asus K8V SE Deluxe (VIA8237 + AD1980)
Date: Tue, 12 Oct 2004 14:56:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041012125632.6967118009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D1A912D9
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2004 14:56:32 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000397
======================================================================
Reported By:                durval
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     397
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               My own, based on Redhat 6.2
Kernel Version:             2.4.26
======================================================================
Date Submitted:             07-18-2004 16:41 CEST
Last Modified:              10-12-2004 14:56 CEST
======================================================================
Summary:                    Bad sound quality on Asus K8V SE Deluxe (VIA8237 + AD1980)
Description: 
Sound quality is noticiably bad; even someone with not-so-sensitive ears as
me perceives the low-frequency and high-frequency components of sound
getting mixed up and losing definition. I thought it could be a problem
with my hardware or speaker system, but rebooting the machine under
Windows2000 and playing the same music showed much better quality. 
======================================================================

----------------------------------------------------------------------
 durval - 07-18-2004 16:43 CEST 
----------------------------------------------------------------------
My email in case you need to contact me: jm81 <AT> tmp.com.br

----------------------------------------------------------------------
 durval - 07-18-2004 17:16 CEST 
----------------------------------------------------------------------
Update: I also tried to load snd-via82xx with the parameter "dxs_support"
equal to 1, 2 and 4, and got the same behavior as above in all three
attempts.

----------------------------------------------------------------------
 tiwai - 07-30-2004 17:32 CEST 
----------------------------------------------------------------------
Hmm, usually this kind of problem is solved either by specifying
a proper dxs_support option (1 or 4), or by tuning ACPI.

----------------------------------------------------------------------
 fangel - 09-25-2004 08:54 CEST 
----------------------------------------------------------------------
I have the same problem :'( My sound skips and sometimes artsd just stops
and I have to kill artsd and player to restart sound... when starting
artsd I get the following error

ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe

(I don't know how to fiddle with the module params, but I somebody explain
how I will glady try)

Morten Fangel
  morten_fangel@tdcadsl.dk

----------------------------------------------------------------------
 fangel - 09-25-2004 08:55 CEST 
----------------------------------------------------------------------
(ups, forgot to add that I'm using 2.6.8 kernel...)

----------------------------------------------------------------------
 tiwai - 10-12-2004 14:56 CEST 
----------------------------------------------------------------------
The broken pipe at start is often an IRQ problem.
In the case of chip on mobo, it's likely an IRQ routing by the broken
ACPI support.  Try to turn off ACPI via boot option (e.g. acpi=off
or pci=noacpi).

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-18-04 16:41 durval         New Bug                                      
07-18-04 16:41 durval         Distribution              => My own, based on Redhat 6.2
07-18-04 16:41 durval         Kernel Version            => 2.4.26          
07-18-04 16:43 durval         Bugnote Added: 0001457                       
07-18-04 17:16 durval         Bugnote Added: 0001458                       
07-18-04 17:17 durval         Bug Monitored: durval                        
07-30-04 17:32 tiwai          Bugnote Added: 0001502                       
09-25-04 08:54 fangel         Bugnote Added: 0001908                       
09-25-04 08:55 fangel         Bugnote Added: 0001909                       
10-12-04 14:56 tiwai          Bugnote Added: 0002101                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
