From: Zinx Verituse <zinx@magenet.net>
Subject: snd-ens1370 8bit record clicks fix(?)
Date: Tue, 19 Feb 2002 13:51:19 -0600
Message-ID: <20020219195119.GA2725@bliss>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I messed around with the source a bit trying to get rid of
the pops present in the record of 8bit sound on my es1370
card, and came up with this patch which I doubt is right.
(I suspect it should simply subtract 1 when 16bit, and not
when 8bit.. rather than subtracting 2 when it's 32bit, which
by the way the card doesn't seem to support.. I get lots of
16bit values with the (LE) high byte set to 00)

Anyway, here it is :)

-- 
Zinx Verituse

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ens1370-8bit-noclick.diff"

diff -rHU 5 alsa-driver-0.9.0beta11.orig/alsa-kernel/pci/ens1370.c alsa-driver-0.9.0beta11/alsa-kernel/pci/ens1370.c
--- alsa-driver-0.9.0beta11.orig/alsa-kernel/pci/ens1370.c	Thu Feb 14 11:40:33 2002
+++ alsa-driver-0.9.0beta11/alsa-kernel/pci/ens1370.c	Tue Feb 19 13:38:06 2002
@@ -880,11 +880,11 @@
 	spin_lock_irqsave(&ensoniq->reg_lock, flags);
 	ensoniq->ctrl &= ~ES_ADC_EN;
 	outl(ensoniq->ctrl, ES_REG(ensoniq, CONTROL));
 	outl(ES_MEM_PAGEO(ES_PAGE_ADC), ES_REG(ensoniq, MEM_PAGE));
 	outl(runtime->dma_addr, ES_REG(ensoniq, ADC_FRAME));
-	outl((ensoniq->c_dma_size >> 2) - 1, ES_REG(ensoniq, ADC_SIZE));
+	outl((ensoniq->c_dma_size >> 2) - snd_ensoniq_sample_shift[mode], ES_REG(ensoniq, ADC_SIZE));
 	ensoniq->sctrl &= ~(ES_R1_LOOP_SEL | ES_R1_MODEM);
 	ensoniq->sctrl |= ES_R1_INT_EN | ES_R1_MODEO(mode);
 	outl(ensoniq->sctrl, ES_REG(ensoniq, SERIAL));
 	outl((ensoniq->c_period_size >> snd_ensoniq_sample_shift[mode]) - 1, ES_REG(ensoniq, ADC_COUNT));

--X1bOJ3K7DJ5YkBrT--

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
