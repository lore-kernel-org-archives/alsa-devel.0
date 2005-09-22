From: Manuel Jander <manuel.jander@gmail.com>
Subject: Terratec Aureon 5.1 MKII slow
Date: Thu, 22 Sep 2005 18:17:44 +0200
Message-ID: <21ed1c3705092209171817de22@mail.gmail.com>
Reply-To: Manuel Jander <manuel.jander@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3467_9244076.1127405864539"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.192])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B736012A
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 18:17:45 +0200 (MEST)
Received: by zproxy.gmail.com with SMTP id 4so283616nzn
        for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 09:17:44 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

------=_Part_3467_9244076.1127405864539
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I have been experimenting with 5.1 USB devices. I'm using them on a Linksys
NSLU2. Some interfaces are reasonable
fast, some are extremely slow due to software sample rate conversion.
Now I'm using a Aureon 5.1 MKII. AFAIK it does hardware samplerate
conversion, but its significantly slower than another "GIGAPort AG"
I have around here.

Can anyone (maybe the driver author) tell me why is this adapter so slow ?
Could it be possible to make it faster tweaking the driver perhaps ?
Why is the maximum buffer so small ? It is just so small, so I'm forced to
add some bigger buffering by my self, creating even more overhead :(
I would have expected that on a USB device the PCM buffer could be arbitrar=
y
large, so why is it so small ?

Thanks you very much for any advice.

Best Regards
Manuel Jander

------=_Part_3467_9244076.1127405864539
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
<br>
I have been experimenting with 5.1 USB devices. I'm using them on a Linksys=
 NSLU2. Some interfaces are reasonable<br>
fast, some are extremely slow due to software sample rate conversion.<br>
Now I'm using a Aureon 5.1 MKII. AFAIK it does hardware samplerate
conversion, but its significantly slower than another &quot;GIGAPort AG&quo=
t;<br>
I have around here.<br>
<br>
Can anyone (maybe the driver author) tell me why is this adapter so
slow ? Could it be possible to make it faster tweaking the driver
perhaps ?<br>
Why is the maximum buffer so small ? It is just so small, so I'm forced
to add some bigger buffering by my self, creating even more overhead :(<br>
I would have expected that on a USB device the PCM buffer could be arbitrar=
y large, so why is it so small ?<br>
<br>
Thanks you very much for any advice.<br>
<br>
Best Regards<br>
Manuel Jander<br>
<br>

------=_Part_3467_9244076.1127405864539--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
