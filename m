From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Oops with snd-ymfpci and ALSA 0.9.3a
Date: Thu, 12 Jun 2003 15:15:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306121514010.1795-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0306122242060.1298-300000@home.aussec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306122242060.1298-300000@home.aussec.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tom burkart <alsa@aussec.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 12 Jun 2003, tom burkart wrote:

> Today, Jaroslav Kysela wrote:
> 
> > In that case, we might compare PCI registers (lspci -s<DEV> -xxx).
> The two dumps are attached: snd-ymfpci for alsa the ymfpci for oss...

Thanks. Could you try this test patch?

Index: ymfpci.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ymfpci/ymfpci.c,v
retrieving revision 1.22
diff -u -r1.22 ymfpci.c
--- ymfpci.c	5 May 2003 14:14:59 -0000	1.22
+++ ymfpci.c	12 Jun 2003 13:14:57 -0000
@@ -168,6 +168,7 @@
 		legacy_ctrl2 |= YMFPCI_LEGACY2_IMOD;
 	}
 	pci_read_config_word(pci, PCIR_DSXG_LEGACY, &old_legacy_ctrl);
+	legacy_ctrl = 0x907f;
 	pci_write_config_word(pci, PCIR_DSXG_LEGACY, legacy_ctrl);
 	pci_write_config_word(pci, PCIR_DSXG_ELEGACY, legacy_ctrl2);
 	if ((err = snd_ymfpci_create(card, pci,

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
