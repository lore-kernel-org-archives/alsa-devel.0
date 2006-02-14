From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: snd_pcm_lib_preallocate_pages_for_all etc
Date: Tue, 14 Feb 2006 00:10:06 +0000
Message-ID: <1139875806.9759.32.camel__9652.02773591063$1139875883$gmane$org@localhost.localdomain>
References: <1139875452.9759.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 0B4DF1B1
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2006 01:10:09 +0100 (MET)
In-Reply-To: <1139875452.9759.29.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: linux-sh <linuxsh-dev@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-02-14 at 00:04 +0000, Adrian McMenamin wrote:
> To what extent, if any, can I rely on this function allocating real DMA
> buffers on my architecture (SH4)?
> 
I suppose I should rephrase this as:

(For ALSA developers) - am I right in thinking that
snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV, 0,
0x40*0x400, 0x40*0x400);

will get dma_alloc_coherent to do the heavy lifing?

And 

(For SH) - is dma_alloc_coherent fully working for the Dreamcast?



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
