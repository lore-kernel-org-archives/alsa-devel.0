From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: MIDI port names
Date: Thu, 20 Feb 2003 09:55:18 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302200953350.1266-100000@pnote.perex-int.cz>
References: <200302200046.18193.plcl@telefonica.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200302200046.18193.plcl@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 20 Feb 2003, Pedro Lopez-Cabanillas wrote:

> On Wednesday 19 February 2003 14:51, Takashi Iwai wrote:
> > there is the name field for each rawmidi substream, and the sequencer
> > looks up this string.
> >
> > this reminds me the former patch by Clemens, and i've forgotten to
> > check this issue until now.  sorry.
> >
> > i modified the sequencer part (and mpu401_uart) on the cvs so that the
> > sequencer retrieves the rawmidi name string if the substream name is
> > not defined. 
> 
> But Clemens' patch (attached is a slightly modified version) was not for port 
> names but for client names, from "External MIDI x" to the more meaningful 
> rawmidi name. I think that this is what some people is requesting, and makes 
> things easier for large studio setups when some applications, like kaconnect, 
> show client names but not port names. Please, apply.

I don't agree with this patch. kaconnect or other applications might 
simply parse the string and if matches - get the real name over the 
control interface. Otherwise, it is not clear, that the port is equal to
a rawmidi device.

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
