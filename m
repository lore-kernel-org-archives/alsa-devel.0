From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: RME 9636 not recognized with 2.6 kernel?
Date: Wed, 16 Jul 2003 14:45:41 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprselqfwfq1sf88@mail.broadpark.no>
References: <oprsejy5hpq1sf88@mail.broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <oprsejy5hpq1sf88@mail.broadpark.no>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> I just installed the 2.6.0 beta kernel to play around a bit, but it see=
ms=20
> my RME 9636 (Hammerfall Lite) isnt recognized. When I do aplay -l, my=20
> nForce2 integrated chip shows up however. I cannot modprobe Alsa kernel=
=20
> modules either (v0.95). Is this a known problem?

I would just like to clarify that I was not able to insert the standalone=
=20
alsa modules. I decided to change the drivers in the kernel tree to be=20
compiled as modules instead of static, and modprobing the snd-rme9652 now=
=20
works. I would prefer static linking of this driver though.

Regards

Arve Knudsen




-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
