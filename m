From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MIDI+USB - one way?
Date: Mon, 05 Aug 2002 10:43:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D4E3AB0.563AB976@ladisch.de>
References: <Pine.LNX.4.33.0208042048550.951-100000@pnote.perex-int.cz>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Pedro Lopez-Cabanillas <plcl@telefonica.net>, Michal Seta <mis@creazone.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Fri, 2 Aug 2002, Clemens Ladisch wrote:
> > rawmidi.c uses the ALSA library functions to access the rawmidi device.
> > Internally, alsa-lib should use the same read() call as cat, but there
> > seems to be a difference somewhere, maybe in the initialization.
> 
> Note that the cat utility (od probably too) uses big input buffer. If you
> want to capture byte-stream, use the dd utility with the block size of 1
> byte.

No, the size of the input buffer must not prevent read() from returning
data which is available immediately.  IOW: if some data is available,
read() mustn't block.  ALSA's current read() implementation is wrong in
this regard.

This isn't only incompatible to OSS, but also to any other implementation
of read() in Linux (or any other Unix-like OS, not to mention POSIX or
SUS).


Clemens


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
