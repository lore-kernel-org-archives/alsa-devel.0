From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Hardware interface constant for Bluetooth
Date: Mon, 8 Nov 2004 11:54:19 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411081152120.2162@pnote.perex-int.cz>
References: <1099877050.6896.70.camel@pegasus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1099877050.6896.70.camel@pegasus>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 8 Nov 2004, Marcel Holtmann wrote:

> Hi guys,
> 
> I like to drive the Bluetooth audio support a little bit and it would be
> great if you can add a hardware interface constant for us. I don't know
> what is the correct procedure to do it, but from my first analysis it
> seems that it is enough to add a patch like the one below to the kernel
> code and the library code. Everything else can be developed outside the
> ALSA core.
> 
> +       SNDRV_HWDEP_IFACE_BLUETOOTH,    /* Bluetooth audio */

Do you need really this change? This identifier is only used for hardware 
independent API (hwdep) - mostly for firmware / DSP code handling and 
other things which don't fall into abstract APIs.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
