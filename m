From: Jaroslav Kysela <perex@suse.cz>
Subject: USB audio devices
Date: Tue, 9 Mar 2004 18:31:21 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403091823130.3966@pnote.perex-int.cz>
References: <1078781348.18057.85.camel@renegade>
 <200403091426.i29EQv9o016723@dhin.linuxaudiosystems.com> <s5hn06qukve.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn06qukve.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 9 Mar 2004, Takashi Iwai wrote:

> BTW, the USB audio is another headache. the current ALSA PCM model isn't
> perfectly suitable for the devices like USB audio.

Unfortunately I don't see a better model. We have already clear handshake,
but USB 1.1 devices, and maybe the Linux core USB code, are failing to
satisfy highly realtime needs, thus we need to manage the extra buffering
to avoid underflows for the DMA operations. I don't know much about USB
2.0, but I guess that 1.x compatibility issues brings another overhead to
this extension which makes it also unuseable when 1.x devices are
connected to same USB port.

I think that it's hardware design issue when the "extra delay" is counted, 
so we can hardly improve things.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
