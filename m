From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: How to support multiple open in low-level driver
Date: Mon, 6 Jan 2003 15:26:36 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301061519390.551-100000@pnote.perex-int.cz>
References: <200301060909.04979.fredg@wava.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA00822
	for <alsa-devel@alsa-project.org>; Mon, 6 Jan 2003 15:28:31 +0100
In-Reply-To: <200301060909.04979.fredg@wava.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fred Gleason <fredg@wava.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 6 Jan 2003, Fred Gleason wrote:

> On Sunday 05 January 2003 10:05, Jaroslav Kysela wrote:
> 
> > Well, you're talking about PCM devices (subdevices are one level after
> > devices):
> >
> > cards -> pcm devices -> pcm subdevices
> 
> What are the differences between a "device" and a "subdevice" in general?  Is 
> this indicative of some underlying hardware architecture, or is it a purely 
> logical/virtual artifact?

We use subdevices mainly for hardware which can mix several streams 
together. It's quite impractical to have 32 devices with exactly same 
capabilities. The subdevices can be opened without a specific address, so 
the first free subdevice is opened. Also, we temporary use subdevices for 
hardware with alot of streams (I/O connectors) - for example MIDI. There 
are several limits given by used minor numbers (8 PCM devices per card, 8 
MIDI devices per card etc.).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
