From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Re: How to support multiple open in low-level driver
Date: Mon, 6 Jan 2003 18:30:19 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0301061826260.551-100000@pnote.perex-int.cz>
References: <3E19A62E.20402@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA03791
	for <alsa-devel@alsa-project.org>; Mon, 6 Jan 2003 18:33:21 +0100
In-Reply-To: <3E19A62E.20402@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 7 Jan 2003, Patrick Shirkey wrote:

> Jaroslav Kysela wrote:
> 
> > 
> > We use subdevices mainly for hardware which can mix several streams 
> > together. It's quite impractical to have 32 devices with exactly same 
> > capabilities. The subdevices can be opened without a specific address, so 
> > the first free subdevice is opened. Also, we temporary use subdevices for 
> > hardware with alot of streams (I/O connectors) - for example MIDI. There 
> > are several limits given by used minor numbers (8 PCM devices per card, 8 
> > MIDI devices per card etc.).
> > 
> 
> In the interest of correct documentation how is this explained:
> 
> hw:0,0
> 
> The first zero is the card number?
> The second zero is the device number?
> 
> What happens for sound devices that are not cards? For example the usb 
> quattro.
> 
> Up until now I have rationalised it as the first zero is the device, the 
> second zero is the subdevice and the number of streams that the 
> subdevice can do hardware mixing for would become the subsubdevices.
> 
>  From your message above do I understand we should call every sound 
> device a sound card.

Yes, it might be confusing, but subsubdevice is not very good term. A card 
is in my eyes a compact hardware unit with several sound related devices.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
