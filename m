From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: PCM API update
Date: Fri, 11 Oct 2002 22:13:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA73101.7A53993D@libero.it>
References: <Pine.LNX.4.33.0210112037220.1244-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.libero.it (smtp3.libero.it [193.70.192.127])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA18804
	for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2002 22:15:54 +0200
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
> Hi all,
> 
>         these enhancements are in CVS for PCM API:
> 
> - added snd_pcm_avail() function - this function returns count of
>   available frames for write or read operations, the position
>   is read directly from hardware; the snd_pcm_avail_update() call
>   is still mandatory before any I/O!!!

I really don't understand why you've added another ioctl and another
function to replicate in all PCM classes.
snd_pcm_delay existence is enough to implement that.
I'm missing something?

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
