From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_hwdep_new and snd_seq_device_new
Date: Thu, 14 Jul 2005 11:24:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507141120570.1766@pnote2.perex-int.cz>
References: <42D5405E.9070705@netvigator.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42D5405E.9070705@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Jul 2005, Raymond wrote:

> There are functions snd_hwdep_free() and snd_seq_device_free(), they are 
> not export_symbol
> 
> 
> EXPORT_SYMBOL(snd_hwdep_new) in hwdep.c
> EXPORT_SYMBOL(snd_seq_device_new) in seq/seq_device.c
>
> Do I need to free the (soundfont loading) hwdep device on the callback
> ".dev_free" of the sound card ?

Nope. You may set hwdep->private_free and/or seqdev->private_free callback 
to cleanup/free your allocated data. See snd_seq_device_free() and 
snd_hwdep_free() implementation.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
