From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Scatter Gather DMA
Date: Wed, 5 Mar 2003 16:53:42 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303051652210.1014-100000@pnote.perex-int.cz>
References: <200303051209.AA33751384@embedded.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA09572
	for <alsa-devel@alsa-project.org>; Wed, 5 Mar 2003 16:53:42 +0100
In-Reply-To: <200303051209.AA33751384@embedded.cl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander <mjander@embedded.cl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 5 Mar 2003, mjander wrote:

> Hi,
> 
> Another question... :)
> 
> The Aureal Vortex has Scatter Gather DMA's for each audio channel.
> But these SG DMA
> support only max 4 pages. Each page can have a programable size of
> upto 4 KB.
> I was studying the ALSA SG scheme and it doesnt seme to fit into
> the aureal vortex
> SG buffer scheme, because ALSA, as far as i understood, only
> allows pages of the kernel PAGE_SIZE size, and allocates as many
> pages (without cound limit ?) until the buffer size is  reached.
> But the PAGE_SIZE around 0x400 or 0x800, which is rather small.
> 
> On the Aureal vortex soundcard side i have 4 registers for page
> base address, and some sort  of config regs to configure each page
> size and the next page for each page. I just dont understand how
> could i plug this two apparently incompatible things together.
> 
> Thank you very much.

I don't see a problem here. The PAGE_SIZE is 4kB for i386. Simply
follow the code in the via82xx driver and limit the maximum count of 
periods to 4.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
