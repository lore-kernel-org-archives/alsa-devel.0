From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Hardware interface constant for Bluetooth
Date: Tue, 9 Nov 2004 14:10:32 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0411091410210.15927@pnote.perex-int.cz>
References: <1099877050.6896.70.camel@pegasus>  <Pine.LNX.4.58.0411081152120.2162@pnote.perex-int.cz>
  <1099915428.6896.107.camel@pegasus>  <Pine.LNX.4.58.0411081305260.2162@pnote.perex-int.cz>
 <1100002607.29330.58.camel@pegasus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1100002607.29330.58.camel@pegasus>
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

On Tue, 9 Nov 2004, Marcel Holtmann wrote:

> Hi Jaroslav,
> 
> > The SNDRV_HWDEP_IFACE_BLUETOOTH definition was added to the ALSA CVS tree.
> 
> I checked the CVS HEAD version of the ALSA library and I think it must
> be added there too. Is this correct or is there another way you keep
> these in sync between the kernel and the userspace? Looking at the file
> "include/hwdep.h", I realized that the previous entry for the "EmuX
> wavetable" is also missing.

Thanks. Fixed now.

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
