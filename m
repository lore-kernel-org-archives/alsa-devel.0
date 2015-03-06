From: Alnie <memobook80@comcast.net>
Subject: Re: Issues w/ Creative Labs [SB X-Fi Xtreme Audio]
	CA0110-IBG
Date: Fri, 06 Mar 2015 15:31:32 -0800
Message-ID: <54FA38D4.6090206@comcast.net>
References: <54F52C68.6010504@comcast.net>	<s5hzj7u7grx.wl-tiwai@suse.de>	<54F5614C.9010402@comcast.net>	<s5hwq2y7c8g.wl-tiwai@suse.de>	<54F57D07.9020900@comcast.net>	<54F62CDC.1010607@comcast.net>	<s5hoao97n1j.wl-tiwai@suse.de>	<54F66A0F.1050603@comcast.net>	<s5hk2yx6vld.wl-tiwai@suse.de>	<54F6C9EC.3080100@comcast.net>
 <s5hegp56r78.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from resqmta-po-08v.sys.comcast.net (resqmta-po-08v.sys.comcast.net
 [96.114.154.167])
 by alsa0.perex.cz (Postfix) with ESMTP id 98E582660EA
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2015 00:31:34 +0100 (CET)
In-Reply-To: <s5hegp56r78.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/04/2015 01:35 AM, Takashi Iwai wrote:
> At Wed, 04 Mar 2015 01:01:32 -0800,
> Alnie wrote:
>>
>>
>>
>> On 03/04/2015 12:00 AM, Takashi Iwai wrote:
>>> At Tue, 03 Mar 2015 18:12:31 -0800,
>>> Alnie wrote:
>>>>
>>>>> My suggestion isn't about a compile option but that you add some debug
>>>>> printk() calls manually around some codes.  We need to know the value
>>>>> written and read by azx_write*() and azx_read*() calls.  Especially
>>>>> the value read in pci_azx_read*() is more interesting. You can try to
>>>>> modify sound/pci/hda/hda_intel.c and add a printk() to each
>>>>> pci_azx_read*() function for printing the value to be returned.
>>>>> Beware that this will likely flood many messages, so just try once.
>>>>>
>>>>>
>>>>> Takashi
>>>>>
>>>>
>>>> I can not find any reference to pci_azx_read in hda_intel.c
>>>
>>> You must be using a too old kernel, then.  Please use the latest
>>> kernel for debugging.
>>>
>>>
>>> Takashi
>>>
>>
>> Ok. I now have latest kernel.
>>
>> Here is a small portion...
>>
>> /* PCI register access. */
>> static void pci_azx_writel(u32 value, u32 __iomem *addr)
>> {
>> 	writel(value, addr);
>> }
>>
>> static u32 pci_azx_readl(u32 __iomem *addr)
>> {
>> 	return readl(addr);
>> }
>>
>> Can you show me how I can properly place printk without breaking things
>> and produce relevant messages?
>
> Something like:
>
> static u32 pci_azx_readl(u32 __iomem *addr)
> {
> 	u32 val = readl(addr);
> 	pr_info("XXX readl %p %x\n", addr, val);
> 	return val;
> }
>
> But since there are quite lots of accesses, it might be safer to use
> the ratelimited version.  Use like the following:
> 	pr_info_ratelimited("XXX readl %p %x\n", addr, val);
>
> Also there are variants pci_azx_readw() and _readb().
>
>
> Takashi
>


Ok, I was only able to guess through the code for the read values. If 
you need write information too please show me how.
here are the mods I made...

/* PCI register access. */
static void pci_azx_writel(u32 value, u32 __iomem *addr)
{
	writel(value, addr);
}

static u32 pci_azx_readl(u32 __iomem *addr)
{
     u32 val = readl(addr);
     pr_info_ratelimited("XXX readl %p %x\n", addr, val);
     return val;
}

static void pci_azx_writew(u16 value, u16 __iomem *addr)
{
	writew(value, addr);
}

