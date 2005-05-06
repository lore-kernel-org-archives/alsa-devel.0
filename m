From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001092]: Low volume output with snd-i8x0
Date: Fri, 6 May 2005 23:02:18 +0200
Message-ID: <a99a656d8cd09108eeafd65c7d109295@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 74356220
	for <alsa-devel@alsa-project.org>; Fri,  6 May 2005 23:02:18 +0200 (MEST)
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
Last Modified:              05-06-2005 23:02 CEST
======================================================================
Summary:                    Low volume output with snd-i8x0
Description: 
Whenever I want to listen to anything, the volume is extremely low.
Everything is supported, plugged in, turned on, turned up, and still the
volume is very low. I can only hear it when I put the speaker to my ear,
and still it is quite faint.
======================================================================

----------------------------------------------------------------------
 haYnguy - 05-06-05 23:02 
----------------------------------------------------------------------
this is my lsmod output:

Module                  Size  Used by
snd_pcm_oss            56224  0
snd_mixer_oss          18816  1 snd_pcm_oss
snd_seq_oss            33408  0
snd_seq_midi_event      6528  1 snd_seq_oss
snd_seq                54800  4 snd_seq_oss,snd_seq_midi_event
snd_seq_device          7308  2 snd_seq_oss,snd_seq
snd_intel8x0           29376  2
snd_ac97_codec         81272  1 snd_intel8x0
snd_pcm                92168  3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              22788  2 snd_seq,snd_pcm
snd                    50788  13
snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
snd_page_alloc          8324  2 snd_intel8x0,snd_pcm

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-05 22:49 haYnguy        New Issue                                    
05-06-05 22:49 haYnguy        Kernel Version            => 2.6             
05-06-05 23:02 haYnguy        Note Added: 0004599                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
