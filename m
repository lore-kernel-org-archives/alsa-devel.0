From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: library problems
Date: Wed, 03 Mar 2004 09:05:06 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403030901510.26204-100000@studcom.urz.uni-halle.de>
References: <20040302184953.VAWV23746.tomts5-srv.bellnexxia.net@sympatico.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040302184953.VAWV23746.tomts5-srv.bellnexxia.net@sympatico.ca>
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
> I wanted to get the tempo, so I did this:
>
>     snd_seq_queue_tempo_t *qt;
>     snd_seq_queue_tempo_alloca(&qt);
>     snd_seq_get_queue_tempo(seq,id,qt);
>     return qt->tempo;//line 91
>
> and the compiler told me this:
>
> alsa.cpp:91: invalid use of undefined type `struct _snd_seq_queue_tempo'
> /usr/include/alsa/seq.h:382: forward declaration of `struct
>    _snd_seq_queue_tempo'

The real definition of snd_seq_queue_tempo_t is hidden deep inside the
ALSA library.  Applications are not allowed to access its fields
directly to allow binary compatibility with future versions of ALSA.

To get the tempo, call snd_seq_queue_tempo_get_tempo(qt).


HTH
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
