From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd_pcm_unlink -> EINVAL?
Date: Mon, 26 Jan 2004 16:37:34 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401261635580.2959@pnote.perex-int.cz>
References: <Pine.LNX.4.58.0401261529240.562@autumn>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA13908
	for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2004 16:37:42 +0100
In-Reply-To: <Pine.LNX.4.58.0401261529240.562@autumn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Tim Goetze <tim@quitte.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 26 Jan 2004, Tim Goetze wrote:

> when calling snd_pcm_unlink (stream) after an xrun occurred, it
> returns EINVAL (hw: device, duplex, mmap'd IO, stop_threshold = ~0),
> even though 'stream' is a valid PCM stream handle.
> 
> the snd_pcm_unlink code path seems to return EINVAL only if the stream
> isn't linked to another.
> 
> but EINVAL misses the point, since the stream handle is valid.
> if one tries to unlink a stream that isn't linked to another, EALREADY
> is correct imo.

Yes, changed.

> and my question for today: does the kernel layer unlink PCM streams
> when an xrun occurs?

No. The unlinking is done manually (unlink ioctl) or at close() of
a PCM handle.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
