From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio/Midiman - partial success
Date: Mon, 23 Sep 2002 11:12:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D8EDAE9.EB57D16A@ladisch.de>
References: <Pine.LNX.4.31.0209220035210.4610-100000@lorien.wv.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: "Pikus, Fedor" <fedor_pikus@mentorg.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Fedor G. Pikus wrote:
> On Fri, 20 Sep 2002, Clemens Ladisch wrote:
> 
> >       case EXPIRED:
> >               snd_printd("capture read error (DMA or IRQ trouble?)\n");
> >               err = -EIO;
> >
> > Are you _really_ sure you have recompiled the entire alsa-driver package
> > with debug output, installed it correctly, and there's nothing in the log?
> 
> kernel: ALSA ../alsa-kernel/core/pcm_lib.c:2212: EXPIRED in snd_pcm_lib_read1 ...

The "capture read error" message should have been printed.
I guess debug output isn't really enabled for your ALSA core.

> when everything works ok it gets interrupted but when I'm trying to record
> at 96000 it does not. Where do I look now?

Apparently, the USB packets don't arrive, or the driver thinks they don't
arrive, or the driver doesn't like them and throws them away.

In theory, snd_complete_urb is called when some data has been received
from the device, and this function calls retire_capture_urb. Please check
whether those functions are really called.


HTH
Clemens


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
