From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: intel8x0 on a GA-K8VT800 Pro motherboard
Date: Tue, 18 Jan 2005 18:43:36 -0500
Message-ID: <1106091816.30792.4.camel@krustophenia.net>
References: <Pine.LNX.4.61.0501181636350.5130@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0501181636350.5130@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nicolas Pitre <nico@cam.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-01-18 at 16:57 -0500, Nicolas Pitre wrote:
> I have a Giga-byte GA-K8VT800 Pro Motherboard which has:
> 
> 00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 03)
> 	Subsystem: Giga-byte Technology: Unknown device af12
> 	Flags: fast devsel, IRQ 209
> 	Memory at f20c0000 (64-bit, non-prefetchable) [size=16K]
> 	Capabilities: [50] Power Management version 2
> 	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
> 	Capabilities: [70] Express Unknown type IRQ 0
> 	Capabilities: [100] Virtual Channel
> 	Capabilities: [130] Unknown (5)
> 
> The PCI ID for it is:
> 
> 00:1b.0 Class 0403: 8086:2668 (rev 03)
> 
> Looking at the intel8x0 driver the nearest entry I could find is:
> 

You want the azx driver not the intel8x0 driver.

Lee



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
