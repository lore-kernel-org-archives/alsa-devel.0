From: "Mike Gorchak" <lestat@i.com.ua>
Subject: ALSA i8x0 driver - potential problem
Date: Wed, 15 Feb 2006 15:10:35 +0200
Message-ID: <dsv98j$rq2$1@sea.gmane.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hello, All!

I'm writting Intel ICH audio driver for QNX 6.3 and using sometimes latest
ALSA source code as reference and have found the following problem while
using my driver under QNX:

After DMA registers reset, they are still not ready for few nanoseconds but
code in ALSA writes data to the rest of DMA registers directly after reset,
and that is not right, because registers not accepting data during this
moment.

I've found in the module intel8x0.c, function: snd_intel8x0_chip_init()

 /* reset channels */
 for (i = 0; i < chip->bdbars_count; i++)
  iputbyte(chip, ICH_REG_OFF_CR + chip->ichd[i].reg_offset, ICH_RESETREGS);

>>>>>

 /* initialize Buffer Descriptor Lists */
 for (i = 0; i < chip->bdbars_count; i++)
  iputdword(chip, ICH_REG_OFF_BDBAR + chip->ichd[i].reg_offset,
     chip->ichd[i].bdbar_addr);

So in place, marked >>>>> we need to wait while ICH_RESETREGS bit will be
cleared. And only after that write other DMA registers. In my case I've got
NULL BDBAR register content after writing correct value.

And what's interesting I've found this problem only on one machine (fast
enough), thousand others doesn't have such problem.

With best regards, Mike Gorchak.  E-mail: lestat@i.com.ua





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
