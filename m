From: tom burkart <alsa@aussec.com>
Subject: Re: 1.0.0pre2 - ymfpci
Date: Tue, 25 Nov 2003 11:35:25 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1069720525.3fc2a3cd84733@www.aussec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ1069720525c90cced4dc774d236d3c398c204355b2"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from r2d2.aussec.com (r2d2.aussec.com [202.7.95.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA01429
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2003 01:35:36 +0100
Received: from localhost (r2d2.aussec.com [192.168.0.1])
	by r2d2.aussec.com (8.12.10/8.12.10) with ESMTP id hAP0ZPn8020787
	for <alsa-devel@alsa-project.org>; Tue, 25 Nov 2003 11:35:26 +1100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This message is in MIME format.

---MOQ1069720525c90cced4dc774d236d3c398c204355b2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Quoting Takashi Iwai <tiwai@suse.de>:


> i thought you got the silent output, but now you get a scraching
> output?
Ok, I must have just woken up...  The scratchiness of the sound are the louder
parts of the music (so it appears anyway).  So I am postulating that for some
reason the lower 8 bits do not make it to the chip/output.  This is a guess, but
who knows, maybe there is some truth in it...

> anyway, please show again the register dump via proc file, and
> hw_params in /proc/asound/card0/pcm0p/sub0.  both files should be
> checked during playback.
Attached.

tom.




-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/

---MOQ1069720525c90cced4dc774d236d3c398c204355b2
Content-Type: application/x-tar-gz; name="ymfpci.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ymfpci.tgz"

H4sIAKugwj8AA+2ZTY/bNhCG98xfIaCX9tCGQ1Jfvm0Tt1h06wS7aYucDJqidoXKH5DkNO6v75D6
GDso4ENjb4HwBRaeGT0UZQ9fmfIe1uXOVK9uLinOFU/jGF9RifCvoFSf97rhaZrwWOCB5IYD8CS+
ieKLXtWgfdvpJopuuu36DGeb9hoXdF0d+v4//7Xc6UavL/IOOWDbx37/S/+lSof+Q6pSQF5yjv3n
l7iYz/WV918bY9t2Fj38sbxbvJ8/3M9vf5+/YeW2WetuFj1Csryfs3a/mirv3zDzrDcbW+MwwRrd
2VmkFPY4+ta/vILv2M421bZYttXfeBC4UGy1L0vbjJVEZop1lflz2VVrj6DY28fH6LOZXel4Opcf
TenzfrJodegsMornyVG5dbOxl/6Y/7ca/F9tyu3F5jjnfyHjyf8xT939P41l8P81ZHRTzCLOCvux
MtZF6PWjpGusXs+id/e3H368ff0Lq5D+8OtP717fsY12zh0SHNXn0/DoG85Mrd3NxZ/0OO6Jdmm2
+w16XYrjov6oqxqLEFx7eQ3+32Gb63prLjLHOf/jDoD8L5z/RQIq+P8aSlRw2deswf9ogm5/qeV9
dv/Pgfzv6iCkTIL/ryHXePzWfvhtsbhb/My6pnp6wm36uCtP8hRyEOoH1znI0yxhHQ5Z7yKvCZF5
4hAhJGQpbiZqfYgmxG/2/bf6VON9vlzrTz0Ty4Sz752Yexbtmmk0yAxS3NLr3a4eD/hynkHGw93r
v2n0/0s+/wtXG/2fcP/8D2H/fxX1bl6utwX6ffF2MZ8e3Tu7Q5uxtrYWj1ebI9O6BNgn9zyv6+rJ
Z+5j7Jbdc2Pb521d9KXt7qTibwRtVduNsScHuOJTffzNAEsrfDwodHNwaSpTBZkI25Uvq8H//cuF
5jjjf8EV+V+m3H//8+D/q2h4fGeuEehw7IYL1fCLHHdJ5us+NFMInEJFIbGAbCZ8KDiFikJkM3f6
IaVzSzq37M+tXEjnlj1rmPvPwlRVdB2KWEXnjYmNkS1LzsvSJUjHqDGlEQmOAJMNCY4RCSYOSoar
H0Eak9LnmNIVpXRFKbEZsrIsS/fnUnWaZqcpjcvpneQ0R37K58Rr4vXpHPp0jDYn6YrGrWieFb2X
Fc1hiDXEGmINsQWxBbEFsQWxllhLrCXWElsSWxJbEltOLLj1jh2ULuxZcGHP+iqxtNoBiKXVDkCs
IFYoComllQ600kESSysdJLH9SgfrwskVMKx0HzoWPEsrHWLPQuZC1+vEjgeMz6T1mVvpLiv7TPlM
OfKl71BBQUFBQUFBQUFBQV9K/wAvwdqLACgAAA==

---MOQ1069720525c90cced4dc774d236d3c398c204355b2--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
