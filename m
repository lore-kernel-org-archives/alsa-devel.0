From: Mario Loritz <loritz@fh-furtwangen.de>
Subject: Re: config bug with sbawe and --with-isapnp=no
Date: Sat, 24 Jan 2004 15:57:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401241557.21770.loritz@fh-furtwangen.de>
References: <200401221249.07577.loritz@fh-furtwangen.de> <Pine.LNX.4.58.0401231123400.1875@pnote.perex-int.cz> <s5hu12mx4tc.wl@alsa2.suse.de>
Reply-To: loritz@fh-furtwangen.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu12mx4tc.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Freitag, 23. Januar 2004 12:49 schrieb Takashi Iwai:
> i found the bug in adriver.h, which always defines CONFIG_PNP when
> CONFIG_ISAPNP is set.
>
> the attached patches are the fix and clean-up for pnp.
> please give a try.
>
>
> Takashi

After I applied the patches, something strange is happening:
The module option "isapnp=yes/no" is not recognized anymore,
regardless of the configure option "--with-isapnp=yes" or "no".

The driver itself works, even if I compile with pnp. But why? I
cannot tell the driver, that it shouldn't try pnp. Do you think
the driver will still work when a pnp-card is used? I can't check 
this, because my sbawe32 is non-pnp.

When those questions are answered and the module option
"isapnp=yes/no" really isn't needed anymore, then I think the
driver should be changed in the proposed way.

Thanks for the solution so far.
Mario

Some parts of the output of "./configure --with-cards=sbawe,ice1712":
...
checking for directory with kernel source... /lib/modules/2.4.21-166-default/
build
checking for kernel version... 2.4.21-166-default
checking for GCC version... Kernel compiler: gcc 3.3.1 (SuSE Linux) Used 
compiler: gcc (GCC) 3.3.1 (SuSE Linux)
checking for built-in ALSA... "no"
checking for existing ALSA module... "yes"
checking for Red Hat kernel... "auto"
checking for Red Hat kernel... "no"
...
checking for kernel module symbol versions... "yes"
checking for PCI support in kernel... "yes"
checking for SGI/MIPS (HAL2) architecture... "no"
checking for directory to store kernel modules... /lib/
modules/2.4.21-166-default/kernel/sound
checking for verbose printk... on
checking for debug level... none
checking for ISA support in kernel... "yes"
checking for processor type... "unknown"
checking for SMP... "no"
checking for ISA PnP driver in kernel... yes
checking for PnP driver in kernel... no
checking for Kernel ISA-PnP support... "no"
checking for Kernel ISA-PnP module support... "yes"
checking for ISA PnP support... yes
....

Output of "rcalsasound restart"

Shutting down sound driver:                                          done
Starting sound driver: snd-sbawe Warning: ignoring isapnp=0, no such parameter 
in this module
Module snd-sbawe loaded, with warnings
                                                                     done
Starting sound driver: snd-ice1712                                   done




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
