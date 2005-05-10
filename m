From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001092]: Low volume output with snd-i8x0
Date: Tue, 10 May 2005 03:25:17 +0200
Message-ID: <a4b1c6865c2b7edbf35d23ecad3c88b6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 7CA042E1
	for <alsa-devel@alsa-project.org>; Tue, 10 May 2005 03:25:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1092> 
======================================================================
Reported By:                haYnguy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1092
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6
======================================================================
Date Submitted:             05-06-2005 22:49 CEST
Last Modified:              05-10-2005 03:25 CEST
======================================================================
Summary:                    Low volume output with snd-i8x0
Description: 
Whenever I want to listen to anything, the volume is extremely low.
Everything is supported, plugged in, turned on, turned up, and still the
volume is very low. I can only hear it when I put the speaker to my ear,
and still it is quite faint.
======================================================================

----------------------------------------------------------------------
 jdthood - 05-08-05 19:51 
----------------------------------------------------------------------
> Simple mixer control 'PCM',0
>   Capabilities: pvolume pswitch
>   Playback channels: Front Left - Front Right
>   Limits: Playback 0 - 31
>   Front Left: Playback 16 [52%] [on]
>   Front Right: Playback 16 [52%] [on]

Does it help to increase this level?

----------------------------------------------------------------------
 haYnguy - 05-10-05 03:25 
----------------------------------------------------------------------
i did but it is still very low... (still in the same situation)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-05 22:49 haYnguy        New Issue                                    
05-06-05 22:49 haYnguy        Kernel Version            => 2.6             
05-06-05 23:02 haYnguy        Note Added: 0004599                          
05-07-05 09:47 jdthood        Note Added: 0004601                          
05-07-05 18:46 haYnguy        Note Added: 0004606                          
05-08-05 19:51 jdthood        Note Added: 0004613                          
05-10-05 03:25 haYnguy        Note Added: 0004631                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
