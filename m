From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Broken pipe when starting pcm
Date: Fri, 31 Oct 2003 18:27:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprxw33qopq1sf88@mail.broadpark.no>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

Whenever I turn on xrun detection, setting stop_threshold to buffer size=20
instead of -1, snd_pcm_start refuses to work. The exit message to do with=
=20
broken pipe. I figured it might be caused by an empty buffer, so I fill i=
t=20
with silence before start. snd_pcm_avail_update confirms this (zero frame=
s=20
available), but it makes no difference. This happens with both my cards,=20
nForce2 onboard and RME DIGI9636. If someone could point out the cause of=
=20
this, I'd truly appreciate it. If it matters I am running a development=20
kernel, 2.6.0 test9-mm1.

Thanks

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