static u16 pci_azx_readw(u16 __iomem *addr)
{
	u16 val = readw(addr);
	pr_info_ratelimited("XXX readw %p %x\n", addr, val);
	return val;
}

static void pci_azx_writeb(u8 value, u8 __iomem *addr)
{
	writeb(value, addr);
}

static u8 pci_azx_readb(u8 __iomem *addr)
{
	u8 val = readb(addr);
	pr_info_ratelimited("XXX readb %p %x\n", addr, val);
	return val;
}

and i was able to produce this...

dmesg | grep -i read
[    0.764102] tpm_tis 00:05: A TPM error (7) occurred attempting to 
read a pcr value
[    0.769674] Write protecting the kernel read-only data: 12288k
[    1.729952] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.071100] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    2.778875] EXT4-fs (sda5): INFO: recovery required on readonly 
filesystem
[    2.817982] EXT4-fs (sda5): orphan cleanup on readonly fs
[    4.662442] XXX readw ffffc90004f30000 4401
[    4.662466] XXX readl ffffc90004f30008 1
[    4.662468] XXX readb ffffc90004f30008 1
[    4.662609] XXX readw ffffc90004f70000 3300
[    4.662631] XXX readl ffffc90004f70008 0
[    4.662635] XXX readb ffffc90004f70008 0
[    4.663483] XXX readb ffffc90004f30008 0
[    4.663492] XXX readb ffffc90004f70008 0
[    4.663496] XXX readb ffffc90004f70008 0
[    4.664138] XXX readb ffffc90004f30008 0
[    4.664142] XXX readb ffffc90004f30008 0
[    4.664150] XXX readb ffffc90004f70008 1
[    4.665173] XXX readb ffffc90004f30008 1
[    4.665368] XXX readb ffffc90004f70008 1
[    4.665372] XXX readw ffffc90004f7000e 2
[    4.665378] XXX readl ffffc90004f70020 0
[    4.666389] XXX readw ffffc90004f3000e 1
[    4.666394] XXX readl ffffc90004f30020 0
[    4.668203] XXX readw ffffc90004f70068 0
[    4.668209] XXX readw ffffc90004f70068 0
[    4.668213] XXX readw ffffc90004f70068 0
[    4.668216] XXX readw ffffc90004f70068 0
[    4.668221] XXX readw ffffc90004f70068 0
[    4.668226] XXX readw ffffc90004f70068 0
[    4.668412] XXX readl ffffc90004f70020 c0000000
[    4.668420] XXX readl ffffc90004f70008 1
[    4.671683] XXX readl ffffc90004f70020 0
[    4.674569] XXX readl ffffc90004f30064 14f15051
[    4.674608] XXX readl ffffc90004f30064 14f15051
[    4.674651] XXX readl ffffc90004f30064 0
[    5.624194] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    7.297049] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   15.003841] pci_azx_readl: 160 callbacks suppressed
[   15.003845] XXX readl ffffc90004f30024 0
[   15.003911] XXX readl ffffc90004f30024 0
[   16.334821] pci_azx_readb: 12 callbacks suppressed
[   16.334826] XXX readb ffffc90004f30080 0
[   16.334829] XXX readb ffffc90004f30080 0
[   16.334834] XXX readb ffffc90004f30080 1
[   16.334839] XXX readb ffffc90004f30080 0
[   16.334844] XXX readb ffffc90004f30080 0
[   16.334846] XXX readl ffffc90004f30080 40000
[   16.334849] XXX readl ffffc90004f30070 31303000
[   16.334852] XXX readl ffffc90004f30080 140000
[   16.334857] pci_azx_readw: 3599 callbacks suppressed
[   16.334858] XXX readw ffffc90004f30068 2
[   16.334860] XXX readw ffffc90004f30068 2
[   16.334862] XXX readw ffffc90004f30068 0
[   16.334864] XXX readw ffffc90004f30068 1
[   16.334868] XXX readw ffffc90004f30068 1
[   16.334871] XXX readw ffffc90004f30068 1
[   16.334874] XXX readw ffffc90004f30068 1
[   16.334877] XXX readw ffffc90004f30068 1
[   16.334880] XXX readw ffffc90004f30068 1
[   16.334884] XXX readw ffffc90004f30068 1
[   16.334902] XXX readl ffffc90004f30064 0
[   16.334943] XXX readl ffffc90004f30064 0
[   16.334985] XXX readl ffffc90004f30064 11
[   16.340093] XXX readl ffffc90004f30064 0
[   16.340115] XXX readb ffffc90004f30080 1c
[   16.340118] XXX readb ffffc90004f30080 0
[   16.340123] XXX readb ffffc90004f30080 1
[   16.340128] XXX readb ffffc90004f30080 0
[   16.340132] XXX readb ffffc90004f30080 0
[   16.340134] XXX readl ffffc90004f30080 40000
[   20.018443] pci_azx_readl: 148 callbacks suppressed
[   20.018448] XXX readl ffffc90004f30030 15f6582b
[   20.018709] XXX readl ffffc90004f30030 15f6715a
[   20.018716] XXX readl ffffc90004f30030 15f67203
[   20.370026] XXX readl ffffc90004f30030 16770835
[   20.370737] XXX readl ffffc90004f30030 16774b57
[   20.370752] XXX readl ffffc90004f30030 16774cd3
[   20.721866] XXX readl ffffc90004f30030 16f7d0db
[   20.722577] XXX readl ffffc90004f30030 16f813de
[   20.722592] XXX readl ffffc90004f30030 16f81544
[   21.073497] XXX readl ffffc90004f30030 17788616
[   21.447607] pci_azx_readb: 75 callbacks suppressed
[   21.447617] XXX readb ffffc90004f30100 1e
[   21.447624] XXX readb ffffc90004f30100 2
[   21.447629] XXX readb ffffc90004f30100 2
[   21.447633] XXX readb ffffc90004f30100 2
[   21.447637] XXX readb ffffc90004f30100 0
[   21.879992] XXX readb ffffc90004f30100 0
[   21.879998] XXX readb ffffc90004f30100 0
[   21.880032] XXX readb ffffc90004f30100 1
[   21.880039] XXX readb ffffc90004f30100 0
[   21.880043] XXX readb ffffc90004f30100 0
[   21.880051] pci_azx_readw: 855 callbacks suppressed
[   21.880052] XXX readw ffffc90004f30110 bf
[   21.880075] XXX readw ffffc90004f30110 bf
[   25.032271] pci_azx_readl: 896 callbacks suppressed
[   25.032281] XXX readl ffffc90004f30030 1d218b30
[   25.033006] XXX readl ffffc90004f30030 1d21d08e
[   25.033021] XXX readl ffffc90004f30030 1d21d1f9
[   25.393756] XXX readl ffffc90004f30030 1da5db6d
[   25.394488] XXX readl ffffc90004f30030 1da62083
[   25.394503] XXX readl ffffc90004f30030 1da62206
[   25.755381] XXX readl ffffc90004f30030 1e2a394b
[   25.755746] XXX readl ffffc90004f30030 1e2a5bab
[   25.755754] XXX readl ffffc90004f30030 1e2a5c65
[   26.116985] XXX readl ffffc90004f30030 1eae9483
[   29.677529] pci_azx_readb: 11 callbacks suppressed
[   29.677540] XXX readb ffffc90004f30100 1e
[   29.677547] XXX readb ffffc90004f30100 2
[   29.677551] XXX readb ffffc90004f30100 2
[   29.677556] XXX readb ffffc90004f30100 2
[   29.677560] XXX readb ffffc90004f30100 2
[   29.677565] XXX readb ffffc90004f30100 0

-Alnie
