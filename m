From: "OcHe" <oche@mumufarm.com>
Subject: (no subject)
Date: Thu, 4 May 2006 18:37:27 -0700 (PDT)
Message-ID: <1429.61.5.113.68.1146793047.squirrel@mail.mumufarm.com>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all =3D)

I'm working for my final thesis project, it's something about MIDI over
IP, i'm planning to use aseqnet for the demonstration purpose, my main
focus is about performance, how to calculate elapsed time (event data
traveled between Yamaha PSRA to Host A to Host B to Yamaha PSRB) (vice
versa). I'm running Fedora Core 4 (ALSA seems to work great with my
device) and C as the programming language.

Host A - Local LAN - Host B
  |                  |
Yamaha             Yamaha
Keyboard           Keyboard

My questions are:

1. How to calculate elapsed time data traverse from Yamaha to Computer ?
2. How to calculate elapsed time  data traverse from Host A to Host B (i'=
m
just guessing maybe i could use ping to show RTT?? is this the correct
answer?)
3. is there any other processes i should calculate ?
4. What realtime kernel patch should i use?
5. How long (in millisecond / second ??) should the total elapsed time be=
,
to make the realtime playing feasible?

Thanks =3D)



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job ea=
sier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
