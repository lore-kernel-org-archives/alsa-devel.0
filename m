From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Problem with __OLD_GET
Date: Thu, 15 Jan 2004 15:23:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr1tl8sroq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi

Like I explained in a post some time back, I've been having problems with=
=20
not getting correct values from snd_pcm_hw_params functions (specifically=
=20
snd_pcm_hw_params_get_channels_max). I never got an answer though, and th=
e=20
problem disappeared for a while. However it has reappeared, so I decided=20
to find the source (no pun intended) of the problem. It turns out for som=
e=20
reason the deprecated symbols are getting called (__OLD_GET), so when I=20
expect to have the passed value pointer filled in, all that happens is it=
=20
gets zeroed. I'm afraid I don't understand all the preprocessor magic, so=
=20
I don't completely understand why this happens. That is, the correct=20
versions of these functions have been called correctly, but suddenly the=20
old ones are used instead.

Maybe its down to some weird linking problem, it only happens with a=20
dynamically loaded PortAudio plugin I've written for an xmms fork called=20
beep-media-player. If anyone could come up with a likely explanation as t=
o=20
what's going on here, I'd be grateful. Is there some mechanism that=20
figures my lib is linked against an old version of ALSA-lib? Btw, I'm=20
using ALSA-lib 1.0.1, and drivers compiled into 2.6.1-mm2.

Thanks

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
