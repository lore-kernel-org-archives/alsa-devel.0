From: Jonathan Murphy <typetosmurky@yahoo.com.au>
Subject: snd-usb-audio and snd-virmidi problems
Date: Sun, 11 Dec 2005 19:03:22 -0500 (EST)
Message-ID: <20051212000322.98735.qmail@web33012.mail.mud.yahoo.com>
References: <20051211090500.GA11694@procyon.home>
Reply-To: BLFS Support List <blfs-support@linuxfromscratch.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0041362224869381237=="
Return-path: <blfs-support-bounces@linuxfromscratch.org>
In-Reply-To: <20051211090500.GA11694@procyon.home>
List-Unsubscribe: <http://linuxfromscratch.org/mailman/listinfo/blfs-support>,
	<mailto:blfs-support-request@linuxfromscratch.org?subject=unsubscribe>
List-Archive: <http://linuxfromscratch.org/pipermail/blfs-support>
List-Post: <mailto:blfs-support@linuxfromscratch.org>
List-Help: <mailto:blfs-support-request@linuxfromscratch.org?subject=help>
List-Subscribe: <http://linuxfromscratch.org/mailman/listinfo/blfs-support>,
	<mailto:blfs-support-request@linuxfromscratch.org?subject=subscribe>
Sender: blfs-support-bounces@linuxfromscratch.org
Errors-To: blfs-support-bounces@linuxfromscratch.org
To: alsa-devel@lists.sourceforge.net
Cc: blfs-support@linuxfromscratch.org
List-Id: alsa-devel@alsa-project.org

--===============0041362224869381237==
Content-Type: multipart/alternative; boundary="0-1359475874-1134345802=:97566"
Content-Transfer-Encoding: 7bit

--0-1359475874-1134345802=:97566
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

 Thanks for your advice, Sergey, and for the patch. snd-virmidi is loadin=
g properly now. I'm still unable to compile snd-usb-audio. I'm beginning =
to think that I've got something very weird going on with my kernel heade=
rs. I have CONFIG_KMOD=3Dy in my /boot/config, however when I run the als=
a-drivers configure script it can't find kmod.h. Now that I've used Serge=
y's patch platform_device.h is there, and so is everything else. I'm usin=
g the 2.6.12 headers from:
=20
 http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
=20
 The weird thing is that kmod.h is in the /include/linux subdirectories o=
f both the build and source directories, and yet it's not in the /include=
/config/module subdirectory. What exactly is the configure script wanting=
 to do when it says that it's 'checking to modify'?
=20
 checking to modify of kernel linux/kmod.h... "no"
=20
 I'm running the script as root, and I chowned the alsa-drivers directory=
 to root just to make sure that it should be able to do whatever it needs=
. From what I understand of kmod
=20
 http://www.xml.com/ldd/chapter/book/ch11.html
=20
 It pretty much fits the bill of what you'd want in a USB driver, there w=
hen you need it, so I'm guessing that there's probably a dependency there=
. Should I add kmod.h to the ../include/config/module subdirectory or wil=
l that just cause serious confusion?
=20
 Thanks for your time,
=20
 Jonathan.
=20

	=09
---------------------------------
Find your next car at Yahoo! Canada Autos
--0-1359475874-1134345802=:97566
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<div id=3D"RTEContent">&nbsp;Thanks for your advice, Sergey, and for the =
patch. snd-virmidi is loading properly now. I'm still unable to compile s=
nd-usb-audio. I'm beginning to think that I've got something very weird g=
oing on with my kernel headers. I have CONFIG_KMOD=3Dy in my /boot/config=
, however when I run the alsa-drivers configure script it can't find kmod=
.h. Now that I've used Sergey's patch platform_device.h is there, and so =
is everything else. I'm using the 2.6.12 headers from:<br> <br> <a href=3D=
"http://ep09.pld-linux.org/%7Emmazur/linux-libc-headers/">http://ep09.pld=
-linux.org/~mmazur/linux-libc-headers/</a><br> <br> The weird thing is th=
at kmod.h is in the /include/linux subdirectories of both the build and s=
ource directories, and yet it's not in the /include/config/module subdire=
ctory. What exactly is the configure script wanting to do when it says th=
at it's 'checking to modify'?<br> <br> checking to modify of kernel linux=
/kmod.h... "no"<br> <br> I'm running the script as
 root, and I chowned the alsa-drivers directory to root just to make sure=
 that it should be able to do whatever it needs. From what I understand o=
f kmod<br> <br> <a href=3D"http://www.xml.com/ldd/chapter/book/ch11.html"=
>http://www.xml.com/ldd/chapter/book/ch11.html</a><br> <br> It pretty muc=
h fits the bill of what you'd want in a USB driver, there when you need i=
t, so I'm guessing that there's probably a dependency there. Should I add=
 kmod.h to the ../include/config/module subdirectory or will that just ca=
use serious confusion?<br> <br> Thanks for your time,<br> <br> Jonathan.<=
br> </div><p>
		<hr size=3D1>Find your next car at <a href=3D"http://autos.yahoo.ca"><b=
>Yahoo! Canada Autos</b></a>
--0-1359475874-1134345802=:97566--

--===============0041362224869381237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
http://linuxfromscratch.org/mailman/listinfo/blfs-support
FAQ: http://www.linuxfromscratch.org/blfs/faq.html
Unsubscribe: See the above information page
--===============0041362224869381237==--
