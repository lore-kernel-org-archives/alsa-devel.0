From: Nikhil Deo <nikhil_deo@usa.net>
Subject: Configuring the mixer
Date: Thu, 22 Apr 2004 17:38:04 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <017iDVVMe5392S06.1082669884@cmsweb06.cms.usa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ok. This is my first attempt at configuring the mixer to get something do=
ne.
My two problems are: It is to be done on QNX and nobody seems to be liste=
ning
on the QNX ngs. Since the concepts seem to be the same, I am hoping someo=
ne
here would be able to point me in the right direction. =


What I want to do:

I need to capture input from the mic AND the line in. Then I need to outp=
ut
the mic input on the Right-LineOut and leftLineIn on leftLineOut. (right =
line
in can be ignored)

I have been playing with the samples on the qnx site and was able to do t=
he
follwing:

1. Play a wav file on the line-out
2. running the code for wave record =



in 1, I understood the concept of mixer group, found out that the best gr=
oup
for me was the PCM-Playback and then could modify the mute bits to mute t=
he
left and right channels simultaneously.  The JOINT_MUTE in caps was set a=
nd so
I believe I cannot mute the left and right (front) separately ( I tried
changing it, could change the bit in caps but still could not mute the
channels separately)

in 2, my mixer group was input gain and although it seemed to be recordin=
g
something, I could not figure out what it was. How do I make it take the =
input
from  mic in only? =


So I would really appreciate if anyone can give me a brief strategy on ho=
w to
proceed. =


I might ask more questions and will be glad to clarify anything that is n=
ot
clear in this post. =



Thanks a lot for your time. I am beginning to creep into frustration mode=
=2E
Answers need not be qnx specific, I have a feeling that I will be able to=

apply the logic. Also, pointers to any documentation on the web for a beg=
inner
like me are also welcome. =







-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
