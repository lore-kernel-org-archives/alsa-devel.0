From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: Interrupt-driven (or callback/handler?), Full-duplex
 (simultaneous capture/playback) without using JACK
Date: Mon, 10 Nov 2003 12:05:29 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0311101205060.3073@pnote.perex-int.cz>
References: <000601c3a779$752cfd70$264440ab@roboserv1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <000601c3a779$752cfd70$264440ab@roboserv1>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Cassidy <rcassidy@stanford.edu>
Cc: 'Paul Davis' <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 10 Nov 2003, Ryan Cassidy wrote:

> Many thanks for the info.!
>
> I guess my follow-up question would be this: I want to implement
> non-busy waiting for alsa simultaneous audio playback/capture.  If I
> call the blocking versions of snd_pcm_read/snd_pcm_write in a separate
> process (that I fork off from the main application), will the read/write
> process yield to the main application process during the blocking
> read/write (i.e. will it got to sleep waiting for i/o?)?

Sure. It's the standard unix behaviour.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
