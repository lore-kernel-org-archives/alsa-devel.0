From: noreply@alsa-project.org
Subject: [ALSA - driver 0000274]: Builtin CS4235 on intel mainboard won't work
Date: Fri, 16 Jul 2004 12:47:43 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104743.12CB926008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 909B9255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:47:43 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000274
======================================================================
Reported By:                NoKey
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     274
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Slackware 9.1.0
Kernel Version:             2.6.6 (Vanilla, all drivers built in. No module support)
======================================================================
Date Submitted:             05-14-2004 10:25 CEST
Last Modified:              07-16-2004 12:47 CEST
======================================================================
Summary:                    Builtin CS4235 on intel mainboard won't work
Description: 
I have (at work) an intel mainboard with a builtin 'CS4235 CODEC' which
does not work. I'm afraid I don't know the exact mainboard version but
that's OK, because I've created a patch that fixes this.
The breakage was due to some stupid (see add'l info) logical device (id
CSC010f) which is disabled.
Patch applies to linux-2.6.6/sound/isa/cs423x:
===========================================================
--- cs4236.c.org        2004-05-10 04:32:01.000000000 +0200
+++ cs4236.c    2004-05-13 17:01:17.000000000 +0200
@@ -198,6 +198,8 @@
        { .id = "CSC0225", .devs = { { "CSC0000" }, { "CSC0010" }, {
"CSC0003" } } },
        /* Intel Marlin Spike Motherboard (https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002) - CS4235 */
        { .id = "CSC0225", .devs = { { "CSC0100" }, { "CSC0110" }, {
"CSC0103" } } },
+       /* Unknown Intel mainboard - CS4235 */
+       { .id = "CSC0225", .devs = { { "CSC0100" }, { "CSC0110" } } },
        /* Genius Sound Maker 3DJ - CS4237B */
        { .id = "CSC0437", .devs = { { "CSC0000" }, { "CSC0010" }, {
"CSC0003" } } },
        /* Digital PC 5000 Onboard - CS4236B */

======================================================================

----------------------------------------------------------------------
 tiwai - 05-14-2004 12:16 CEST 
----------------------------------------------------------------------
thanks, the patch is applied to cvs now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
05-14-04 10:25 NoKey          New Bug                                      
05-14-04 10:25 NoKey          Distribution              => Slackware 9.1.0 
05-14-04 10:25 NoKey          Kernel Version            => 2.6.6 (Vanilla, all drivers built in. No module support)
05-14-04 12:16 tiwai          Bugnote Added: 0001108                       
05-14-04 12:16 tiwai          Assigned To               => tiwai           
05-14-04 12:16 tiwai          Resolution               open => fixed       
05-14-04 12:16 tiwai          Status                   new => resolved     
07-16-04 12:47 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
