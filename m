From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000509]: Conexant Moden "not ready"
Date: Wed, 22 Sep 2004 02:16:24 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040922001624.B475839004@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 11BD635F
	for <alsa-devel@alsa-project.org>; Wed, 22 Sep 2004 02:16:25 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000509
======================================================================
Reported By:                gbilotta
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Bug ID:                     509
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian GNU/Linux Testing
Kernel Version:             2.6.7
======================================================================
Date Submitted:             09-20-2004 19:20 CEST
Last Modified:              09-22-2004 02:16 CEST
======================================================================
Summary:                    Conexant Moden "not ready"
Description: 
modprobing for snd_intel8x0m gives the following error:

MC'97 1 converters and GPIO not ready (0xff00)
======================================================================

----------------------------------------------------------------------
 sashak - 09-20-2004 22:23 CEST 
----------------------------------------------------------------------
Hello Giuseppe "Oblomov",

I'm not sure that this is the reason, but according to AC97 spec (rev.2.3
at least) modem reset should be performed by writing something to register
AC97_EXTENDED_MID (0x3c) and AC97_RESET (0x0) should not be touched. So
probably this hw just works in right way.

Just for clarification could you try this patch ( cd linux-2.6.7 ; patch
-p0 ):

--- sound/pci/ac97/ac97_codec.c.orig    2004-09-20 23:00:24.903845416
+0300
+++ sound/pci/ac97/ac97_codec.c 2004-09-20 23:07:23.341233264 +0300
@@ -1784,7 +1784,16 @@
                goto __access_ok;
        }
 
+#define JUST_FORCHECK 1
+#ifdef JUST_FORCHECK
+       /* reset to defaults */
+       if(ac97->scaps & AC97_SCAP_SKIP_AUDIO)
+               snd_ac97_write(ac97, AC97_EXTENDED_MID, 0);     /* modem
*/
+       else
+               snd_ac97_write(ac97, AC97_RESET, 0);    /* audio */
+#else
        snd_ac97_write(ac97, AC97_RESET, 0);    /* reset to defaults */
+#endif
        if (bus->wait)
                bus->wait(ac97);
        else {

----------------------------------------------------------------------
 gbilotta - 09-22-2004 00:24 CEST 
----------------------------------------------------------------------
Yes, your diagnosis seems to be correct. With the separate init code for
the modem I don't get the "not ready" error. Of course I'm still not 100%
sure whether I can use the modem or not ... is there some way I can check?

----------------------------------------------------------------------
 sashak - 09-22-2004 02:16 CEST 
----------------------------------------------------------------------
Good for start. Thanks. :)
You may try to capture sound from phone line (with arecord) - when line is
connected you should be able to record dial tone in grabbed file.
If it will ok. Try to dial with slmodem-2.9.9-alsa
(http://linmodems.technion.ac.il/packages/smartlink/).
If not please send again '/proc/asound/Modem/codec97#0/mc97#1-1+regs'.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-20-04 19:20 gbilotta       New Bug                                      
09-20-04 19:20 gbilotta       File Added: asound.tar.bz2                    
09-20-04 19:20 gbilotta       Distribution              => Debian GNU/Linux Testing
09-20-04 19:20 gbilotta       Kernel Version            => 2.6.7           
09-20-04 19:21 gbilotta       File Added: lspci.out                        
09-20-04 22:23 sashak         Bugnote Added: 0001795                       
09-22-04 00:24 gbilotta       Bugnote Added: 0001809                       
09-22-04 02:16 sashak         Bugnote Added: 0001810                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
