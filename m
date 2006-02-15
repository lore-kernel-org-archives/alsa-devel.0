From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA i8x0 driver - potential problem
Date: Wed, 15 Feb 2006 14:34:15 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0602151431280.9338@tm8103.perex-int.cz>
References: <dsv98j$rq2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <dsv98j$rq2$1@sea.gmane.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mike Gorchak <lestat@i.com.ua>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 15 Feb 2006, Mike Gorchak wrote:

> So in place, marked >>>>> we need to wait while ICH_RESETREGS bit will be
> cleared. And only after that write other DMA registers. In my case I've got
> NULL BDBAR register content after writing correct value.
> 
> And what's interesting I've found this problem only on one machine (fast
> enough), thousand others doesn't have such problem.

Thank you very much for this notice. I tried to fix this problem in ALSA 
CVS (intel8x0.c revision 1.237) according your hint before few minutes.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
