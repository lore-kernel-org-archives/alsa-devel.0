From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: minor bug in emu10k1 + toslink
Date: Mon, 11 Mar 2002 19:35:05 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0203111931440.535-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <20020311191944.C1214@shurdeek.cb.ac.at>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Peter Surda <shurdeek@panorama.sth.ac.at>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 11 Mar 2002, Peter Surda wrote:

> Hi!
> 
> with driver0.9pre10 and 12, the toslink output (alsamixer calls it IEC958
> Optical Raw) on my sblive! has reversed mixer settings. I.e. when I set it to
> mute, it sends music and when I unmute it, it is silenced. Nothing fatal but
> should be imho fixed in long term.

It's ok. If you unmute 'RAW' switch, then you can feed raw S/PDIF stream 
to hw:0,3 device. It's used for AC3 stream forwarding for DVD audio. Use 
'IEC958 Optical' bar to control S/PDIF out.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
