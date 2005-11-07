From: Tehn Yit Chin <tehn.yit.chin@gmail.com>
Subject: behaviour of the trigger operation
Date: Mon, 7 Nov 2005 15:57:00 +1100
Message-ID: <bf04f99c0511062057t599036d5g62582ee1cda7d050@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_21843_4442885.1131339420298"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

------=_Part_21843_4442885.1131339420298
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I am trying to understand how the trigger operation behaves.

The behaviour that I am observing is that when ALSA starts up, it seems to
be going through a few cycles of prepare, trigger_start and trigger_stop
before it starts to streams data through to the codec. Is this normal
behaviour?

On the ear, at the start the stream, this manifest into some corruptions
before it appears to play the normal sound.

Any ideas why ALSA might want to trigger_start and trigger_stop a number of
times at the start?

thanks,
tyc

------=_Part_21843_4442885.1131339420298
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
I am trying to understand how the trigger operation behaves.<br>
<br>
The behaviour that I am observing is that when ALSA starts up, it seems
to be going through a few cycles of prepare, trigger_start and
trigger_stop before it starts to streams data through to the codec. Is
this normal behaviour?<br>
<br>
On the ear, at the start the stream, this manifest into some corruptions be=
fore it appears to play the normal sound.<br>
<br>
Any ideas why ALSA might want to trigger_start and trigger_stop a number of=
 times at the start?<br>
<br>
thanks,<br>
tyc<br>

------=_Part_21843_4442885.1131339420298--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
