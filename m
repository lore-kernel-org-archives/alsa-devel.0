From: <jacqueslen@sympatico.ca>
Subject: setting ppq problems
Date: Sun, 29 Feb 2004 18:06:05 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040229230605.KRLK21160.tomts22-srv.bellnexxia.net@sympatico.ca>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,
I'm trying to set my ppq on my queue, so I do this:

    snd_seq_queue_tempo_t *qt;
    snd_seq_queue_tempo_alloca(&qt);
    snd_seq_queue_tempo_set_ppq(qt, ppq);
    return snd_seq_set_queue_tempo(seq, id, qt);

where id is my queue id and ppq the new ppq. This is quite similar to the way I set my tempo(which works). However, when I do it, the ppq remains unchanged and that returns -22, what does that mean? 
Also, where can I found out what the members of snd_seq_queue_tempo_t are, I can't seem to find it anywhere! 
Thanks!
--Jacques


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
