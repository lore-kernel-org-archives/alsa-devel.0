From: Barry Scott <barry.scott@onelan.co.uk>
Subject: Re: ALC260 no sound output on Kernel 2.6.17.1
Date: Fri, 23 Jun 2006 16:30:27 +0100
Message-ID: <449C0913.20504@onelan.co.uk>
References: <449BE867.1070500@onelan.co.uk> <s5hd5d09cy5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-fallback-93.mail.demon.net
	(anchor-fallback-93.mail.demon.net [194.217.242.93])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5D78411F
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Jul 2006 00:53:41 +0200 (MEST)
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:3819 "EHLO
	anchor-post-36.mail.demon.net") by anchor-fallback-93.mail.demon.net
	with ESMTP id S1880961AbWFWPbk (ORCPT
	<rfc822;alsa-devel@alsa-project.org>);
	Fri, 23 Jun 2006 16:31:40 +0100
In-Reply-To: <s5hd5d09cy5.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Fri, 23 Jun 2006 14:11:03 +0100,
> Barry Scott wrote:
>   
>> I an running FC5's 2.6.17.1 with one extra patch to fix a boot problem 
>> with MMCONFIG.
>> alsamixer v1.0.11rc2 says:
>>  Card: HDA Intel
>>  Chip: Realtek ALC260
>>
>> lspci says:
>>
>> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High 
>> Definition Audio Controller (rev 01)
>>         Subsystem: Hewlett-Packard Company Unknown device 3012
>>         Flags: bus master, fast devsel, latency 0, IRQ 225
>>         Memory at e04c0000 (64-bit, non-prefetchable) [size=16K]
>>         Capabilities: [50] Power Management version 2
>>         Capabilities: [60] Message Signalled Interrupts: 64bit+ 
>> Queue=0/0 Enable-
>>         Capabilities: [70] Express Unknown type IRQ 0
>>         Capabilities: [100] Virtual Channel
>>         Capabilities: [130] Unknown (5)
>>
>> I cannot get any sound output.
>> The last version that I know to work is 2.6.13.
>> I was told that 2.6.17 should have fixed the regression, but it has not.
>>
>> How can I help get this fixed? I'm happy to patch and build kernels modules
>> and test.
>>     
>
> This should have been fixed in 1.0.12rc1.
>   
Its the user land code that has the bug not the kernel drivers then?

Barry



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
