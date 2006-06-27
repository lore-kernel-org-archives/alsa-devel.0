From: Barry Scott <barry.scott@onelan.co.uk>
Subject: Re: ALC260 no sound output on Kernel 2.6.17.1
Date: Tue, 27 Jun 2006 12:52:55 +0100
Message-ID: <44A11C17.8080604@onelan.co.uk>
References: <449BE867.1070500@onelan.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-33.mail.demon.net (anchor-post-33.mail.demon.net
	[194.217.242.91])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BEE16251
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 13:53:11 +0200 (MEST)
Received: from onelanbroadband.demon.co.uk ([80.177.165.253]
	helo=[192.168.1.23])
	by anchor-post-33.mail.demon.net with esmtp (Exim 4.42)
	id 1FvC7k-0009gj-C2
	for alsa-devel@alsa-project.org; Tue, 27 Jun 2006 11:53:03 +0000
In-Reply-To: <449BE867.1070500@onelan.co.uk>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Barry Scott wrote:
> I an running FC5's 2.6.17.1 with one extra patch to fix a boot problem 
> with MMCONFIG.
> alsamixer v1.0.11rc2 says:
>  Card: HDA Intel
>  Chip: Realtek ALC260
>
> lspci says:
>
> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High 
> Definition Audio Controller (rev 01)
>         Subsystem: Hewlett-Packard Company Unknown device 3012
>         Flags: bus master, fast devsel, latency 0, IRQ 225
>         Memory at e04c0000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [60] Message Signalled Interrupts: 64bit+ 
> Queue=0/0 Enable-
>         Capabilities: [70] Express Unknown type IRQ 0
>         Capabilities: [100] Virtual Channel
>         Capabilities: [130] Unknown (5)
>
> I cannot get any sound output.
> The last version that I know to work is 2.6.13.
> I was told that 2.6.17 should have fixed the regression, but it has not.
>
> How can I help get this fixed? I'm happy to patch and build kernels modules
> and test.
>
> Barry
>   
I have sound now with 1.0.12rc1 under kernel 2.6.17.1.

Barry


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
