From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: Oops in cs4281_suspend
Date: Mon, 11 Nov 2002 17:19:14 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0211111716180.1287-100000@mailserver.intern.bfad.de>
References: <20021111143136.GB6862@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021111143136.GB6862@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-15?Q?Jos=E9?= Fonseca <j_r_fonseca@yahoo.co.uk>
Cc: alsa-devel@lists.sourceforge.net, arip@bfad.de
List-Id: alsa-devel@alsa-project.org

> options (also attached), it shows that the problem is in the line:
> 
> 	chip->suspend_regs[i] = snd_cs4281_peekBA0(chip, saved_regs[i]);

Very good report :-)

I think the following patch should solve this problem. But since that
suspend/resume seems to not have been tested at all for that driver, may be
some other things will show up.

Index: alsa-kernel/pci/cs4281.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/cs4281.c,v
retrieving revision 1.29
diff -u -r1.29 cs4281.c
--- alsa-kernel/pci/cs4281.c	21 Oct 2002 18:28:23 -0000	1.29
+++ alsa-kernel/pci/cs4281.c	11 Nov 2002 16:14:53 -0000
@@ -2109,7 +2109,7 @@
 	snd_cs4281_pokeBA0(chip, BA0_HICR, BA0_HICR_CHGM);
 
 	/* remember the status registers */
-	for (i = 0; number_of(saved_regs); i++)
+	for (i = 0; i < number_of(saved_regs); i++)
 		if (saved_regs[i])
 			chip->suspend_regs[i] = snd_cs4281_peekBA0(chip, saved_regs[i]);
 
@@ -2153,7 +2153,7 @@
 	snd_cs4281_chip_init(chip, 0);
 
 	/* restore the status registers */
-	for (i = 0; number_of(saved_regs); i++)
+	for (i = 0; i < number_of(saved_regs); i++)
 		if (saved_regs[i])
 			snd_cs4281_pokeBA0(chip, saved_regs[i], chip->suspend_regs[i]);
 


Best regards,
--
Tomasz Motylewski
BFAD GmbH & Co. KG



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
