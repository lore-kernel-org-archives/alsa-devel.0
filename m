From: Andrei Boros <andrei@srr.ro>
Subject: snd-isapnp still not compiled in latest cvs
Date: Thu, 13 Mar 2003 13:39:02 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E706DD6.8907ECA2@srr.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


 I think I found out why it doesn't compile the snd-isapnp module

in alsa-driver/Makefile :

ifeq (n,$(CONFIG_ISAPNP_KERNEL))
ifeq (y,$(CONFIG_ISAPNP))
ifeq (y,$(CONFIG_ISA))
SUBDIRS  += support
endif
endif
endif

That should be changed to :
ifdef CONFIG_ISAPNP_KERNEL
else
ifeq (y,$(CONFIG_ISAPNP))
ifeq (y,$(CONFIG_ISA))
SUBDIRS  += support
endif
endif
endif

(just the way Takashi Iwai changed alsa-driver/support/Makefile for the
same purpose)

However, after this, compilation of snd-isapnp is attempted, with the
following errors:

ld  -r -o snd-isapnp.o isapnp.o isapnp_proc.o isapnp_quirks.o
isapnp_proc.o(.bss+0x4): multiple definition of
`isapnp_devices_Rfc7fa7cf'
isapnp.o(.data+0x104): first defined here
isapnp_proc.o(.bss+0x0): multiple definition of `isapnp_cards_R2eb552c2'
isapnp.o(.data+0x100): first defined here
make[1]: *** [snd-isapnp.o] Error 1
make[1]: Leaving directory `/serve/install/alsa-cvs/alsa-driver/support'
make: *** [compile] Error 1

Then, in alsa-driver/support/isapnp_proc.c line 53 I changed to :

extern struct isapnp_card *isapnp_cards;
extern struct isapnp_dev *isapnp_devices;

compilation works. 
Still unresolved symbols with sequencer, but I'll look into it later. 


-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
