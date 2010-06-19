From: jordan johnston <triplesquarednine@gmail.com>
Subject: Status of the Tascam US-122mkII???
Date: Sat, 19 Jun 2010 13:35:32 -0400
Message-ID: <AANLkTimaehZwC-e1pmbQl-pLNb7gVp2Rt5Ujz4BfduR_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D782924600
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Jun 2010 19:35:33 +0200 (CEST)
Received: by gyd10 with SMTP id 10so1661162gyd.38
	for <alsa-devel@alsa-project.org>; Sat, 19 Jun 2010 10:35:32 -0700 (PDT)
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

hello,

Recently, i have gotten my hands on a Tascam US-122mkII.  i have done
a lot of reading/googling and i can see that the device has been added
to the snd-usb-us122l  and even-cross referenced my own device to make
sure the Id and such were there.
Currently, i am unable to get sound out of the Unit.   it does
however, power up on boot.
I have tried many things to get it working, and i have even gotten
Jack to give me the option of picking this Device, however it shows
errors
and does not work :(

**** I am curious about the status of these drivers??

**** does anyone have this unit working at all?

**** and the steps they used to get it working. ( as much of the info
i have read doesn't seem quite uptodate )

is there possibly firmware for this unit or do i use the -US122L
firmware instead?

for Just a bit of background, I am using Fedora 12 with Planet CCRMA.
however, i do not using the CCRMA kernel, as it doesn't cut it for me.
A: it doesn't support a lot of newer hardware, B: it doesn't use MSI-X
on my machine(shared USB/soundcard) C: It's  bloated... D: no BFS
scheduler.
Instead i am using Zen-kernel  which tends to be a lot more up to
date, and i have gotten much better performance from Zen than any
other
kernel on any distro i have ever used.

now, I am more than willing to provide any information that might
help....  this is what i know so far.

dmesg:

ALSA sound/usb/usx2y/usb_stream.c:603: status=-2
ALSA sound/usb/usx2y/usb_stream.c:603: status=-2
ALSA sound/usb/usx2y/us122l.c:365: us122l_start error -14
snd-usb-us122l: probe of 1-5:1.1 failed with error -22


i have tried googling these messages to no avail. i poked around
through the driver, i've tried some of the trouble-shooting tips
provided by the guy who originally
got the older models to work, removing echi-hcd, or unbinding it,
unplugging it, etc. but nothing seems to be making a difference.
Then my thought was that i need a proper asound.conf or .asoundrc.
because the soundcard seems to be available, when i unbind it and
unplug/plug the unit back in.
 i even tried removing them to see if on reboot, that they might be
reconfigured, but no luck.

if anyone can provide help, that would be greatly appreciated.   I
have a 30-day return, so if i can't figure it out, i will be returning
it
for a FFADO approved/fully-supported device. however that being said,
wouldn't it be nice to still take the opportunity to have this
device better supported or help debug some issues??

while i am not a really good programmer, i think i could be useful, as
i have this device in front of me
and can provide useful information to developers, just let me know
what you need!

Jordan
