From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [2.6.3] snd_intel8x0: playing to fast
Date: Wed, 10 Mar 2004 23:08:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xfzcgxsmh.fsf@kth.se>
References: <20040310212125.GA17864@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Luca <kronos@people.it> writes:

> Hi,
> I'm using linux 2.6.3 with alsalib 1.0.2c. When using alsa output plugin
> of XMMS or mplayer the song is played too fast. Using OSS emulation
> works fine.
>
> This is from bootlog:
>
> intel8x0_measure_ac97_clock: measured 49482 usecs
> intel8x0: clocking to 48000

Make sure the programs are using device "default" or "plughw:0,0" (or
whatever device numbers you like).  If the programs can't be persuaded
to do that they are buggy.  Well, those two are buggy anyway.

-- 
Måns Rullgård
mru@kth.se



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
