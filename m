From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000500]: CS4236+ soundcard not found or device busy
Date: Mon,  4 Oct 2004 18:56:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041004165605.E932E4A046@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 553E125E
	for <alsa-devel@alsa-project.org>; Mon,  4 Oct 2004 18:56:06 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000500
======================================================================
Reported By:                nlmarco
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     500
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.5-7.108
Resolution:                 fixed
======================================================================
Date Submitted:             09-14-2004 02:18 CEST
Last Modified:              10-04-2004 18:56 CEST
======================================================================
Summary:                    CS4236+ soundcard not found or device busy
Description: 
After the ALSA version 1.0.3, which is distributed with SuSE 9.1, didn't
want to run at all and froze the system, I downloaded, compiled and
installed the version 1.0.6a. This doesn't freeze anymore, but doesn't
work either and produces strange log messages:

/var/log/messages:
---
Sep 14 02:06:14 sexbomb kernel: snd_page_alloc: unsupported module,
tainting kernel.
Sep 14 02:06:14 sexbomb kernel: snd: unsupported module, tainting kernel.
Sep 14 02:06:15 sexbomb kernel: snd_timer: unsupported module, tainting
kernel.
Sep 14 02:06:15 sexbomb kernel: snd_pcm: unsupported module, tainting
kernel.
Sep 14 02:06:15 sexbomb kernel: snd_cs4231_lib: unsupported module,
tainting kernel.
Sep 14 02:06:15 sexbomb kernel: snd_seq_device: unsupported module,
tainting kernel.
Sep 14 02:06:15 sexbomb kernel: snd_rawmidi: unsupported module, tainting
kernel.
Sep 14 02:06:15 sexbomb kernel: snd_mpu401_uart: unsupported module,
tainting kernel.
Sep 14 02:06:15 sexbomb kernel: snd_cs4236_lib: unsupported module,
tainting kernel.
Sep 14 02:06:15 sexbomb kernel: snd_hwdep: unsupported module, tainting
kernel.
Sep 14 02:06:15 sexbomb kernel: snd_opl3_lib: unsupported module, tainting
kernel.
Sep 14 02:06:16 sexbomb kernel: snd_cs4236: unsupported module, tainting
kernel.
Sep 14 02:06:16 sexbomb kernel: CS4236+ soundcard not found or device
busy
---

Please HELP! I've already invested days into that and googling around, I
saw that others have similar problems to get ALSA running on IBM ThinkPad
600E.

======================================================================

----------------------------------------------------------------------
 nlmarco - 09-14-2004 22:28 CEST 
----------------------------------------------------------------------
I just tried it again with 1.0.7rc1, but the problem remains the same. BTW:
I tried legacy probe (all possible IRQ/DMA combinations for CS4236,
CS4232, CS4231) with alsaconf, but it didn't find anything.

----------------------------------------------------------------------
 tiwai - 09-21-2004 11:59 CEST 
----------------------------------------------------------------------
You can ignore "unsupported module..." messages.  They are harmless,
indicating
that the modules are not provided by SUSE.

If it's TP600E, it has to be a non-isapnp chip.
I guess the IRQ 9 conflicts with ACPI.  You can change it via setpnp
program
(you'll need to compile by yourself, SUSE doesn't ship this any more).

----------------------------------------------------------------------
 nlmarco - 09-23-2004 19:16 CEST 
----------------------------------------------------------------------
I just came back from Berlin (was fighting against software patents
<http://swpat.ffii.org>) and wanted to try it out. But unfortunately, I
was not able to find where to download setpnp (neither source nor binary).
Could you please provide a link?

----------------------------------------------------------------------
 tiwai - 09-23-2004 19:19 CEST 
----------------------------------------------------------------------
Some info about TP:
  http://tpctl.sourceforge.net/

IIRC, setpnp is included in pcmcia-cs package.
You can find it in pcmcia source rpm in SUSE distro.

----------------------------------------------------------------------
 nlmarco - 09-23-2004 22:03 CEST 
----------------------------------------------------------------------
Thanks a lot for the quick reply! Unfortunately, I can't compile setpnp,
because pnp_resource.h does not exist (locate pnp_resource.h doesn't
return anything). It seems to me, setpnp is more than deprecated and the
pnp support is kicked out of the kernel?! Do I have to recompile the
kernel? If so, I probably need to get the pnp support from somewhere...but
where?

I found tpctl already before, but it doesn't provide any functionality for
changing the IRQ.

BTW: Why does it work under windows XP? Shouldn't a conflict prevent it
from working with any system?

----------------------------------------------------------------------
 tiwai - 09-24-2004 12:24 CEST 
----------------------------------------------------------------------
pnp_resource.h is in pcmcia-cs package itself.

When you once get setpnp, you can reassign this ISA resource,
so the driver will work again.

XP might use another resource, or doesn't use ACPI irq 9.

----------------------------------------------------------------------
 nlmarco - 10-02-2004 18:39 CEST 
----------------------------------------------------------------------
IT WORKS!!! After I switched QUICKBOOT OFF!

Thanks for your help anyway, but everything I tried was in vain. Then I
found a posting somewhere which told to deactivate the QuickBoot feature
of the ThinkPad and now it works. Additionally, I clicked "initialize" in
the BIOS, but I don't know whether this was really necessary. BTW: To
enter the BIOS, you need to type F1...

Best regards, Marco ;-)

----------------------------------------------------------------------
 tiwai - 10-04-2004 18:56 CEST 
----------------------------------------------------------------------
Ok, close this bug now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-14-04 02:18 nlmarco        New Bug                                      
09-14-04 02:18 nlmarco        Kernel Version            => 2.6.5-7.108     
09-14-04 02:18 nlmarco        Bug Monitored: nlmarco                       
09-14-04 22:28 nlmarco        Bugnote Added: 0001759                       
09-21-04 11:59 tiwai          Bugnote Added: 0001798                       
09-23-04 19:16 nlmarco        Bugnote Added: 0001833                       
09-23-04 19:19 tiwai          Bugnote Added: 0001834                       
09-23-04 22:03 nlmarco        Bugnote Added: 0001850                       
09-24-04 12:24 tiwai          Bugnote Added: 0001875                       
10-02-04 18:39 nlmarco        Bugnote Added: 0002007                       
10-04-04 18:56 tiwai          Bugnote Added: 0002013                       
10-04-04 18:56 tiwai          Assigned To               => tiwai           
10-04-04 18:56 tiwai          Resolution               open => fixed       
10-04-04 18:56 tiwai          Status                   new => resolved     
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
