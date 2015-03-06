From: Alnie <memobook80@comcast.net>
Subject: Re: Issues w/ Creative Labs [SB X-Fi Xtreme Audio]
	CA0110-IBG
Date: Fri, 06 Mar 2015 14:50:10 -0800
Message-ID: <54FA2F22.8090500@comcast.net>
References: <54F52C68.6010504@comcast.net>	<s5hzj7u7grx.wl-tiwai@suse.de>	<54F5614C.9010402@comcast.net>	<s5hwq2y7c8g.wl-tiwai@suse.de>	<54F57D07.9020900@comcast.net>	<54F62CDC.1010607@comcast.net>	<s5hoao97n1j.wl-tiwai@suse.de>	<54F66A0F.1050603@comcast.net>	<s5hk2yx6vld.wl-tiwai@suse.de>	<54F6C9EC.3080100@comcast.net>
 <s5hegp56r78.wl-tiwai@suse.de> <54FA2C75.3070802@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from resqmta-po-08v.sys.comcast.net (resqmta-po-08v.sys.comcast.net
 [96.114.154.167])
 by alsa0.perex.cz (Postfix) with ESMTP id 410692661B0
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 23:50:12 +0100 (CET)
In-Reply-To: <54FA2C75.3070802@comcast.net>
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

On 03/06/2015 02:38 PM, Alnie wrote:
> On 03/04/2015 01:35 AM, Takashi Iwai wrote:
>> At Wed, 04 Mar 2015 01:01:32 -0800,
>> Alnie wrote:
>>>
>>>
>>>
>>> On 03/04/2015 12:00 AM, Takashi Iwai wrote:
>>>> At Tue, 03 Mar 2015 18:12:31 -0800,
>>>> Alnie wrote:
>>>>>
>>>>>> My suggestion isn't about a compile option but that you add some
>>>>>> debug
>>>>>> printk() calls manually around some codes.  We need to know the value
>>>>>> written and read by azx_write*() and azx_read*() calls.  Especially
>>>>>> the value read in pci_azx_read*() is more interesting. You can try to
>>>>>> modify sound/pci/hda/hda_intel.c and add a printk() to each
>>>>>> pci_azx_read*() function for printing the value to be returned.
>>>>>> Beware that this will likely flood many messages, so just try once.
>>>>>>
>>>>>>
>>>>>> Takashi
>>>>>>
>>>>>
>>>>> I can not find any reference to pci_azx_read in hda_intel.c
>>>>
>>>> You must be using a too old kernel, then.  Please use the latest
>>>> kernel for debugging.
>>>>
>>>>
>>>> Takashi
>>>>
>>>
>>> Ok. I now have latest kernel.
>>>
>>> Here is a small portion...
>>>
>>> /* PCI register access. */
>>> static void pci_azx_writel(u32 value, u32 __iomem *addr)
>>> {
>>>     writel(value, addr);
>>> }
>>>
>>> static u32 pci_azx_readl(u32 __iomem *addr)
>>> {
>>>     return readl(addr);
>>> }
>>>
>>> Can you show me how I can properly place printk without breaking things
>>> and produce relevant messages?
>>
>> Something like:
>>
>> static u32 pci_azx_readl(u32 __iomem *addr)
>> {
>>     u32 val =3D readl(addr);
>>     pr_info("XXX readl %p %x\n", addr, val);
>>     return val;
>> }
>>
>> But since there are quite lots of accesses, it might be safer to use
>> the ratelimited version.  Use like the following:
>>     pr_info_ratelimited("XXX readl %p %x\n", addr, val);
>>
>> Also there are variants pci_azx_readw() and _readb().
>>
>>
>> Takashi
>>
>
> These are the mods I made...
>
> /* PCI register access. */
> static void pci_azx_writel(u32 value, u32 __iomem *addr)
> {
>      writel(value, addr);
>      pr_info_ratelimited("XXX writel %p %x\n", addr, val);
>      return val;
> }
>
> static u32 pci_azx_readl(u32 __iomem *addr)
> {
>      return readl(addr);
>      pr_info_ratelimited("XXX readl %p %x\n", addr, val);
>      return val;
> }
>
> static void pci_azx_writew(u16 value, u16 __iomem *addr)
> {
>      writew(value, addr);
>      pr_info_ratelimited("XXX writew %p %x\n", addr, val);
>      return val;
> }
>
> static u16 pci_azx_readw(u16 __iomem *addr)
> {
>      return readw(addr);
>      pr_info_ratelimited("XXX readw %p %x\n", addr, val);
>      return val;
> }
>
> static void pci_azx_writeb(u8 value, u8 __iomem *addr)
> {
>      writeb(value, addr);
>      pr_info_ratelimited("XXX writeb %p %x\n", addr, val);
>      return val;
> }
>
> static u8 pci_azx_readb(u8 __iomem *addr)
> {
>      return readb(addr);
>      pr_info_ratelimited("XXX readb %p %x\n", addr, val);
>      return val;
> }
>
> But I am getting errors for each pci_azx value...
>
> In file included from include/linux/kernel.h:13:0,
>                   from include/linux/delay.h:10,
>                   from sound/pci/hda/hda_intel.c:37:
> sound/pci/hda/hda_intel.c: In function =91pci_azx_writel=92:
> sound/pci/hda/hda_intel.c:1701:50: error: =91val=92 undeclared (first use=
 in
> this function)
>    pr_info_ratelimited("XXX writel %p %x\n", addr, val);
>                                                    ^
> include/linux/printk.h:361:17: note: in definition of macro
> =91printk_ratelimited=92
>     printk(fmt, ##__VA_ARGS__);    \
>                   ^
> sound/pci/hda/hda_intel.c:1701:2: note: in expansion of macro
> =91pr_info_ratelimited=92
>    pr_info_ratelimited("XXX writel %p %x\n", addr, val);
>    ^
> sound/pci/hda/hda_intel.c:1701:50: note: each undeclared identifier is
> reported only once for each function it appears in
>    pr_info_ratelimited("XXX writel %p %x\n", addr, val);
>                                                    ^
> include/linux/printk.h:361:17: note: in definition of macro
> =91printk_ratelimited=92
>     printk(fmt, ##__VA_ARGS__);    \
>                   ^
> sound/pci/hda/hda_intel.c:1701:2: note: in expansion of macro
> =91pr_info_ratelimited=92
>    pr_info_ratelimited("XXX writel %p %x\n", addr, val);
>    ^
> sound/pci/hda/hda_intel.c:1702:2: warning: =91return=92 with a value, in
> function returning void [enabled by default]
>    return val;
>    ^
>

Ack! Premature post. Already seeing where I made mistakes. Sorry, very =

unfamiliar with C :(

-Alnie
