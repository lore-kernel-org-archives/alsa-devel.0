From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Scatter Gather
Date: Tue, 02 Mar 2004 11:16:33 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040302111633.pochini@shiny.it>
References: <1078200582.1446.21.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078200582.1446.21.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Manuel Jander <manuel.jander@mat.utfsm.cl>
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 02-Mar-2004 Manuel Jander wrote:

>> Yes.  Every driver using SG must do this.  Look into bt87x.c or
>> via82xx.c for examples.
> 
> Well, i guess in that case the period size loses any relevance in
> terms of efficiency.

Efficiency about what ?  If the hardware can be programmed to use
any period size, then the application is free to choose the size
it prefers. It's not a bad thing.  NB: the interrupt should be
generated at the end of the period, not at the end of each block,
eg. when it crosses the page boundary.


> Is there any gain if DMA chunks and period sizes are
> related in any way ?

No, unless the hardware benefits from it.


--
Giuliano.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
