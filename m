From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000504]: after the alsa modules are loaded, active speaker beginns to make noise
Date: Wed, 12 Jan 2005 21:48:12 +0100
Message-ID: <82f368174a4cf288d0c16099895acd87@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 076A62F3
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2005 21:48:12 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=504> 
======================================================================
Reported By:                placew
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   504
Category:                   OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo.2004
Kernel Version:             2.6.7-gentoo-r6
======================================================================
Date Submitted:             09-16-2004 12:36 CEST
Last Modified:              01-12-2005 21:48 CET
======================================================================
Summary:                    after the alsa modules are loaded, active speaker
beginns to make noise
Description: 
i've got my alsa modules compiled in a kernel, v.2.6.7-gentoo-r6. At boot,
once, there are the alsa modules loaded, active speaker starts hissing.
When mp3 (or other sound) is playing, the noise is getting low, almoust
unhearable. Active speaker stops hissing once the modules are unloaded
during the reboot.  My soundcard is ensoniq PCI128, using module ens1371.
Thanks for cooperation.
======================================================================

----------------------------------------------------------------------
 Sebastian - 12-02-04 21:12 
----------------------------------------------------------------------
Same here with snd_intel8x0 (Asus A7N8X Deluxe mainboard with nforce2
onboard-sound). The noise starts when the snd_intel8x0 driver is loaded. 

I can't hear the noise when playing music. When I start playing and press
pause (with xmms), the noise disappears. It starts again when I hit "stop"
on xmms. This is not xmms-related, same with other players. Seems as if
accessing the sound device stops the noise as long as the device is being
used. After releasing the device, the noise comes back.

Muting the channels doesn't help. I can hear the noise with all channels
muted (including inputs).

A friend of mine found that this only occurs with his computer (Thinkpad
T20, don't remember the sound chip) with kernel-2.6-included alsa drivers.
Kernel 2.4 with separate alsa did not show any noise. Didn't tried 2.4
here but will do so soon.

Sebastian

----------------------------------------------------------------------
 wvd - 01-12-05 21:48 
----------------------------------------------------------------------
Same here, modules compiled with a 2.6.10 GNU/Linux, exactly the same
behaviour as discribed by reporter 'placew'.
Using the same ensoniq 1371
Alsa version 1.05a
Hissing fades when screen activity (RIVA TNT2)
Muting ALL does not have any effect on the hissing.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-16-04 12:36 placew         New Issue                                    
09-16-04 12:36 placew         Distribution              => Gentoo.2004     
09-16-04 12:36 placew         Kernel Version            => 2.6.7-gentoo-r6 
09-17-04 10:42 placew         Issue Monitored: placew                      
09-17-04 10:42 placew         Issue End Monitor: placew                    
09-28-04 16:07 djtm           Note Added: 0001948                          
12-02-04 21:01 Sebastian      Issue Monitored: Sebastian                    
12-02-04 21:12 Sebastian      Note Added: 0002698                          
01-12-05 21:48 wvd            Note Added: 0003179                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
