From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: MIDI+USB - one way?
Date: Sun, 4 Aug 2002 20:50:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208042048550.951-100000@pnote.perex-int.cz>
References: <3D4ABCA6.9E126597@ladisch.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D4ABCA6.9E126597@ladisch.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Pedro Lopez-Cabanillas <plcl@telefonica.net>, Michal Seta <mis@creazone.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2 Aug 2002, Clemens Ladisch wrote:

> Pedro Lopez-Cabanillas wrote:
> > It also works for me with OSS emulation:
> > 
> > $ ./rawmidi -v -I /dev/midi02
> > Using:
> > Input: /dev/midi02
> > Output: NONE
> > Read midi in
> > Press ctrl-c to stop
> > read fe
> > read fe
> > read fe
> > read fe
> > read fe
> > read fe
> > read fe
> > Closing
> > 
> > But something as simple as:
> > $ cat /dev/midi02 | od -x
> > Doesn't work. Nothing received. ?!
> 
> rawmidi.c uses the ALSA library functions to access the rawmidi device.
> Internally, alsa-lib should use the same read() call as cat, but there
> seems to be a difference somewhere, maybe in the initialization.
> I'm looking into it.

Note that the cat utility (od probably too) uses big input buffer. If you 
want to capture byte-stream, use the dd utility with the block size of 1 
byte.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
