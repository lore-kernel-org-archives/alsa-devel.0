From: Abramo Bagnara <abramo@alsa-project.org>
Subject: Re: should i be able to abort in the middle of
 snd_pcm_mmap_{begin,commit} ?
Date: Wed, 13 Feb 2002 18:47:54 +0100
Message-ID: <3C6AA6CA.6C7C68@alsa-project.org>
References: <200202131727.g1DHRM604896@op.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received: from smtp1.libero.it (smtp1.libero.it [193.70.192.51])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA22575
	for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2002 18:48:08 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> should it work for me to call snd_pcm_drop() for both playback and
> capture streams if i'm in the middle of a snd_pcm_mmap_{begin,commit}
> pair?
> 
> unless i use RT timing, on both the trident and hammerfall, doing do
> invariably causes an effect upon restarting the streams that suggests
> an out-of-sync hw-pointer.

Do you mean:

snd_pcm_mmap_begin
snd_pcm_drop
snd_pcm_mmap_commit

sequence?

If yes, it does not work, you need to call snd_pcm_mmap_begin again
after snd_pcm_drop.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
