From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: Rawmidi vs. /dev/snd/*
Date: Mon, 02 Apr 2012 00:21:29 -0500
Message-ID: <4F793759.4050006@gmail.com>
References: <7F5048EEC8BC46EE9D6306291A92F3EC@PAULD>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A25EC24630
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Apr 2012 07:21:31 +0200 (CEST)
Received: by obbef5 with SMTP id ef5so1023754obb.38
	for <alsa-devel@alsa-project.org>; Sun, 01 Apr 2012 22:21:37 -0700 (PDT)
In-Reply-To: <7F5048EEC8BC46EE9D6306291A92F3EC@PAULD>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Paul D. DeRocco" <pderocco@ix.netcom.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 04/01/2012 01:25 AM, Paul D. DeRocco wrote:
> In writing an embedded app that will be the only thing talking to MIDI, and
> in which I don't need any timing or routing capability, is there any reason
> to use ALSA Rawmidi, as opposed to merely reading and writing the device via
> the file system? Which is the lower-level, and therefore most efficient,
> interface? I'm leaning toward the latter, because I already know how to use
> poll() to wait for incoming data on multiple input devices, but I don't see
> how to do that via Rawmidi.
>

ALSA Rawmidi is the same as doing read/write operations on the file 
system.  Rawmidi is a very thin, low-level interface to 
/dev/snd/midiCxDx.  There is no performance advantage of using one 
approach over the other because they are the same thing.

You're probably better off using the API because it's likely to help you 
avoid mistakes and it gives you easier access to the kernel ioctl() calls.

You can use snd_rawmidi_poll_descriptors() to access the raw file 
descriptors for the midi device so that you can add to your other 
polling descriptors.

-gabriel
