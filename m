From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: MIDI port names
Date: Thu, 20 Feb 2003 21:19:19 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302202116250.1266-100000@pnote.perex-int.cz>
References: <s5h8ywbf24i.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8ywbf24i.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Pedro Lopez-Cabanillas <plcl@telefonica.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Feb 2003, Takashi Iwai wrote:

> At Thu, 20 Feb 2003 15:14:45 +0100 (CET),
> Jaroslav wrote:
> > 
> > If there is a way to determine the connection between sequencer port and 
> > rawmidi device, I'm ok with any solution. Otherwise, please, solve this 
> > problem.
> 
> one of the advantages of the sequencer is that it hides the lowlevel
> implementations, regardless of mpu401 or wavetable.  hence, there
> is no explicit link between the lowlevel device and the sequencer
> client/port, so far.  there are only bit flags indicating what kind of
> functions are supported by the port.
> 
> it's not bad to have such an attribute, though.  but if we have that,
> it will be an addition.

We can use different name for client like:

RawMIDI - %s

Where %s is whatever you want ;-)) card->shortname, card->id or anything 
else. The card number can be calculated from the client address and device 
/ subdevice from the port address.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
