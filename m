From: =?iso-8859-1?Q?St=E9phane_Boulanger?= <stephane.boulanger@fh-bonn-rhein-sieg.de>
Subject: Opening a device 2 times, loopback interface, ...
Date: Mon, 5 May 2003 10:19:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <CBEIKLKHDDAOGEKMPCGEMEABCAAA.stephane.boulanger@fh-bonn-rhein-sieg.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Dear List,

we=B4re currently developing an end-to-end delay measurement tool, that s=
hould
not only measure the network delay, but also the time the application
(audiostreaming (rat, for example)) needs to calculate the used algorithm=
s
(GSM, PCM, whatever). To realize the choosen program design, we need to
access the soundcard device form two different applications (streaming
application and the measurement tool) at the same time. More exactly:

- When audiodata is inputted, not only the streaming application should b=
e
able to access it, but also our measurement tool (at the same time
obviously).

- When audiodata is send to the sounddriver (repectively the soundcard), =
the
measurement tool, should be able to read it (maybe in the form of a copie=
d
datastream send to the measurement tool).


While browing the ALSA documentation, I found some interesting parts abou=
t
the loopback interface, that might help us. But is it still contained in =
the
0.9 version of ALSA? Moreover, would the loopback interface satisfy our
needs?

I also found some interesting information about JACK, but using JACK woul=
d
require to adopt the streaming application to the JACK interfaces.

In your opinion, what would be the best way to realise the system?

Thanks a lot!

St=E9phane

(Sorry, if you get this 2 times)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
