From: noreply@alsa-project.org
Subject: [ALSA - driver 0000133]: Sounds struggles.
Date: Fri, 16 Jul 2004 12:44:40 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104440.4A33126008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A38F4255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:44:40 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000133
======================================================================
Reported By:                IsoTeemu
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     133
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               SuSE Pro 9.0
Kernel Version:             2.6.4
======================================================================
Date Submitted:             03-14-2004 21:43 CET
Last Modified:              07-16-2004 12:44 CEST
======================================================================
Summary:                    Sounds struggles.
Description: 
When listening sounds, eq. Music, or Playing games. Sounds work. After
while they stop. And then they returns. While again and they stop. while
again and they return. then they stop again and starts and stops and... 
No-sounds time grows every stop time.
First I thought it is applications fault, but chose every tested
application suffers from same problem, I thought it might be linux
scheduler fault. But I have now tried multiple linux 2.6 kernels, whit
different configurations and different schedulers. But with no success.


======================================================================

----------------------------------------------------------------------
 perex - 03-15-2004 12:25 CET 
----------------------------------------------------------------------
The 'aplay <some-wav-file>' command works?

Is something related to sound in /var/log/messages?

----------------------------------------------------------------------
 IsoTeemu - 03-15-2004 17:33 CET 
----------------------------------------------------------------------
When playing wav with aplay, same problem occurs. Thou aplay seems to crash
with error:
aplay: pcm_write:1084: write error: Input/output error
In /var/log/messages only messages related to sound is those where alsa is
loaded.
And allthought it might be irrelevant, I had this style messages printed:
kernel: APIC error on CPU0: 60(60)
Little browsing thru acpi kernel source suggested that it might be related
to Vector-based interrupt indexing (MSI). Disabling this option helped so
that thouse error messages are not printed anymore. And why this might be
related to sound problems? When I played ut2004demo, I noticed that this
message seemed to be printed as many times than sound had disappeared.
And before you suggest to try booting with noacpi, I have allready tried
that.

----------------------------------------------------------------------
 perex - 03-15-2004 17:44 CET 
----------------------------------------------------------------------
It sounds like an interrupt problem.

Try also 'noapic' as the kernel boot option.

Unfortunately, we cannot help you much. It's something for linux kernel
mailing list.

----------------------------------------------------------------------
 IsoTeemu - 03-26-2004 22:54 CET 
----------------------------------------------------------------------
Sounds work now. And it was the darnest thing.
As nothing seemed to work, I returned to BIOS about thoushand and second
time, and checked settings again. As everything seemed to be OK, I was
giving up hope, but noticed, that "Power on by mouse" was enabled. This
feature didn't work, so I disabled it.
Well, couple days later I was bit bored and started to play NWN. After
while I noticed that sounds had played for a while whitout interruptions.
I started to wonder what has had influenced to this. And quickly it was
clear that if "power on by mouse" was enabled, sounds didn't work. And if
it was disabled, sounds worked.

But anyway, Thanks for help!

----------------------------------------------------------------------
 perex - 03-27-2004 13:49 CET 
----------------------------------------------------------------------
HW setup specific problem.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-14-04 21:43 IsoTeemu       New Bug                                      
03-14-04 21:43 IsoTeemu       Distribution              => SuSE Pro 9.0    
03-14-04 21:43 IsoTeemu       Kernel Version            => 2.6.4           
03-15-04 12:25 perex          Bugnote Added: 0000612                       
03-15-04 17:33 IsoTeemu       Bugnote Added: 0000615                       
03-15-04 17:44 perex          Bugnote Added: 0000618                       
03-26-04 22:54 IsoTeemu       Bugnote Added: 0000709                       
03-27-04 13:49 perex          Bugnote Added: 0000710                       
03-27-04 13:49 perex          Assigned To               => perex           
03-27-04 13:49 perex          Resolution               open => fixed       
03-27-04 13:49 perex          Status                   new => resolved     
07-16-04 12:44 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
