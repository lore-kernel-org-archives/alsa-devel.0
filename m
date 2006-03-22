From: Tom Watson <sdc695@yahoo.com>
Subject: Routing of channels, more than one output.
Date: Tue, 21 Mar 2006 17:42:03 -0800 (PST)
Message-ID: <20060322014203.83101.qmail@web60816.mail.yahoo.com>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
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
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I've got a 'problem' that involves playing around with 'asoundrc' files.

What I desire to do is by specifying a sound 'device' have the audio rout=
ed
specially.  If I specify 'mono2' for example, I'd like my mono sound samp=
les
routed to BOTH the left and right speaker.  If I say 'stereo4' I'd like m=
y
stereo channels (sent with 'writei' calls) routed to both the front AND r=
ear
speakers.  While I could write out the samples, it seems much easier to h=
ave a
definition in my 'asoundrd' file to do this, if possible.  If it isn't
possible, I will take another tact.

So, my question, can this be done?  If so, how?  I'm not an expert at
'asoundrd' files.

I'm using an M-Audio Revolution 7.1 card if that makes any difference
(hopefully not).

Thanks.  We now return you to the regularly scheduled bug reports in the
mailing list.


--=20
Tom Watson
tsw@johana.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
