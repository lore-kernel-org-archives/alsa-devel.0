From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Delta 410 support broken in CVS ?
Date: Sun, 28 Mar 2004 17:55:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403281755000.3294@pnote.perex-int.cz>
References: <4066F118.10902@t-online.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4066F118.10902@t-online.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Reiner Klenk <pdq808@t-online.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 28 Mar 2004, Reiner Klenk wrote:

> Greetings,
> my Midiman Delta 410 doesn't work with CVS or 1.0.3
> modprobe snd-ice1712 gives an error and the logfile says:
> 
> ../alsa-kernel/i2c/cs8427.c:225: unable to find CS8427 signature 
> (expected 0x71, read 0xff), initialization is not completed

Got it. Please, try this patch:

Index: delta.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ice1712/delta.c,v
retrieving revision 1.15
diff -u -r1.15 delta.c
--- delta.c	5 Mar 2004 09:08:39 -0000	1.15
+++ delta.c	28 Mar 2004 15:43:57 -0000
@@ -90,6 +90,7 @@
 		tmp |= ICE1712_DELTA_1010LT_CCLK | ICE1712_DELTA_1010LT_CS_CS8427;
 		break;
 	case ICE1712_SUBDEVICE_AUDIOPHILE:
+	case ICE1712_SUBDEVICE_DELTA410:
 		tmp |= ICE1712_DELTA_AP_CCLK | ICE1712_DELTA_AP_CS_CODEC;
 		tmp &= ~ICE1712_DELTA_AP_CS_DIGITAL;
 		break;
@@ -112,6 +113,7 @@
 		tmp |= ICE1712_DELTA_1010LT_CS_NONE;
 		break;
 	case ICE1712_SUBDEVICE_AUDIOPHILE:
+	case ICE1712_SUBDEVICE_DELTA410:
 		tmp |= ICE1712_DELTA_AP_CS_DIGITAL;
 		break;
 	case ICE1712_SUBDEVICE_VX442:

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
