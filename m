From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: au88x0 modem
Date: Wed, 14 Sep 2005 23:56:08 +0300
Message-ID: <20050914205608.GD14657@sashak.softier1.local>
References: <431E3771.8090303@netvigator.com>
 <20050907064449.GA8391@titan.lahn.de> <4321B5A4.5090803@netvigator.com>
 <20050911124530.GA16795@titan.lahn.de> <4325AEA3.1090602@netvigator.com>
 <20050913000909.GB19713@tecr> <20050913085552.GA2655@titan.lahn.de>
 <20050913173529.GD31269@sashak.softier1.local>
 <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_6ATekkuepFXOabRUw7M/3g)"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <4327DA14.3040205@netvigator.com>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Raymond <rayau@netvigator.com>, Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary_(ID_6ATekkuepFXOabRUw7M/3g)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline

On 16:06 Wed 14 Sep     , Raymond wrote:
> 
> #define VORTEX_CODEC_WRITE	0x00800000
> #define VORTEX_CODEC_ADDSHIFT 	16
> 
> (0x80* 1) << VORTEX_CODEC_ADDSHIFT)  is equal to  VORTEX_CODEC_WRITE

Oh, yes. It was bad approach. Let's look similar scheme with vi82xx
(via82xx.c, via82xx_modem.c):

	/* AC'97 */
	#define VIA_REG_AC97                    0x80    /* dword */
	#define   VIA_REG_AC97_CODEC_ID_MASK    (3<<30)
	#define   VIA_REG_AC97_CODEC_ID_SHIFT   30
	#define   VIA_REG_AC97_CODEC_ID_PRIMARY 0x00
	#define   VIA_REG_AC97_CODEC_ID_SECONDARY 0x01
	#define   VIA_REG_AC97_SECONDARY_VALID  (1<<27)
	#define   VIA_REG_AC97_PRIMARY_VALID    (1<<25)
	#define   VIA_REG_AC97_BUSY             (1<<24)
	#define   VIA_REG_AC97_READ             (1<<23)
	#define   VIA_REG_AC97_CMD_SHIFT        16
	#define   VIA_REG_AC97_CMD_MASK         0x7e
	#define   VIA_REG_AC97_DATA_SHIFT       0
	#define   VIA_REG_AC97_DATA_MASK        0xffff

Codec id is addressed by bits 30,31. Of course this should not be same
with au8810, but let's check. The patch is attached.

Philipp, you could play with VORTEX_CODEC_ID_SHIFT value (au88x0,h) in
range 24-31.

> May be au8810 use different set of MMIO to read/write and report
> status of the audio codec and modem codec ?

It is possible of course but we cannot know which one in easy way
(without reverse engineering of win drivers).

> au8810.h
> 
> #define VORTEX_MODEM_CTRL	0x291ac

I don't understand meaning of this, but there is set of similar ones
(CODEC_CTRL) and it is used for initializations.

BTW it is very possible that we should change initialization procedure
(and probably use MODEM_CTRL somehow), but again, it is hard to know
(without reverse engineering).

> Make sure you have a BACKUP of all your data before you peform testing
> on the modem.

Dear testers, it is good idea.

Sasha.

--Boundary_(ID_6ATekkuepFXOabRUw7M/3g)
Content-type: text/plain; NAME=2codec_read-2.patch; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=2codec_read-2.patch

diff -rpu au88x0_orig/au88x0.h au88x0/au88x0.h
--- au88x0_orig/au88x0.h	2005-09-14 20:52:57.000000000 +0300
+++ au88x0/au88x0.h	2005-09-14 20:54:47.000000000 +0300
@@ -79,6 +79,9 @@
 #define VORTEX_RESOURCE_A3D	0x00000004
 #define VORTEX_RESOURCE_LAST	0x00000005
 
+/* codec io related */
+#define VORTEX_CODEC_ID_SHIFT	30 /* unknown: may be 24-31 (or irrelevat) */
+
 /* Check for SDAC bit in "Extended audio ID" AC97 register */
 //#define VORTEX_IS_QUAD(x) (((x)->codec == NULL) ?  0 : ((x)->codec->ext_id&0x80))
 #define VORTEX_IS_QUAD(x) ((x)->isquad)
diff -rpu au88x0_orig/au88x0_core.c au88x0/au88x0_core.c
--- au88x0_orig/au88x0_core.c	2005-09-13 20:00:50.000000000 +0300
+++ au88x0/au88x0_core.c	2005-09-14 20:51:03.000000000 +0300
@@ -2537,7 +2537,8 @@ vortex_codec_write(ac97_t * codec, unsig
 	hwwrite(card->mmio, VORTEX_CODEC_IO,
 		((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK) |
 		((data << VORTEX_CODEC_DATSHIFT) & VORTEX_CODEC_DATMASK) |
-		VORTEX_CODEC_WRITE);
+		VORTEX_CODEC_WRITE |
+		(codec->num << VORTEX_CODEC_ID_SHIFT) );
 
 	/* Flush Caches. */
 	hwread(card->mmio, VORTEX_CODEC_IO);
@@ -2559,7 +2560,8 @@ static unsigned short vortex_codec_read(
 		}
 	}
 	/* set up read address */
-	read_addr = ((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK);
+	read_addr = ((addr << VORTEX_CODEC_ADDSHIFT) & VORTEX_CODEC_ADDMASK) |
+		(codec->num << VORTEX_CODEC_ID_SHIFT) ;
 	hwwrite(card->mmio, VORTEX_CODEC_IO, read_addr);
 
 	/* wait for address */

--Boundary_(ID_6ATekkuepFXOabRUw7M/3g)--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
