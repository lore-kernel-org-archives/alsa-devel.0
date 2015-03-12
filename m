From: Alnie <memobook80@comcast.net>
Subject: Re: Issues w/ Creative Labs [SB X-Fi Xtreme Audio]
	CA0110-IBG
Date: Wed, 11 Mar 2015 20:59:58 -0700
Message-ID: <55010F3E.7070504@comcast.net>
References: <54F52C68.6010504@comcast.net>	<s5hzj7u7grx.wl-tiwai@suse.de>	<54F5614C.9010402@comcast.net>	<s5hwq2y7c8g.wl-tiwai@suse.de>	<54F57D07.9020900@comcast.net>	<54F62CDC.1010607@comcast.net>	<s5hoao97n1j.wl-tiwai@suse.de>	<54F66A0F.1050603@comcast.net>	<s5hk2yx6vld.wl-tiwai@suse.de>	<54F6C9EC.3080100@comcast.net>	<s5hegp56r78.wl-tiwai@suse.de>	<54FA38D4.6090206@comcast.net>	<s5hoao5z1dv.wl-tiwai@suse.de>	<54FB272D.1080004@comcast.net>	<s5hfv9gzs2e.wl-tiwai@suse.de>	<54FB3E0F.4060101@comcast.net>	<54FDBABA.2080707@comcast.net>
 <s5hfv9e9n56.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from resqmta-po-11v.sys.comcast.net (resqmta-po-11v.sys.comcast.net
 [96.114.154.170])
 by alsa0.perex.cz (Postfix) with ESMTP id EAA7D2654E0
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 05:00:00 +0100 (CET)
In-Reply-To: <s5hfv9e9n56.wl-tiwai@suse.de>
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



