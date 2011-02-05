From: Nowardev-Team <nowardev@gmail.com>
Subject: ALC861-VD bad recording issue
Date: Sat, 5 Feb 2011 11:25:26 +0100
Message-ID: <AANLkTinc-P-eUF9F6gtB1u6u-PYmrr9R0PJ5q2gppB14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DD71E24403
	for <alsa-devel@alsa-project.org>; Sat,  5 Feb 2011 11:25:30 +0100 (CET)
Received: by eyg24 with SMTP id 24so1561817eyg.38
	for <alsa-devel@alsa-project.org>; Sat, 05 Feb 2011 02:25:27 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is the output of the alsa script to ge information about my system and
the driver

http://www.alsa-project.org/db/?f=9871b38d99bdd4cc91e398b60eb31361eb305395

<http://www.alsa-project.org/db/?f=9871b38d99bdd4cc91e398b60eb31361eb305395>the
issue :

when i record with mic i get always a bad recording with some tic tic tic
tic , does not matter if i use low volume for the mic i can hear them
anyway...

if i use louder volume i can hear them ...

i tried with

arecord --quiet --file-type wav --rate=44100 -D plughw:Intel  test.wav

with this there is less rumors

when i play with

arecord --quiet --file-type wav --rate=44100  test.wav

i got a lots of problems ... alsa (snd_pcm_recover) underrun occurred

the strange thing is that on kubuntu 8.04 it was workin better ...  that was
my screenshot of alsamixer in the terminal

http://nowardev.files.wordpress.com/2009/11/alsamixer.png

now to get the " mic volume controller" i have to use

options snd-hda-intel model=lenovo

tried with all these lenovo is the only i can use

ALC861VD/660VD
==============
3stack 3-jack
3stack-dig 3-jack with SPDIF OUT
6stack-dig 6-jack with SPDIF OUT
3stack-660 3-jack (for ALC660VD)
3stack-660-digout 3-jack with SPDIF OUT (for ALC660VD)
lenovo Lenovo 3000 C200
dallas Dallas laptops
hp HP TX1000
asus-v1s ASUS V1Sn
auto auto-config reading BIOS (default)

but i get ...  a lots of "controllers"
like you can see here

http://i0.simplest-image-hosting.net/168bf183b2abe8bc9188aacc163dd507/alsamixerlenovo.jpeg

it seems that capture is the controller that  can increase the mic volume
... :S

i have tried every damned combinations of volumes but i get a lots of rumors
always
