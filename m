From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Q: how to get an accurate snd_pcm_delay() for dmix
 devices
Date: Fri, 30 Jul 2004 20:09:09 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0407302008390.1767@pnote.perex-int.cz>
References: <1acc01c47635$fea29a70$2c0aa8c0@lumpidu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1acc01c47635$fea29a70$2c0aa8c0@lumpidu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Schnell <daniel.schnell@gmx.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 30 Jul 2004, Daniel Schnell wrote:

> pcm.dmixer {
>     type dmix
>     ipc_key 1027
>     slave {
>         pcm "hw:0,0"
>         period_time 0
>         period_size 256
>         buffer_size 512
>         periods 2
>     }
>     bindings {
>         0 0
>         1 1
>     }

Try add 'slowptr yes' here.

> }

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
