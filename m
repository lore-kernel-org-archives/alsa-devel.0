From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: PCM API update
Date: Sat, 12 Oct 2002 11:54:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA7F15B.A8E89CB4@libero.it>
References: <Pine.LNX.4.33.0210121134040.1975-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.libero.it (smtp3.libero.it [193.70.192.127])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA29447
	for <alsa-devel@alsa-project.org>; Sat, 12 Oct 2002 11:55:17 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> 
> In this case, I propose to change snd_pcm_avail() to snd_pcm_hwsync()
> function with description: "synchronize r/w pointers with hardware".
> Really, after some thinking, the return value from snd_pcm_avail() cannot
> be used for nothing serious. I simply don't like that delay() functions
> do more arithmetic than necessary. Overdesign has been criticized in this
> list, too.

Let examine kernel level: snd_pcm_{plaback,capture}_delay do a
snd_pcm_update_hw_ptr and a snd_pcm_{playback_hw,capture}_avail (that's
only a wrap safe difference).

Are you sure you want to add another ioctl and another API function in
all the PCM classes just to avoid a subtraction?

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
