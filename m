From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: [ALSA - driver 0001244]: error with firmware wi
Date: Mon, 11 Jul 2005 10:31:10 +0200 (CEST)
Message-ID: <XFMail.20050711103110.pochini@shiny.it>
References: <1582228b1f6357b819be4222b9a2ee32@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 35D7916C
	for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2005 10:31:07 +0200 (MEST)
In-Reply-To: <1582228b1f6357b819be4222b9a2ee32@bugtrack.alsa-project.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: bugtrack@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 09-Jul-2005 bugtrack@alsa-project.org wrote:

> I get this error when loading snd-layla20 card:
>
> ACPI: PCI interrupt 0000:02:0d.0[A] -> GSI 21 (level, low) -> IRQ 177
> ALSA /usr/src/modules/alsa-driver/pci/echoaudio/echoaudio.c:41:
> get_firmware(): Firmware not available (-2)
> Echoaudio Layla20: probe of 0000:02:0d.0 failed with error -2
>
> I compiled an alsa driver for layla20 (I had to patch the alsa-driver t=
ree
> a year ago for linux-2.4.25, and that worked (and still does).

If you built the driver when it was not merged in alsa-driver yet,
it worked because the firmware was compiled in the driver. Now the
firmware is loaded from disk when you load the module. You have to
compile and install alsa-firmware.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
