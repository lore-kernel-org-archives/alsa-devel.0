From: AthlonRob <athlonrob@data.4t3.com>
Subject: Re: Multiple Sound Streams out of a single card
Date: 14 Sep 2003 08:50:37 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1063554637.21173.11.camel@localhost>
References: <200309140606.h8E66UCi032132@oud>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200309140606.h8E66UCi032132@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2003-09-13 at 23:06, Paul Davis wrote:
> ALSA now offers the "dmix" plugin layer that allows multiple
> applications to write to a PCM device without locks. just tell an ALSA
> aware app to use "dmix:0" and both it and many other apps will all be
> able to share the device.

Wow, it's good to see something like that.  :-)

I just tried it, though, and it didn't seem to want to work for me...

With my .asoundrc looking like this:

pcm.main {
        type dmix
        slave {
                pcm default
        }
}

I got this, running alsaplayer -d main /path/to/wav/file :

ALSA lib pcm_dmix.c:1184:(_snd_pcm_dmix_open) Unique IPC key is not defined
snd_pcm_open: Invalid argument (main)
Failed to initialize plugin!
Failed to register plugin: /usr/lib/alsaplayer/output/libalsa_out.so
Failed to load output plugin "alsa". Trying defaults.
ALSA lib pcm_dmix.c:1184:(_snd_pcm_dmix_open) Unique IPC key is not defined
snd_pcm_open: Invalid argument (main)
Failed to initialize plugin!
/usr/lib/alsaplayer/output/libalsa_out.so failed to load

If I run alsaplayer -d dmix:0 /path/to/wav/file, I get this:

ALSA lib pcm.c:1908:(snd_pcm_open_noupdate) Unknown PCM 0
ALSA lib pcm_dmix.c:954:(snd_pcm_dmix_open) unable to open slave
snd_pcm_open: No such file or directory (dmix:0)
Failed to initialize plugin!
Failed to register plugin: /usr/lib/alsaplayer/output/libalsa_out.so
Failed to load output plugin "alsa". Trying defaults.
ALSA lib pcm.c:1908:(snd_pcm_open_noupdate) Unknown PCM 0
ALSA lib pcm_dmix.c:954:(snd_pcm_dmix_open) unable to open slave
snd_pcm_open: No such file or directory (dmix:0)
Failed to initialize plugin!
/usr/lib/alsaplayer/output/libalsa_out.so failed to load

So I see it really isn't working for me.

> and remember that Linux (and Mac OS X) also have JACK, which offers a
> service that isn't exactly matched on Windows, though rewire comes
> close, sort of.

I see how the various Linux audio offerings may be superior to what you
can do with Windows, in a real professional setup... but for being able
to play multiple things at once, unless DMIX pans out, Windows may have
us beaten.  :-\

Is there a way to force OSS emulation to use the dmix plugin?

:::off to grep the great WWW for dmix info:::

Rob



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
