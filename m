From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Priming buffer
Date: Wed, 10 Sep 2003 20:02:17 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprvapp3lxq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello

I'm trying to implement a function where a client function can be called=20
to fill a playback pcm's buffer, before it is started. It doesn't quite=20
work as I expected though, the transient sounds muted. On the other hand,=
=20
unless I fill the buffers before hand (normally with zeros), I get a burs=
t=20
of noise. But anyway, maybe my goal can be accomplished with the help of=20
ALSA-lib? I've taken a good look at the sw_params interface, but I don't=20
quite understand the intention of some of the functions even after=20
browsing the docs. What's the purpose of set_start_threshold? Will a star=
t=20
threshold equivalent to buffer size mean the pcm is not actually started=20
before the buffer is full, even after snd_pcm_start has been called (so=20
that the buffer is in effect primed)? Sorry for bothering you guys about=20
the seemingly obvious, but the documentation _is_ a bit brief regarding=20
certain things.

Thanks

Arve Knudsen


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
