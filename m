From: "mjander " <mjander@embedded.cl>
Subject: Scatter Gather DMA
Date: Wed,  5 Mar 2003 12:09:21 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303051209.AA33751384@embedded.cl>
Reply-To: <mjander@embedded.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from embedded.cl (correo1.ispchile.cl [200.29.13.60])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA08762
	for <alsa-devel@alsa-project.org>; Wed, 5 Mar 2003 16:08:15 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Another question... :)

The Aureal Vortex has Scatter Gather DMA's for each audio channel.
But these SG DMA
support only max 4 pages. Each page can have a programable size of
upto 4 KB.
I was studying the ALSA SG scheme and it doesnt seme to fit into
the aureal vortex
SG buffer scheme, because ALSA, as far as i understood, only
allows pages of the kernel PAGE_SIZE size, and allocates as many
pages (without cound limit ?) until the buffer size is  reached.
But the PAGE_SIZE around 0x400 or 0x800, which is rather small.

On the Aureal vortex soundcard side i have 4 registers for page
base address, and some sort  of config regs to configure each page
size and the next page for each page. I just dont understand how
could i plug this two apparently incompatible things together.

Thank you very much.

Manuel Jander.
.
__________________________________________________
Enviado via NewPlanet WebMail en embedded.cl


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
