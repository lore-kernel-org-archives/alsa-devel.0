From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Need some hints for simple MIDI communication
Date: Fri, 8 Feb 2002 08:43:07 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202080842460.514-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <E16YyMU-00028E-00@smtp.web.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Frank Neumann <beachnase@web.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 8 Feb 2002, Frank Neumann wrote:

> Hi,
> I would like to know how I go about creating a small program that lets
> me send /received patch sets ("banks") into my synthesizers via SysEx MIDI
> communication.
>
> I know all about the actual required SysEx parameters, and I had also once
> written such a program for OSS (simply using read()/write() to/from
> /dev/midi), but now I'd like to port this to ALSA.
>
> As far as I can tell, there is either the "rawmidi" interface or the
> more complex(?) way by going through snd_seq_open(...).
>
> I have some problems with rawmidi; if I try the test program from the
> current (0.9.0beta10) alsa-lib source the way it suggests, I always get:
>
> franky@faramir:/u1/src/ALSA/0.9.0beta10/alsa-lib-0.9.0beta10/test> ./rawmidi -i 0 0
> ALSA lib rawmidi.c:184:(snd_rawmidi_open_noupdate) Unknown RawMidi 0
> snd_rawmidi_open 0 failed: -2

It's a wrong syntax. You should use:

./rawmidi -i hw:0,0

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA Project  http://www.alsa-project.org


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
