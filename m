From: Prince John <princejohnm@yahoo.com>
Subject: How to update Buffer Pointer
Date: Sat, 26 Jul 2003 08:33:23 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030726153323.5482.qmail@web11703.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I have a few queries on buffer pointer updation during
playback operation with DMA transfer. I have gone
through the documents, but some are not very clear.
I have 64KB DMA buffer and 16KB period size. I'm using
runtime->dma_addr as the DMA source (physical
address). Is this right? This address never getting
changed during run time. I get interrupt in 16K
periods. Should I add the 16KB offset to the
runtime->dma_addr for next block of data transmission?
And should it be wrapped around to runtime->dma_addr
after 64KB transfer? I tried some of these, but the
sound gererated is not proper. 
The runtime->status->hw_ptr also seen as a constant
during run time. The pointer call backs are returned
with the number of frames transmitted (offset from the
buffer start address).

Could you please give your suggestions ?

Thanks,
Prince


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
