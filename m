From: <jacqueslen@sympatico.ca>
Subject: library problems
Date: Tue, 2 Mar 2004 13:49:53 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040302184953.VAWV23746.tomts5-srv.bellnexxia.net@sympatico.ca>
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

I wanted to get the tempo, so I did this:

    snd_seq_queue_tempo_t *qt;
    snd_seq_queue_tempo_alloca(&qt);
    snd_seq_get_queue_tempo(seq,id,qt);
    return qt->tempo;//line 91

and the compiler told me this:

alsa.cpp:91: invalid use of undefined type `struct _snd_seq_queue_tempo'
/usr/include/alsa/seq.h:382: forward declaration of `struct 
   _snd_seq_queue_tempo'

anyone have any ideas? Thanks


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
