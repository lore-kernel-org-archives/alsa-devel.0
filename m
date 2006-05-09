From: Saqib bin Sohail <Saqib.Sohail@colorado.edu>
Subject: CS4281 AC 97 format
Date: Tue, 09 May 2006 12:34:47 -0600
Message-ID: <1147199687.4460e0c7aa733@webmail.colorado.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

Hi

I am trying to implement cs4281.c driver in VxWorks, and seem to have it
working reasonably, but I can't understand the format of ADC_BUFFER. (Har=
dware
is not my thing and have never played with a sound card before the past o=
ne
month)

I recorded almost 10 seconds of data (128000 samples at 11025 samples per
second with 8 bit mono) and dumped into a file. (see attached file) the f=
ile
was obviously in hex format and i converted it. Now if I pass that hex fi=
le to
playback, it sort of plays back nicely, but the problem is I am not sure =
how to
interpret the data. I am taking the file and doing the following:

-> i convert the hex into decimal and the data ranges from -128 to 127
-> i load that into matlab y =3D ('c:\song.dat');
-> i divide each sample by 255 so the data ranges from -1 to 1 (approxima=
tely)
-> i use wavwrite(y,11025,8,'c:\song.wav');

I can sort of recognize the song but its so distorted. I am pretty sure t=
hat I
am getting the right data out of the ADC_Buffer when I record but I am un=
able
to understand how to right interpret the data. It would be great if someo=
ne
could reply.

Both hex and int files are available below.

http://jobim.colorado.edu/~sohail/song.dat
http://jobim.colorado.edu/~sohail/song.text



--
Saqib bin Sohail
PhD ECE
University of Colorado at Boulder
Res: (303) 786 0636
http://ucsu.colorado.edu/~sohail/index.html


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job ea=
sier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronim=
o
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
