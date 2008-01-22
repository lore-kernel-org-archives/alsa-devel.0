From: forwind <forward@forwind.net>
Subject: Re: problems with Intel Corporation 82801H
	(ICH8	Family)	HD Audio	Controller (rev 03)
Date: Tue, 22 Jan 2008 22:55:13 +0000
Message-ID: <1201042513.5507.3.camel@localhost>
References: <s5h8x2je1pl.wl%tiwai@suse.de>
	<f53DlUKZ.1200934140.0582890.forward@harwood.textdrive.com>
	<s5hd4rv9kqb.wl%tiwai@suse.de>
Reply-To: forward@forwind.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from harwood.textdrive.com (harwood.textdrive.com [207.7.108.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 622E424C19
	for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2008 23:55:19 +0100 (CET)
In-Reply-To: <s5hd4rv9kqb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi wrote:
> Good to hear.  Could you show the output of "lspci -nv" for the audio
> device?  We can add the entry for your device so that the driver works
> without an extra model option.

I think this is what you are after:

00:1b.0 0403: 8086:284b (rev 03)
        Subsystem: 1071:8253
        Flags: bus master, fast devsel, latency 0, IRQ 22
        Memory at fc300000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable-
        Capabilities: [70] Express Unknown type IRQ 0

hope this helps.

Conor

On Mon, 2008-01-21 at 18:01 +0100, Takashi Iwai wrote:
> At Mon, 21 Jan 2008 16:49:00 +0000,
> Forwinder wrote:
> > 
> > Takashi wrote:
> > 
> > >It's a VERY old version.  Try to install the latest ALSA HG version or
> > >the daily snapshot tarball.  If it still doesn't work, check the codec
> > >from /proc/asound/card0/codec#* file, and try to pass model option
> > >values listed in ALSA-Configuration.txt.
> > 
> > I installed 1.0.15 from the website and had to add 'acer-aspire' as an
> > option inorder to get it to work. With 'acer' as the option the
> > speakers worked but the headphones didn't but 'acer-aspire' as the
> > option the speakers and headphones worked but the speakers did not mute
> > when headphones were plugged into the socket.
> > 
> > now it's working pretty okay.
> 
> Good to hear.  Could you show the output of "lspci -nv" for the audio
> device?  We can add the entry for your device so that the driver works
> without an extra model option.
> 
> 
> thanks,
> 
> Takashi
