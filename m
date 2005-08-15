From: Chow Raymond <usher_raymond82@yahoo.com>
Subject: Re: Compulab sound device
Date: Mon, 15 Aug 2005 01:39:43 -0700 (PDT)
Message-ID: <20050815083943.89306.qmail@web54607.mail.yahoo.com>
References: <Pine.HPX.4.33n.0508150936140.21757-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0508150936140.21757-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--- Clemens Ladisch <clemens@ladisch.de> wrote:
> An AC'97 codec is always connected to an AC'97
> controller.  It's the
> controller that would be supported (or not) by ALSA.
>=20

Umm..so is the ac97 controller supported by ALSA? I
select that driver during kernel configuration (Sound
-> ALSA -> ALSA Arm Devices). However, when i flash
the kernel into the Compulab Armcore, it could not
detect any sound devices.=20

[root@ARMCore root]$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.4
(Mon May 17 14:31:44 200.
Compiled on Aug 10 2005 for kernel 2.6.7-armcore.

[root@ARMCore root]$ cat /proc/asound/devices
 33:       : timer

There is no digital audio playback/capture. Did I miss
something here? How do I know whether ALSA works on
Compulab's Armcore?=20

Regards,
Raymond


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
