From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000353]: No sound as startup of KDE 3.2.3, errormessage in snd_pcm_hw.c
Date: Tue, 17 Aug 2004 06:11:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040817041122.D4C121102F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 345FD25E
	for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2004 06:11:23 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000353
======================================================================
Reported By:                JSchmitt
Assigned To:                
======================================================================
Project:                    ALSA - lib
Bug ID:                     353
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-30-2004 19:36 CEST
Last Modified:              08-17-2004 06:11 CEST
======================================================================
Summary:                    No sound as startup of KDE 3.2.3, errormessage in snd_pcm_hw.c
Description: 
When I try to start X with KDE 3.2.3, I will get the following error
mesages:

ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe
ALSA lib pcm_hw.c:549:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed:
Broken pipe

I will not get any sound.
======================================================================

----------------------------------------------------------------------
 perex - 07-15-2004 14:20 CEST 
----------------------------------------------------------------------
Soundcard?

----------------------------------------------------------------------
 JSchmitt - 07-15-2004 17:57 CEST 
----------------------------------------------------------------------
I have the following soundcard:

Ensoniq 5880 AudioPCI (rev 2)

----------------------------------------------------------------------
 samy - 08-17-2004 06:11 CEST 
----------------------------------------------------------------------
Hi everybody, I have the same problem. My sound card is ATI (driver atiixp)
- Acer Travelmate 2000 notebook. However, I do have sound in KDE 3.2, also
sound center does the sound test succesfully ;-). But I suspect that other
applications do not work well, for example Xine player...

Bug History
Date Modified  Username       Field                    Change              
======================================================================
06-30-04 19:36 JSchmitt       New Bug                                      
07-06-04 18:33 JSchmitt       Bug Monitored: JSchmitt                      
07-15-04 14:20 perex          Bugnote Added: 0001433                       
07-15-04 17:57 JSchmitt       Bugnote Added: 0001436                       
08-17-04 06:11 samy           Bugnote Added: 0001572                       
======================================================================


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
