From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: xrun in arecord, ice1714
Date: Tue, 19 Nov 2002 23:04:56 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211192258530.26794-100000@aino.wakkanet.fi>
References: <200211192048.21064.info.mz@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200211192048.21064.info.mz@gmx.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Ziegler <info.mz@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 19 Nov 2002, Mark Ziegler wrote:

> ecasound -r -z:db -z:intbuf -f:s32_le,12,44100 -i alsa,hw:1 -f:s32_le,2,44100
> -o test.wav
[...]
> under root, but usually my system hangs complete after starting ecasound.
>  Only once it worked and it also reported that some data are lost.

How about if you start as non-root and without the -r? It should still 
be relatively stable due to the -z:db (disk buffering) and -z:intbuf 
(soundcard buffering) options. If this fails, I'd be interested in 
seeing the exact error messages printed by ecasound.

> the problem, that my IDE-drives are buffered in memory, and sometime huge
> buffers are written back to the harddisk and the alsa driver doesn't get time
> to write out his buffer? Is it more a problem of the userspace (arecord) or
> of the alsa-driver?

Make sure you have DMA enabled for disk i/o. See for instance
the article at http://linux.oreillynet.com/lpt/a/467 

> Or can anybody explain the problem roughly? I think my 2 GHz processor should
> be completely bored by transporting 44.1kHz * 2 * 16 / 8  = 176400 Bytes/s
> from the sound card to the IDE disk.

Yep, definitely something goes badly wrong.

--
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
