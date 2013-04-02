From: Israel Alejandro Arriaga Trejo
 <israel.alejandro.arriaga.trejo@outlook.com>
Subject: Audio capture on embedded system (via USB port)
Date: Tue, 2 Apr 2013 15:47:33 -0600
Message-ID: <BLU150-W51D42B9941715DD322B6328FDF0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s14.blu0.hotmail.com (blu0-omc3-s14.blu0.hotmail.com
 [65.55.116.89]) by alsa0.perex.cz (Postfix) with ESMTP id E876126525F
 for <alsa-devel@alsa-project.org>; Tue,  2 Apr 2013 23:47:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,
 =

I am writing to kindly ask for assistance with ALSA on an embedded platform=
, in particular to record audio via a USB headset. The embedded platform I =
am currently using has analog inputs and outputs for audio (mic and headpho=
ne). So far I have been able to play and capture audio using the analog aud=
io inputs/outputs with the commands aplay and arecord respectively from ALS=
A without any problems. However this is not the case when I am trying to us=
e a USB headset via the USB port, at least while trying to record audio (pl=
aying audio is not a problem, it works perfectly fine for different rates a=
nd formats and the devices are recognized when I type aplay =96l or arecord=
 -l).  However, when I try to capture audio, using the ALSA command line ar=
ecord as in:
 =

$ arecord =96d 10 =96r 16000 =96f S16_LE =96t wav  =96Dhw:1,0  test.wav
 =

even though the following message appears:
 =

$ Recording WAVE  =91test.wav=92 : Signed 16 bit Little Endian, Rate 16000 =
Hz, Mono
 =

the application seems =93to freeze=94.  In fact, the recording does not sto=
p in the indicated 10 seconds, instead it continues =93working=94 for a lon=
g period of time and creates the file test.wav which after is played it con=
tains fragments of what actually was recorded via the microphone nonetheles=
s, its content is unintelligible. In some cases the following error also ap=
pears:
 =

$ arecord: pcm_read:1617: read error: Input/Output error  =

 =

As mentioned previously this behavior is only observed during capture mode =
(while attempting to record using the microphone) since the playback mode u=
sing the USB headphone works properly. After browsing for a while I have fo=
und similar situations reported, however I have not been able to find a sol=
ution to my problem.
I would highly appreciate for any hint that could help me to solve this iss=
ue.
 =

Best regards,
 =

Alejandro =

  		 	   		  =
