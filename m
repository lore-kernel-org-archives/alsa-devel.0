From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Trying to make gkrellm work with ALSA.
Date: Thu, 05 Feb 2004 11:55:14 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr2v8mcznq1sf88@mail.broadpark.no>
References: <40218E7A.5050402@charter.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40218E7A.5050402@charter.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nathan Morell <frizop@charter.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

You could always have a look at the v19 (development) branch of PortAudio=
=20
(www.portaudio.com), which offers an abstraction layer on top of host=20
APIs. ALSA is well supported under v19 (I am one of the authors), while=20
the OSS and JACK layers might need some work (although I'm not totally a=20
jour on their status). Anyway, PortAudio has both callback driven and=20
blocking interfaces, and there is a C++ wrapper called PaCpp (supports=20
class member callbacks from what I remember). If nothing else, you could=20
have a look at how the callback implementation on top of ALSA is done.

Hope this helps

Arve Knudsen

On Wed, 04 Feb 2004 18:29:46 -0600, Nathan Morell <frizop@charter.net>=20
wrote:

> Hi guys, this is my first note to the list so I'm going to try and get=20
> some background information to start on this task.
>
> After talking with Bill, the author of gkrellm, I need to find out if=20
> ALSA supports 'callbacks' (a new concept in c++ to me).
>
> quoted from our email:
> ----------
> A while back I looked at ALSA 0.9 support for gkrellmss but there was n=
o
> callback mechanism as there was in ALSA 0.5. Maybe this has changed and
> I'll look again (let me know if you have any info on this), but short o=
f
> that, it takes a sound server that provides such callbacks. Currently
> that's ESD, but I'll probably be adding Jack support fairly soon.
> ----------
>
>
> other then the above, and taking a close look at the original source to=
=20
> the gkrellm-sound plugin, could anybody offer some advice on my project=
?
>
> thanks in advance,
> --Nathan


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
