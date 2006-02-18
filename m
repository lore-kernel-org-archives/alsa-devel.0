From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001853]: Why not make @args.CHANNELS in pcm/dmix.conf ???
Date: Sat, 18 Feb 2006 18:16:54 +0100
Message-ID: <b49b96cfd32f1288c1a3eb3ec225298f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9DE001C7
	for <alsa-devel@alsa-project.org>; Sat, 18 Feb 2006 18:16:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1853> 
======================================================================
Reported By:                slammer
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1853
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-18-2006 18:06 CET
Last Modified:              02-18-2006 18:16 CET
======================================================================
Summary:                    Why not make @args.CHANNELS in pcm/dmix.conf ???
Description: 
Why not make @args.CHANNELS in pcm/dmix.conf ???
This can be very helpfull in making dmix pcm more generic and reusable.

According to PCM plugins reference "dmix plugin itself supports only a
single configuration. That is, it supports only the fixed rate (default
48000), format (S16), channels (2), and period_time (125000)."
This trully is a limitation but this doesn't mean that the values cannot
be different than default.
So people start to implement their own dmixed pcm's, introducing the
desired changes. For example in order to create a dmixed output for 5.1
soundcard they create their own dmixed pcm with slave channels set to 6.
They also tend to set many different values which most often are HW
specific and post their configs to other users as a solution, which very
often is not apropraite for other systems. The values can be of course
fetched using concat and card_driver functions, as it is done in the alsa
provided dmix plugin but this is harder to figure out for them, hence
rarely used (I have never seen such a solution online).
few examples:
http://alsa.opensrc.org/index.php?page=DmixPlugin
http://gentoo-wiki.com/HOWTO_Surround_Sound

They could, however, use the provided dmix pcm which would not be very
complicated if it would allow them to change the desired values. It
currently allows to change every parameter listed in the dmix as fixed by
means of providing arguments... every, but the channels count.

I've noticed also that alsa started to use dmixed pcm as the default one
for many cards, but only for stereo output. surroundX are still hw. No
idea why (maybe multichannel dmix performance?) but anyway, if  one day
you decided to use dmix for them, you will need the CHANNELS argument
apparently. Switchng to dmix would be then as simple as changing the
slave.pcm from the hw type clause, to type plug pcm with another slave.pcm
"dmix:X:Y:Z" with the channels count as an argument and adding plug it.

I included a working example of asound.conf which uses only one dmix pcm -
"dmixed" as the slave pcm for many different channel count pcms.
======================================================================

----------------------------------------------------------------------
 slammer - 02-18-06 18:16 
----------------------------------------------------------------------
Errata: (sorry :)
Above the two URLs:
"as it is done in the alsa provided dmix pcm (instead of plugin)"

In the second last sentence ignore the:
"and adding plug it."

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-18-06 18:06 slammer        New Issue                                    
02-18-06 18:06 slammer        File Added: asound.conf                      
02-18-06 18:11 slammer        Issue Monitored: slammer                     
02-18-06 18:16 slammer        Note Added: 0008121                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
