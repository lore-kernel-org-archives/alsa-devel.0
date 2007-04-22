From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] PnP: Protocol for Media
 Vision	Jazz16	sound cards
Date: Sun, 22 Apr 2007 18:27:44 +0200
Message-ID: <462B8D00.8020305@gmail.com>
References: <20070412195523.GC5324@sygehus.dk> <4628F7FD.7000808@gmail.com>
	<20070420200007.GD3192@sygehus.dk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040903080801010604030707"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C13A247D1
	for <alsa-devel@alsa-project.org>;
	Sun, 22 Apr 2007 18:29:56 +0200 (CEST)
In-Reply-To: <20070420200007.GD3192@sygehus.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rask Ingemann Lambertsen <rask@sygehus.dk>
Cc: Adam Belay <ambx1@neo.rr.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040903080801010604030707
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 04/20/2007 10:00 PM, Rask Ingemann Lambertsen wrote:

> On Fri, Apr 20, 2007 at 07:27:25PM +0200, Rene Herman wrote:

>> Just got around to giving this a spin again and unfortunately the preffered 
>> options code isn't working for me:

>    Do you have a PCI device like this one? /sbin/lspci -v:
> 
> 00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 01)
>         Flags: medium devsel, IRQ 9

Mmm, yes, I do. Was on an Intel 430VX chipset with a PIIX3 last time and on 
a 430TX with the PIIX4 this time.

> I don't know who to blame, but I know of no way of moving that device off
> of IRQ 9.

Indeed; it seems to be a well-known problem.

The Intel 430TX and 440BX (which also uses the PIIX4 if I'm not mistaken) 
were hugely popular chipsets in the later generation of boards that still 
had ISA slots and given that noone will deperately want the MPU-401 IRQ 
assigned; how would you feel about the attached? Just adds the preffered 
options minus the MPU IRQ as the first acceptable. Works for me...

I ran the driver through a complete test again. Playback, capture (from 
line, CD and mic), the OPL3 synth and MPU-401 out- and input (both with and 
without the MPU-401 IRQ) and all work fine. Feel free to add my signed-off 
to the ALSA part.

As to the PnP part; other than that IRQ9 thing everything also working fine 
and if you think the attached is ugly; I don't much care. I still have the 
possible objection with the BIOS maybe needing to know about the card anyway 
so it can route the IRQ to ISA (and the slight discomfort about Jazz16 code 
in drivers/pnp). But next iteration can be final.

If Adam still isn't commenting by then, let's just feed it through Andrew 
Morton and LKML.

Rene.


--------------040903080801010604030707
Content-Type: text/plain;
 name="jazz16pnp-irq9.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="jazz16pnp-irq9.diff"

commit ff9c54ec792041f6f7f45d5abceb5af47a71a2f7
Author: Rene Herman <rene.herman@gmail.com>
Date:   Sat Apr 21 09:07:44 2007 +0200

    IRQ 9 is unavailable on PIIX4 boards -- the MPU-401 UART can
    do without an IRQ as well...

diff --git a/drivers/pnp/jazz16pnp.c b/drivers/pnp/jazz16pnp.c
index b71381b..020b6bb 100644
--- a/drivers/pnp/jazz16pnp.c
+++ b/drivers/pnp/jazz16pnp.c
@@ -233,6 +233,11 @@ static int __init jazz16pnp_add_sb(void)
 				   jazz16pnp_pref_dmas, 1))
 		goto out_no_sboption;
 	if (!jazz16pnp_easy_option(sbdev, PNP_RES_PRIORITY_ACCEPTABLE,
+				   jazz16pnp_pref_ports, 3,
+				   jazz16pnp_pref_irqs, 1,
+				   jazz16pnp_pref_dmas, 1))
+		goto out_no_sboption;
+	if (!jazz16pnp_easy_option(sbdev, PNP_RES_PRIORITY_ACCEPTABLE,
 				   jazz16pnp_ports, 3,
 				   jazz16pnp_irqs, 2,
 				   jazz16pnp_dmas, 1))

--------------040903080801010604030707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040903080801010604030707--
