From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: handling under runs in SND_PCM_NONBLOCK mode
Date: Tue, 3 Aug 2004 11:13:38 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0408031113240.1844@pnote.perex-int.cz>
References: <C179AABD90EE5A4F9A9FFCD13DD6EEED544F8B@server.jacques.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <C179AABD90EE5A4F9A9FFCD13DD6EEED544F8B@server.jacques.com.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nicholas Albion <nalbion@jacques.com.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Aug 2004, Nicholas Albion wrote:

> If I open ALSA in SND_PCM_NONBLOCK mode, how do I handle under runs?
> 
> Calling "snd_pcm_prepare(alsa_handlePlayback);" results in: ALSA lib
> pcm_hw.c:466:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE failed: Device
> or resource busy.
> 
> Opening in default ("0") mode works okay, but I'd prefer to be in
> non-blocking mode.

Use drop or drain functions.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
