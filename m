From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: Sudden ISA DMA problems
Date: Mon, 18 Feb 2002 19:53:30 +0000 (GMT)
Message-ID: <20020218195330.4664.qmail@web13104.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Received: from web13104.mail.yahoo.com (web13104.mail.yahoo.com [216.136.174.149])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id UAA07719
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2002 20:53:37 +0100
In-Reply-To: <Pine.LNX.4.31.0202181411530.505-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 --- Jaroslav Kysela <perex@suse.cz> wrote:
> I verified the contents of pci_allocate_consistent()
> and I agree that it
> should work at least for i386 and alpha
> architectures so I reverted back
> your code.


Hi,

I have ported my driver to use the new
snd_malloc_isa_pages() call ... and my driver is
broken again. The interesting thing is that it does
work *occasionally" and then I can both play music and
upload the firmware. I was wondering if the dma_addr_t
(which is really just a uint32, I think) has to have a
value below a certain threshold before ISA DMA
transfers will work? I am trying to test this theory
now, but I need it to start working again first...

Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
