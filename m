From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: stupid question about pcm devices
Date: Fri, 8 Feb 2002 08:42:24 +0100 (CET)
Message-ID: <Pine.LNX.4.31.0202080841410.514-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <XFMail.020208072444.guenther.sohler@newlogic.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Guenther Sohler <guenther.sohler@newlogic.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 8 Feb 2002, Guenther Sohler wrote:

> I have seen that alsa provides nice pcm devices in /dev/snd directory
>
> *They are split in playback and capture devices :) nice idea.
> In Oss I was able to pipe data from and to them and therfore was
> recording/playing back at a certain sample rate.
> With alsa this is not possible anymore. it says the descriptor was in a bad
> state. Is it possible ???

Yes: arecord | aplay

> *Is there something like aconnect for pcm devices ????

Nope.

> when I do a sfxload, it operates on /dev/sequencer, which makes the seq-oss
> module automatically to load. Is there a way to load the patches in native alsa
> ???

No, it's under slow development.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA Project  http://www.alsa-project.org


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