On 03/09/2015 09:00 AM, Takashi Iwai wrote:
> At Mon, 09 Mar 2015 08:22:34 -0700,
> Alnie wrote:
>>
>> On 03/07/2015 10:06 AM, Alnie wrote:
>>> On 03/07/2015 08:32 AM, Takashi Iwai wrote:
>>>> At Sat, 07 Mar 2015 08:28:29 -0800,
>>>> Alnie wrote:
>>>>>
>>>>> On 03/06/2015 11:56 PM, Takashi Iwai wrote:
>>>>>> At Fri, 06 Mar 2015 15:31:32 -0800,
>>>>>> Alnie wrote:
>>>>>>>
>>>>>>> On 03/04/2015 01:35 AM, Takashi Iwai wrote:
>>>>>>>> At Wed, 04 Mar 2015 01:01:32 -0800,
>>>>>>>> Alnie wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 03/04/2015 12:00 AM, Takashi Iwai wrote:
>>>>>>>>>> At Tue, 03 Mar 2015 18:12:31 -0800,
>>>>>>>>>> Alnie wrote:
>>>>>>>>>>>
>>>>>>>>>>>> My suggestion isn't about a compile option but that you add
>>>>>>>>>>>> some debug
>>>>>>>>>>>> printk() calls manually around some codes.  We need to know
>>>>>>>>>>>> the value
>>>>>>>>>>>> written and read by azx_write*() and azx_read*() calls.
>>>>>>>>>>>> Especially
>>>>>>>>>>>> the value read in pci_azx_read*() is more interesting. You can
>>>>>>>>>>>> try to
>>>>>>>>>>>> modify sound/pci/hda/hda_intel.c and add a printk() to each
>>>>>>>>>>>> pci_azx_read*() function for printing the value to be returned.
>>>>>>>>>>>> Beware that this will likely flood many messages, so just try
>>>>>>>>>>>> once.
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Takashi
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I can not find any reference to pci_azx_read in hda_intel.c
>>>>>>>>>>
>>>>>>>>>> You must be using a too old kernel, then.  Please use the latest
>>>>>>>>>> kernel for debugging.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Takashi
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Ok. I now have latest kernel.
>>>>>>>>>
>>>>>>>>> Here is a small portion...
>>>>>>>>>
>>>>>>>>> /* PCI register access. */
>>>>>>>>> static void pci_azx_writel(u32 value, u32 __iomem *addr)
>>>>>>>>> {
>>>>>>>>>      writel(value, addr);
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> static u32 pci_azx_readl(u32 __iomem *addr)
>>>>>>>>> {
>>>>>>>>>      return readl(addr);
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> Can you show me how I can properly place printk without breaking
>>>>>>>>> things
>>>>>>>>> and produce relevant messages?
>>>>>>>>
>>>>>>>> Something like:
>>>>>>>>
>>>>>>>> static u32 pci_azx_readl(u32 __iomem *addr)
>>>>>>>> {
>>>>>>>>      u32 val = readl(addr);
>>>>>>>>      pr_info("XXX readl %p %x\n", addr, val);
>>>>>>>>      return val;
>>>>>>>> }
>>>>>>>>
>>>>>>>> But since there are quite lots of accesses, it might be safer to use
>>>>>>>> the ratelimited version.  Use like the following:
>>>>>>>>      pr_info_ratelimited("XXX readl %p %x\n", addr, val);
>>>>>>>>
>>>>>>>> Also there are variants pci_azx_readw() and _readb().
>>>>>>>>
>>>>>>>>
>>>>>>>> Takashi
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Ok, I was only able to guess through the code for the read values. If
>>>>>>> you need write information too please show me how.
>>>>>>> here are the mods I made...
>>>>>>>
>>>>>>> /* PCI register access. */
>>>>>>> static void pci_azx_writel(u32 value, u32 __iomem *addr)
>>>>>>> {
>>>>>>>      writel(value, addr);
>>>>>>> }
>>>>>>>
>>>>>>> static u32 pci_azx_readl(u32 __iomem *addr)
>>>>>>> {
>>>>>>>         u32 val = readl(addr);
>>>>>>>         pr_info_ratelimited("XXX readl %p %x\n", addr, val);
>>>>>>>         return val;
>>>>>>> }
>>>>>>>
>>>>>>> static void pci_azx_writew(u16 value, u16 __iomem *addr)
>>>>>>> {
>>>>>>>      writew(value, addr);
>>>>>>> }
>>>>>>>
>>>>>>> static u16 pci_azx_readw(u16 __iomem *addr)
>>>>>>> {
>>>>>>>      u16 val = readw(addr);
>>>>>>>      pr_info_ratelimited("XXX readw %p %x\n", addr, val);
>>>>>>>      return val;
>>>>>>> }
>>>>>>>
>>>>>>> static void pci_azx_writeb(u8 value, u8 __iomem *addr)
>>>>>>> {
>>>>>>>      writeb(value, addr);
>>>>>>> }
>>>>>>>
>>>>>>> static u8 pci_azx_readb(u8 __iomem *addr)
>>>>>>> {
>>>>>>>      u8 val = readb(addr);
>>>>>>>      pr_info_ratelimited("XXX readb %p %x\n", addr, val);
>>>>>>>      return val;
>>>>>>> }
>>>>>>>
>>>>>>> and i was able to produce this...
>>>>>>>
>>>>>>> dmesg | grep -i read
>>>>>>> [    0.764102] tpm_tis 00:05: A TPM error (7) occurred attempting to
>>>>>>> read a pcr value
>>>>>>> [    0.769674] Write protecting the kernel read-only data: 12288k
>>>>>>> [    1.729952] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
>>>>>>> enabled, doesn't support DPO or FUA
>>>>>>> [    2.071100] sd 1:0:0:0: [sdb] Write cache: enabled, read cache:
>>>>>>> enabled, doesn't support DPO or FUA
>>>>>>> [    2.778875] EXT4-fs (sda5): INFO: recovery required on readonly
>>>>>>> filesystem
>>>>>>> [    2.817982] EXT4-fs (sda5): orphan cleanup on readonly fs
>>>>>>> [    4.662442] XXX readw ffffc90004f30000 4401
>>>>>>
>>>>>> This reads good, but I thought you have two sound devices (onboard and
>>>>>> Creative)?  If so, disable the onboard one via enable=0 option (if the
>>>>>> onboard one is assigned first).  Otherwise the all good and bad
>>>>>> results are mixed up.
>>>>>>
>>>>>>
>>>>>> Takashi
>>>>>>
>>>>>
>>>>> I included options snd-hda-intel enable=0 index=0
>>>>>
>>>>> This is dmesg output (1b is onboard)...
>>>>> dmesg | grep -i hda
>>>>> [    3.700213] snd_hda_intel: probe of 0000:00:1b.0 failed with error -2
>>>>> [   37.729507] snd_hda_intel 0000:06:00.0: enabling device (0000 ->
>>>>> 0002)
>>>>> [   37.729703] snd_hda_intel 0000:06:00.0: enabling bus mastering
>>>>> [   37.736026] snd_hda_intel 0000:06:00.0: CORB reset timeout#1,
>>>>> CORBRP = 0
>>>>> [   38.740090] snd_hda_intel 0000:06:00.0: Codec #1 probe error;
>>>>> disabling it...
>>>>> [   38.747292] snd_hda_intel 0000:06:00.0: CORB reset timeout#1,
>>>>> CORBRP = 0
>>>>> [   43.776089] snd_hda_intel 0000:06:00.0: no AFG or MFG node found
>>>>> [   43.776111] snd_hda_intel 0000:06:00.0: no codecs initialized
>>>>>
>>>>> dmesg | grep -i XXX
>>>>> [   37.729723] XXX readw ffffc90005188000 3300
>>>>> [   37.729768] XXX readl ffffc90005188008 0
>>>>
>>>> OK, so all read look fine.  Right now we saw a bug report with git
>>>> bisection showing a bad commit in HD-audio controller code.  This
>>>> might be your issue, too.  Could you try the following oneliner?
>>>>
>>>>
>>>> thanks,
>>>>
>>>> Takashi
>>>>
>>>> diff --git a/sound/pci/hda/hda_controller.c
>>>> b/sound/pci/hda/hda_controller.c
>>>> index 7b4377265b25..57c4575fac26 100644
>>>> --- a/sound/pci/hda/hda_controller.c
>>>> +++ b/sound/pci/hda/hda_controller.c
>>>> @@ -1194,7 +1194,7 @@ static unsigned int azx_rirb_get_response(struct
>>>> hda_bus *bus,
>>>>            }
>>>>        }
>>>>
>>>> -    if (!bus->no_response_fallback)
>>>> +    if (bus->no_response_fallback)
>>>>            return -1;
>>>>
>>>>        if (!chip->polling_mode && chip->poll_count < 2) {
>>>>
>>>
>>>
>>> I believe I applied the patch correctly... if you would like to double
>>> check here is the hda_controller.c file (http://pastebin.com/NA7AV2n1)
>>>
>>> Same complaint comes up, after reinsert and force-reload as well...
>>>
>>> [  419.344572] snd_hda_intel 0000:06:00.0: enabling bus mastering
>>> [  419.350967] snd_hda_intel 0000:06:00.0: CORB reset timeout#1, CORBRP = 0
>>> [  422.360107] snd_hda_intel 0000:06:00.0: azx_get_response timeout,
>>> switching to polling mode: last cmd=0x100f0000
>>> [  423.364094] snd_hda_intel 0000:06:00.0: Codec #1 probe error;
>>> disabling it...
>>> [  423.371128] snd_hda_intel 0000:06:00.0: CORB reset timeout#1, CORBRP = 0
>>> [  424.376098] snd_hda_intel 0000:06:00.0: azx_get_response timeout,
>>> switching to single_cmd mode: last cmd=0x100f0000
>>> [  424.377052] snd_hda_intel 0000:06:00.0: no AFG or MFG node found
>>> [  424.377067] snd_hda_intel 0000:06:00.0: no codecs initialized
>>>
>>
>> I'm assuming we've exhausted our options for now. It seems probable this
>> model card (ExpressCard/54) never worked in Linux to begin with. I
>> looked over the forum posts from those claiming they had it operational
>> (in 2.6 kernel), but it was for the PCI-E version. I greatly appreciate
>> your assistance with this. Thank you.
>
> Yes, some PCI-e version has worked, I personally tested it once.
> But yours is apparently a different one, and we finally go back to the
> starting point again.
>
> What you need to do from now on is to analyze why the codec probe
> fails.  It failed even with single_cmd mode.  This is strange, but it
> might be that the board is never 100% compliant, so it might not
> support that mode.
>
> There are some workarounds done specific to the Creative devices.  For
> example, azx_init_cmd_io() in hda_controller.c has a special handling
> to set RIRB interrupt count to 0xc0.  I guess this needs to be set
> normally.  That is, disable the following if () check, and run always
> azx_writew(chip, RINTCNT, 1) instead:
>
> 	if (chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND)
> 		azx_writew(chip, RINTCNT, 0xc0);
> 	else
> 		azx_writew(chip, RINTCNT, 1);

This modification alone produced the same complaint. These are the edits 
I made...

	/* set N=1, get RIRB response interrupt for new entry */
	//if (chip->driver_caps & AZX_DCAPS_CTX_WORKAROUND)
		//azx_writew(chip, RINTCNT, 0xc0);
	//else
	azx_writew(chip, RINTCNT, 1);

>
> There is another workaround in azx_pcm_prepare() for the capture
> streams, but this is irrelevant as of now -- we're concentrating only
> on the codec probe issue.
>
> If modifying above still doesn't work, you may try to force continuing
> the probe by removing -EIO return from probe_codec() in
> hda_controller.c.  That is, remove the following line from that
> function:
>
> 	if (res == -1)
> 		return -EIO;

This is the edit I made...

	mutex_unlock(&chip->bus->cmd_mutex);
	//if (res == -1)
		//return -EIO;
	dev_dbg(chip->card->dev, "codec #%d probed OK\n", addr);

I assume I did this correctly, but here is the full hda_controller.c I 
compiled if you would like to double check http://pastebin.com/fvVVA1Ew

>
> Of course, it doesn't mean this would work, but we can see whether the
> board reacts somehow better.
>

Same complaint comes up.

[    7.600051] snd_hda_intel 0000:06:00.0: azx_get_response timeout, 
switching to polling mode: last cmd=0x100f0000
[    9.608050] snd_hda_intel 0000:06:00.0: azx_get_response timeout, 
switching to single_cmd mode: last cmd=0x100f0000
[    9.609976] snd_hda_intel 0000:06:00.0: no AFG or MFG node found
[    9.611023] snd_hda_intel 0000:06:00.0: no codecs initialized
[   10.776445] init: alsa-restore main process (1461) terminated with 
status 19
