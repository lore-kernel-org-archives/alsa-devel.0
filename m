From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_open hangs intermittently?
Date: Mon, 11 Mar 2002 15:31:58 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0203111529011.550-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA24788
	for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2002 15:32:20 +0100
In-Reply-To: <C1E3CFAE25BBCB45AAB06733BDC048DF18BBCC@tempo.INTERN.ARTCOM.DE>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ulrich Zadow <ulrich.zadow@ARTCOM.DE>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 11 Mar 2002, Ulrich Zadow wrote:

> Hi,
> 
> snd_pcm_open() hangs on our machines about 1/10 of the time (ALSA 0.9.12, RME and VIA686 cards). Our code looks about like this:
> 
>   snd_pcm_t * myDevice;
>   cerr << "Opening sound device...";
>   err = snd_pcm_open (&myDevice, "plughw:0,0", SND_PCM_PLAYBACK, 0);
>   if (err < 0) {
>     cerr << "failed." << endl;
>   } else {
>     cerr << "ok." << endl;
>   }
> 
> The output of this piece of code is just "Opening sound device...". We're pretty sure that we're closing the device correctly before this happens.
> 
> Any ideas?

It looks like that another task uses given device (perhaps some daemon 
like arts).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
