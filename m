From: Denis Sbragion <d.sbragion@infotecna.it>
Subject: EWX 24/96 SPDIF input problem with 0.9.4 (and "compiler.h")
Date: Tue, 17 Jun 2003 09:50:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.1.20030617092435.03687a78@pop3.infotecna.lcl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello all,

I found that the SPDIF input on my TerraTec EWX 24/96 no longer works with 
the latest 0.9.4 drivers. I digged into the cs8427.c code and I found that 
this lines in function 'snd_cs8427_create' of version 0.9.3:

...
/* CS8427_REG_RECVERRMASK: unmask the input PLL clock, V, confidence, 
biphase, parity status bits */
/* CS8427_UNLOCK | CS8427_V | CS8427_CONF | CS8427_BIP | CS8427_PAR,
Why setting CS8427_V causes clicks and glitches? */
CS8427_UNLOCK | CS8427_CONF | CS8427_BIP | CS8427_PAR,
...

have been changed into:

...
/* CS8427_REG_RECVERRMASK: unmask the input PLL clock, V, confidence, 
biphase, parity status bits */
/* CS8427_UNLOCK | CS8427_V | CS8427_CONF | CS8427_BIP | CS8427_PAR, * /
0xff, /* set everything */
...

in version 0.9.4, along with some other changes. The "Why setting CS8427_V 
causes clicks and glitches?" comment of version 0.9.3 comes from an old 
patch I sent to Jaroslav many months ago, when I had a similar problem with 
an older 0.9.0something version of the drivers. The fact that this patch 
has been rolled back makes me think that there are some other cards out 
there that need that flag, so I think that a card dependent intialization 
is needed here, but I don't know how to code it. Of course I'm willing to 
help in coding and testing everything that may be needed to make the driver 
run, though I can only test on my own EWX. Relevant environment: RedHat 
Linux 7.2, 2.4.7 kernel.
	I found also that the adriver.h file in version 0.9.4 includes the file 
"linux/compiler.h", which is not present on older 2.4 kernels like my 
2.4.7. Everything seems to compile pretty well even without this include, 
at least on 2.4.7, so may be a conditional inclusion is needed here.
	Finally, many thanks to all the ALSA development team for all its great 
work! Hope this could help improve this great work even more.

Regards,
--
	Denis Sbragion
	InfoTecna
	Tel: +39 0362 805396, Fax: +39 0362 805404
	URL: http://www.infotecna.it



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
