From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
Subject: Re: module is not unloaded when probe fails
Date: Tue, 23 Mar 2004 00:11:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405F728F.3090004@gmx.net>
References: <20040322220826.1be9799a.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040322220826.1be9799a.pochini@shiny.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Giuliano Pochini wrote:
> 
> When I try to load a module and it fails (snd-darla20 in this case) the
> module is not unloaded. IIRC it didn't happen some months ago, but I have no
> idea what is the cause because I changed a lot of stuff in the meantime
> (kernel, compiler, modutils...). Is this the expected behaviour ?

Yes, it's by design. If a module sees it can't drive the available
hardware, it *should* stay loaded so you either can
- add new hardware it can drive or
- tell it via /sys/bus/pci/drivers/tulip/new_id that it should drive dome
hardware with previously unknown pci id.


> [Giu@Jay Giu]$ uname -a
> Linux Jay 2.6.3-ben2 #10 SMP Sun Mar 14 21:46:34 CET 2004 ppc unknown

It's a new 2.6 feature.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
