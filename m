From: David Smoot <davidsmoot@gmail.com>
Subject: Question: setting up the hardware for alsa
Date: Fri, 4 Nov 2005 09:49:56 -0600
Message-ID: <b15982770511040749k3ccbaa07gcbd7bac05689a8e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_23523_29970525.1131119396672"
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

------=_Part_23523_29970525.1131119396672
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Greetings, first post to the list and hopefully a simple question:

My company builds Linux based telemetry systems. We are working on an
airborne telemetry platform. The customer has expressed a desire to record
the pilot voice traffic on the data stream with the other data from the
instruments.

We use a stripped down kernel and build pretty much everything by hand. I'm
attempting to set up ALSA so I can pull the audio data from the line in.

Here's what I have done so far:
1. Bought the cheapest supported card I could find on the matrix for testin=
g
(Sound Blaster Live 24Bit, ca0106 driver)

2. Recompiled my kernel to have sound, ALSA, and the appropriate card drive=
r
all built as modules.

3. made scripts to make my device nodes (I'm running the root file system o=
n
a ramdisk so I create my nodes each time I boot plus this lets me run a
minimal kernel and customize it to my environment)
mknod /dev/mixer c 14 0
mknod /dev/mixer1 c 14 16
mknod /dev/mixer2 c 14 32
mknod /dev/mixer3 c 14 48
mknod /dev/dsp c 14 3
mknod /dev/dsp1 c 14 19
mknod /dev/dsp2 c 14 35
mknod /dev/dsp3 c 14 51
mknod /dev/audio c 14 4
mknod /dev/audio1 c 14 20
mknod /dev/audio2 c 14 36
mknod /dev/audio3 c 14 52
mknod /dev/sndstat c 14 6
mknod /dev/audioctl c 14 7

4. Made another script to load my kernel modules
/run/tools/insmod soundcore.ko
/run/tools/insmod snd.ko
/run/tools/insmod snd-timer.ko
/run/tools/insmod snd-page-alloc.ko
/run/tools/insmod snd-pcm.ko
/run/tools/insmod snd-ac97-codec.ko #I inserted this because it is selected
by the ca0106 module
/run/tools/insmod snd-ca0106.ko

5. I copied libasound to my libraries folder.

At this point I at least knew libasound was OK because I could execute some
simple code that listed libasound data types and parameters.

But I can't open any devices and talk to them. I know I am missing some kin=
d
of crucial step in setting up the hw:0,0 device but I can't seem to figure
out the next step. I've read tutorials, googled, but I am stuck. If someone
would point me to the proper documents I would be grateful.

David

------=_Part_23523_29970525.1131119396672
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Greetings, first post to the list and hopefully a simple question:<br>
<br>
My company builds Linux based telemetry systems.&nbsp; We are working
on an airborne telemetry platform.&nbsp; The customer has expressed a
desire to record the pilot voice traffic on the data stream with the
other data from the instruments.<br>
<br>
We use a stripped down kernel and build pretty much everything by
hand.&nbsp; I'm attempting to set up ALSA so I can pull the audio data
from the line in.<br>
<br>
Here's what I have done so far:<br>
1.&nbsp; Bought the cheapest supported card I could find on the matrix for =
testing (Sound Blaster Live 24Bit, ca0106 driver)<br>
<br>
2.&nbsp; Recompiled my kernel to have sound, ALSA, and the appropriate card=
 driver all built as modules. <br>
<br>
3.&nbsp; made scripts to make my device nodes (I'm running the root
file system on a ramdisk so I create my nodes each time I boot plus
this lets me run a minimal kernel and customize it to my environment)<br>
mknod /dev/mixer c 14 0<br>
mknod /dev/mixer1 c 14 16<br>
mknod /dev/mixer2 c 14 32<br>
mknod /dev/mixer3 c 14 48<br>
mknod /dev/dsp c 14 3<br>
mknod /dev/dsp1 c 14 19<br>
mknod /dev/dsp2 c 14 35<br>
mknod /dev/dsp3 c 14 51<br>
mknod /dev/audio c 14 4<br>
mknod /dev/audio1 c 14 20<br>
mknod /dev/audio2 c 14 36<br>
mknod /dev/audio3 c 14 52<br>
mknod /dev/sndstat&nbsp;&nbsp;&nbsp; c 14&nbsp; 6<br>
mknod /dev/audioctl&nbsp;&nbsp; c 14&nbsp; 7 <br>
<br>
4.&nbsp; Made another script to load my kernel modules<br>
/run/tools/insmod soundcore.ko<br>
/run/tools/insmod snd.ko<br>
/run/tools/insmod snd-timer.ko<br>
/run/tools/insmod snd-page-alloc.ko<br>
/run/tools/insmod snd-pcm.ko<br>
/run/tools/insmod snd-ac97-codec.ko #I inserted this because it is selected=
 by the ca0106 module<br>
/run/tools/insmod snd-ca0106.ko<br>
<br>
5.&nbsp; I copied libasound to my libraries folder.<br>
<br>
At this point I at least knew libasound was OK because I could&nbsp;
execute some simple code that listed libasound data types and
parameters.<br>
<br>
But I can't open any devices and talk to them.&nbsp; I know I am
missing some kind of crucial step in setting up the hw:0,0 device but I
can't seem to figure out the next step.&nbsp; I've read tutorials,
googled, but I am stuck.&nbsp; If someone would point me to the proper
documents I would be grateful.<br>
<br>
David<br>
<br>

------=_Part_23523_29970525.1131119396672--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
