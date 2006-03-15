From: "Martin Persson" <xarragon@gmail.com>
Subject: I/O multiplexing using select()
Date: Wed, 15 Mar 2006 02:30:28 +0100
Message-ID: <c0ac6f5f0603141730o4853d13eiaf1506b003339eac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2208_15677748.1142386228184"
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

------=_Part_2208_15677748.1142386228184
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello, I'm tinkering with a simple application to stream sound over a
network socket. My application currently uses select() to handle the networ=
k
I/O, and I'm trying to use the same method for the read/write calls to ALSA=
.
I've used snd_pcm_get_poll_descritors() to nab two socket objects which I
add to the read/write fd_set's examined by the select call. I also open the
pcm devices in nonblocking mode.
The problem is that select() is awakended when only 92 bytes (46 frames) ar=
e
available, resulting only in noise, since those transfers are too small.
I've tried adjusting the period size with the
snd_pcm_sw_params_set_start_treshold(), but I'm not sure if this is the
correct way to do it (doesn't work now, but I need some more tinkering time
before I can rule out 'problem-exists-between-keyboard-and-chair' as a
reason).
Perhaps I should perform fcntl() calls on the acctual socket objects
instead? Basically, I just want to enable larger transfers while maintainin=
g
nonblocking behaviour. Perhaps there is a better way, like, say, only
attempting to write as much data as you know will fit into the buffer?

Any advice or tips would be greatly appreciated.

Martin Persson - xarragon at gmail dot com

------=_Part_2208_15677748.1142386228184
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello, I'm tinkering with a simple application to stream sound over a
network socket. My application currently uses select() to handle the
network I/O, and I'm trying to use the same method for the read/write
calls to ALSA. I've used snd_pcm_get_poll_descritors() to nab two
socket objects which I add to the read/write fd_set's examined by the
select call. I also open the pcm devices in nonblocking mode.<br>
The problem is that select() is awakended when only 92 bytes (46
frames) are available, resulting only in noise, since those transfers
are too small. I've tried adjusting the period size with the
snd_pcm_sw_params_set_start_treshold(), but I'm not sure if this is the
correct way to do it (doesn't work now, but I need some more tinkering
time before I can rule out 'problem-exists-between-keyboard-and-chair'
as a reason).<br>
Perhaps I should perform fcntl() calls on the acctual socket objects
instead? Basically, I just want to enable larger transfers while
maintaining nonblocking behaviour. Perhaps there is a better way, like,
say, only attempting to write as much data as you know will fit into
the buffer?<br clear=3D"all"><br>
Any advice or tips would be greatly appreciated.<br>
<br>Martin Persson - xarragon at gmail dot com<br>


------=_Part_2208_15677748.1142386228184--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
