From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Why do I get broken pipe on write to a pcm
 instatePREPARED?
Date: Tue, 08 Oct 2002 20:50:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA328DA.C1B836EE@libero.it>
References: <Pine.HPX.4.33n.0210080901090.20533-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Paul Davis <pbd@op.net>, Anders Torger <torger@ludd.luth.se>, alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> 
> Abramo Bagnara wrote:
> > > >No data may be read/written in current stream state in the case we are
> > > >discussing.
> > (...)
> >
> > The point is that stream is in bad state wrt read/write, this is the
> > reason why poll should return POLLERR.
> 
> I think the stream is _not_ in a bad state because one buffer of data can
> (and has) be written. The reason for not allowing further writes is that
> the buffer is full, and not that the device wouldn't accept any data at
> all. This is similar to the behaviour of a pipe with the reading end
> opened by an application which currently doesn't read from the pipe, in
> contrast to a pipe with the read end not opened at all.

??? With this message now I'm very confused about what you wish...

Can you resume to me the comparison between current and wanted behaviour
wrt poll for both playback and capture. Leave apart read/write at least
for now.

A table would be easier to understand ;-)

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
