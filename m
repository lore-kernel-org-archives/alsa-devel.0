From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: setting ppq problems
Date: Mon, 01 Mar 2004 14:02:10 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403011354100.5532-100000@studcom.urz.uni-halle.de>
References: <20040229230605.KRLK21160.tomts22-srv.bellnexxia.net@sympatico.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040229230605.KRLK21160.tomts22-srv.bellnexxia.net@sympatico.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jacqueslen@sympatico.ca
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

jacqueslen@sympatico.ca wrote:
> I'm trying to set my ppq on my queue, so I do this:
>
>     snd_seq_queue_tempo_t *qt;
>     snd_seq_queue_tempo_alloca(&qt);
>     snd_seq_queue_tempo_set_ppq(qt, ppq);
>     return snd_seq_set_queue_tempo(seq, id, qt);

> that returns -22, what does that mean?

snd_strerror(-22) = "Invalid argument"

A snd_seq_queue_tempo_t container contains various parameters, so you
should set all fields to valid values (or get the current values first
with snd_seq_get_queue_tempo).

> Also, where can I found out what the members of
> snd_seq_queue_tempo_t are, I can't seem to find it anywhere!

The snd_seq_get/set_queue_tempo_xxx functions are listed on this page:
http://www.alsa-project.org/alsa-doc/alsa-lib/group___seq_queue.html


HTH
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
